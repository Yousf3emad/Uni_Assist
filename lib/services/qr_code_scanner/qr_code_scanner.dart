import 'package:flutter/foundation.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';

class QRCodeScanner {
  static void scan() async{
    try {
      String data = await FlutterBarcodeScanner.scanBarcode(
        "#2A99CF",
        "Cancel",
        true,
        ScanMode.QR,
      );
      debugPrint("Data is: $data");
    } catch (e) {
      debugPrint("Error is : ${e.toString()}",);
    }
  }
}
