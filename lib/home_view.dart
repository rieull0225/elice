import 'package:elice/base_widget.dart';
import 'package:elice/chage_theme_button.dart';
import 'package:elice/course_provider.dart';
import 'package:elice/course_view.dart';
import 'package:elice/qr_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';

class CourseViewModel with ChangeNotifier {
  CourseViewModel() {
    init();
  }

  CourseProvider courseProvider = CourseProvider();

  Future init() async {
    recommendCourse = await courseProvider.getRecommendCourse();
    freeCourse = await courseProvider.getFreeCourse();
    notifyListeners();
  }

  late List recommendCourse = [];
  late List freeCourse = [];

  int _index = 0;

  int get index => _index;

  set index(value) {
    _index = value;
    notifyListeners();
  }

  bool _isQrPressed = false;

  bool get isQrPressed => _isQrPressed;

  set isQrPressed(value) {
    _isQrPressed = value;
    notifyListeners();
  }

  void tapIndex(int idx) {
    index = idx;
    notifyListeners();
  }

  List<Widget> bodyContent = [
    const CourseView(),
    QrView(),
  ];
}

class HomeView extends BaseView<CourseViewModel> {
  HomeView({Key? key}) : super(key: key);

  @override
  CourseViewModel createViewModel(BuildContext context) => CourseViewModel();

  @override
  PreferredSizeWidget? appBar(BuildContext context) {
    return AppBar(
      centerTitle: true,
      elevation: 0,
      title: Selector<CourseViewModel, int>(
          selector: (p0, p1) => p1.index,
          builder: (context, value, child) {
            return value == 0
                ? Text(
                    'Change Theme Button',
                  )
                : Text(
                    'QR',
                  );
          }),
      actions: [
        ChangeThemeButton(),
      ],
    );
  }

  @override
  Widget buildBody(BuildContext context) {
    return Selector<CourseViewModel, int>(
        selector: (p0, p1) => p1.index,
        builder: (context, child, value) {
          return Scaffold(
            body: SafeArea(
              child: vm(context).bodyContent[vm(context).index],
            ),
            bottomNavigationBar: BottomNavigationBar(
              items: [
                BottomNavigationBarItem(
                  icon: Padding(
                    padding: EdgeInsets.only(bottom: 5.89),
                    child: SizedBox(
                      width: 19,
                      child: Icon(
                        Icons.account_balance,
                        color: vm(context).index == 0
                            ? Color(0xff524aa1)
                            : Color(0xff8d8a8a),
                      ),
                    ),
                  ),
                  label: 'Home',
                ),
                BottomNavigationBarItem(
                  icon: Padding(
                    padding: const EdgeInsets.only(bottom: 6.75),
                    child: SizedBox(
                      width: 19,
                      child: Icon(
                        Icons.camera_alt,
                        color: vm(context).index == 1
                            ? Color(0xff524aa1)
                            : Color(0xff8d8a8a),
                      ),
                    ),
                  ),
                  label: 'QR',
                ),
              ],
              currentIndex: vm(context).index,
              onTap: (value) {
                vm(context).tapIndex(value);
                permission();
              },
              selectedItemColor: const Color(0xff524AA1),
              unselectedItemColor: const Color(0xff8d8a8a),
              selectedIconTheme: const IconThemeData(color: Color(0xff524AA1)),
              unselectedIconTheme:
                  const IconThemeData(color: Color(0xff8d8a8a)),
            ),
          );
        });
  }

  Future<bool> permission() async {
    Map<Permission, PermissionStatus> status =
        await [Permission.camera].request(); // [] 권한배열에 권한을 작성

    if (await Permission.camera.isGranted) {
      return Future.value(true);
    } else {
      return Future.value(false);
    }
  }
}
