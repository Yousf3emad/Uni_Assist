# app.py
from flask import Flask, request, jsonify

app = Flask(__name__)

@app.route('/')
def home():
    return "Hello, this is the Flask backend!"

@app.route('/api', methods=['POST'])
def api():
    data = request.get_json()
    response = {"message": "Data received", "data": data}
    return jsonify(response)

if __name__ == '__main__':
    app.run(debug=True)


# qrcode_generator.py
import qrcode
from PIL import Image

def generate_qrcode(data, filename):
    s = 6
    qr = qrcode.QRCode(
        error_correction=qrcode.constants.ERROR_CORRECT_L,
        version=s,
        box_size=10,
        border=4,
    )
    qr.add_data(data)
    qr.make(fit=True)
    img = qr.make_image(fill_color="black", back_color="white")
    img.save(filename)
    return img



