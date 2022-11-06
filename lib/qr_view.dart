import 'package:elice/home_view.dart';
import 'package:elice/qr_reader.dart';
import 'package:elice/viewmodel_provider_mixin.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class QrView extends StatelessWidget with ViewModelMixin<CourseViewModel> {
  QrView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(children: [
      Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        color: Color(0xff000000),
      ),
      Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          QrReader(),
          Text(
            'QR코드를 인식해주세요',
            style: TextStyle(color: Colors.yellow),
          )
        ],
      )
    ]);
  }
}
