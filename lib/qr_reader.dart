import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'package:url_launcher/url_launcher.dart';

class QrReader extends StatefulWidget {
  const QrReader({Key? key}) : super(key: key);

  @override
  State<QrReader> createState() => _QrReaderState();
}

class _QrReaderState extends State<QrReader> {
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
  QRViewController? controller;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          Container(
            width: 400,
            height: 400,
            child: QRView(
              key: qrKey,
              onQRViewCreated: _onQRViewCreated,
            ),
          ),
        ],
      ),
    );
  }

  void _onQRViewCreated(QRViewController controller) {
    this.controller = controller;
    controller.scannedDataStream.listen((event) {
      try {
        _launchUrl(Uri.parse(_decoder(event.code!)));
      } on Exception {
        _launchUrl(Uri.parse(event.code!));
      }
      print('result=${event.code}');
      print('parse =${_decoder(event.code!)} ');
    });
  }

  Future<void> _launchUrl(url) async {
    if (!await launchUrl(
      url,
      mode: LaunchMode.inAppWebView,
    )) {
      throw 'Could not launch $url';
    }
  }

  String _decoder(String encoding) {
    var decoded = base64.decode(encoding);
    return utf8.decode(decoded);
  }
}
