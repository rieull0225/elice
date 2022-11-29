import 'package:elice/home_view.dart';
import 'package:elice/qr_reader.dart';
import 'package:elice/viewmodel_provider_mixin.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';

class QrView extends StatelessWidget with ViewModelMixin<CourseViewModel> {
  QrView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Selector<CourseViewModel, bool>(
      selector: (p0, p1) => p1.isQrPressed,
      builder: (context, value, child) {
        return Column(children: [
          Center(
            child: vm(context).isQrPressed
                ? QrReader()
                : Container(
                    width: 400,
                    height: 400,
                  ),
          ),
          GestureDetector(
            onLongPress: () {
              vm(context).isQrPressed = true;
            },
            onLongPressUp: () {
              vm(context).isQrPressed = false;
            },
            child: Container(
              width: 200,
              height: 100,
              child: Center(child: Text('버튼을 길게 눌러주세요')),
            ),
          ),
        ]);
      },
    );
  }
}
