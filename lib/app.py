from flask import Flask, send_file, jsonify, request
from flask_cors import CORS
import qrcode
from PIL import Image
import io
import threading
import time
import json

app = Flask(__name__)
CORS(app)  # Enable CORS for all routes

current_qr_code = None
qr_data = {
    "type": "",
    "subjectName": "",
    "week": "",
}

def generate_qr_code():
    global current_qr_code
    while True:
        data = qr_data.copy()
        data["timestamp"] = time.time()  # Unique timestamp to ensure QR code changes
        qr = qrcode.QRCode(
            error_correction=qrcode.constants.ERROR_CORRECT_L,
            version=6,
            box_size=10,
            border=4,
        )
        qr.add_data(json.dumps(data))
        qr.make(fit=True)
        img = qr.make_image(fill_color="black", back_color="white")

        img_io = io.BytesIO()
        img.save(img_io, 'PNG')
        img_io.seek(0)
        current_qr_code = img_io

        time.sleep(5)  # Generate a new QR code every 5 seconds

@app.route('/set_qr_data', methods=['POST'])
def set_qr_data():
    global qr_data
    qr_data = request.json
    return jsonify({"status": "QR data updated"}), 200

@app.route('/get_qr', methods=['GET'])
def get_qr():
    global current_qr_code
    if current_qr_code:
        return send_file(current_qr_code, mimetype='image/png')
    else:
        return jsonify({"error": "QR code not generated yet"}), 503

@app.route('/shutdown', methods=['POST'])
def shutdown():
    func = request.environ.get('werkzeug.server.shutdown')
    if func:
        func()
        return 'Server shutting down...'
    else:
        return 'Server shutdown failed', 500

if __name__ == '__main__':
    threading.Thread(target=generate_qr_code, daemon=True).start()
    app.run(debug=True)
