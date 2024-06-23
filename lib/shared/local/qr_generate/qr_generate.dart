import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:typed_data';

import 'package:flutter/material.dart';

class QRCodeGenerator extends StatefulWidget {
  const QRCodeGenerator({super.key});

  @override
  _QRCodeGeneratorState createState() => _QRCodeGeneratorState();
}

class _QRCodeGeneratorState extends State<QRCodeGenerator> {
  Uint8List? _qrImage;
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _startTimer();
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  void _startTimer() {
    _timer = Timer.periodic(const Duration(seconds: 5), (Timer timer) {
      _fetchQRCode();
    });
  }

  Future<void> _fetchQRCode() async {
    try {
      final response = await http.get(
        Uri.parse('http://127.0.0.1:5000/get_qr'), // Adjust URL if necessary
      );

      if (response.statusCode == 200) {
        setState(() {
          _qrImage = response.bodyBytes;
        });
      } else {
        print('Failed to fetch QR code: ${response.statusCode}');
        throw Exception('Failed to fetch QR code');
      }
    } catch (e) {
      print('Error: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('QR Code Generator'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _qrImage != null
                ? Image.memory(_qrImage!)
                : const CircularProgressIndicator(),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _fetchQRCode,
              child: const Text('Refresh QR Code'),
            ),
          ],
        ),
      ),
    );
  }
}
