import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:uni_assest/shared/remote/api_manager.dart';

class QRCodeScanner {
  static void scan() async {
    try {
      String data = await FlutterBarcodeScanner.scanBarcode(
        "#2A99CF",
        "Cancel",
        true,
        ScanMode.QR,
      );

      if (data == '-1') {
        print("Scan cancelled");
        return;
      }

      // Convert String data to a Map
      Map<String, dynamic> mapData = jsonDecode(data);
      print("Data =====>>>> $mapData");

      String responseMessage = await ApiManager.updateAttendance(
        subjectName: mapData['subjectName'],
        type: mapData['type'],
        weekNum: "${mapData['week']}",
      );
      print("Response from server: $responseMessage");
    } catch (e) {
      debugPrint("Error is : ${e.toString()}");
    }
  }
}

