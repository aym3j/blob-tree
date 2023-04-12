import "dart:io";
import "dart:developer";
import "package:go_router/go_router.dart";
import "package:flutter/material.dart";
import "package:qr_code_scanner/qr_code_scanner.dart";
import 'package:shared_preferences/shared_preferences.dart';
import "package:flutter/foundation.dart";
import 'package:user_app/constants.dart';
import "dart:convert";
import "package:http/http.dart" as http;
import 'package:user_app/utils/auth.dart';

class QRScannerScreen extends StatefulWidget {
  const QRScannerScreen({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _QRScannerScreenState();
}

class _QRScannerScreenState extends State<QRScannerScreen> {
  final GlobalKey qrKey = GlobalKey(debugLabel: "QR");
  String? result;
  QRViewController? controller;

  @override
  void reassemble() {
    super.reassemble();
    if (Platform.isAndroid) {
      controller!.pauseCamera();
    }
    controller!.resumeCamera();
  }

  Widget _buildQrView(BuildContext context) {
    var scanArea = (MediaQuery.of(context).size.width < 400 ||
            MediaQuery.of(context).size.height < 400)
        ? 200.0
        : 300.0;

    return QRView(
      key: qrKey,
      onQRViewCreated: _onQRViewCreated,
      overlay: QrScannerOverlayShape(
        borderColor: Colors.white,
        borderLength: 20,
        borderWidth: 10,
        cutOutSize: scanArea,
        overlayColor: Theme.of(context).primaryColor,
      ),
      onPermissionSet: (ctrl, p) => _onPermissionSet(context, ctrl, p),
    );
  }

  void _onQRViewCreated(QRViewController controller) {
    setState(() {
      this.controller = controller;
    });

    controller.scannedDataStream.listen((scanData) async {
      result = scanData.code;
      if (result != null) {
        bool exists = await logIn(result!);
        if (exists) {
          final prefs = await SharedPreferences.getInstance();
          String? workshopName = prefs.getString("workshop_id");

          controller.dispose();
          context.go("/form", extra: workshopName);
        }
      }
    });
  }

  void _onPermissionSet(BuildContext context, QRViewController ctrl, bool p) {
    if (!p) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("no Permission")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: <Widget>[
          SizedBox(height: 180),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 58.0),
            child: Text(
              "Welcome to the blob tree test please select how do you want log into the workshop",
              textAlign: TextAlign.justify,
              style: TextStyle(
                fontSize: 18.0,
              ),
            ),
          ),
          SizedBox(height: 50),
          SizedBox(
            height: 200,
            child: _buildQrView(context),
          ),
          SizedBox(height: 10),
          Text("Scanning..."),
        ],
      ),
    );
  }
}
