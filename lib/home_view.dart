import 'package:elice/base_widget.dart';
import 'package:elice/course_provider.dart';
import 'package:elice/qr_view.dart';
import 'package:elice/viewmodel_provider_mixin.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';

class CourseViewModel with ChangeNotifier {
  CourseViewModel() {
    init();
  }

  CourseProvider courseProvider = CourseProvider();

  Future init() async {
    recommendCourse = await courseProvider.getRecommendCourse();
    freeCourse = await courseProvider.getFreeCourse();
  }

  late List recommendCourse;
  late List freeCourse;

  int _index = 0;

  int get index => _index;

  set index(value) {
    _index = value;
    notifyListeners();
  }

  void tapIndex(int idx) {
    index = idx;
    notifyListeners();
  }

  List<Widget> bodyContent = [
    const CourseView(),
    const QrView(),
  ];
}

class HomeView extends BaseView<CourseViewModel> {
  HomeView({Key? key}) : super(key: key);

  @override
  CourseViewModel createViewModel(BuildContext context) => CourseViewModel();

  @override
  PreferredSizeWidget? appBar(BuildContext context) {
    return AppBar(
      foregroundColor: Colors.white,
      backgroundColor: Colors.white,
      elevation: 0,
      title: SizedBox(width: 108, child: Image.asset('asset/image/logo.png')),
      actions: [
        IconButton(
            onPressed: () {},
            icon: SizedBox(
                height: 20, child: Image.asset('asset/image/noti.png')))
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
                    padding: const EdgeInsets.only(bottom: 5.89),
                    child: SizedBox(
                        width: 19,
                        child: vm(context).index == 0
                            ? Image.asset('asset/image/course_icon.png')
                            : Image.asset('asset/image/course_inactive.png')),
                  ),
                  label: 'Home',
                ),
                BottomNavigationBarItem(
                  icon: Padding(
                    padding: const EdgeInsets.only(bottom: 6.75),
                    child: SizedBox(
                        width: 19,
                        child: vm(context).index == 1
                            ? Image.asset('asset/image/qr_icon.png')
                            : Image.asset('asset/image/qr_inactive.png')),
                  ),
                  label: 'QR',
                ),
              ],
              currentIndex: vm(context).index,
              onTap: (value) => vm(context).tapIndex(value),
              selectedItemColor: const Color(0xff524AA1),
              unselectedItemColor: const Color(0xff8d8a8a),
              selectedIconTheme: const IconThemeData(color: Color(0xff524AA1)),
              unselectedIconTheme:
                  const IconThemeData(color: Color(0xff8d8a8a)),
            ),
          );
        });
  }
}

class CourseView extends StatelessWidget with ViewModelMixin<CourseViewModel> {
  const CourseView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    int maxRecNum = vm(context).recommendCourse.length > 10
        ? 10
        : vm(context).recommendCourse.length;
    int maxFreeNum =
        vm(context).freeCourse.length > 10 ? 10 : vm(context).freeCourse.length;
    return Selector<CourseViewModel, List>(
        selector: (p0, p1) => p1.recommendCourse,
        builder: (context, value, child) {
          return Column(
            children: [
              const SizedBox(height: 11),
              Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 11, horizontal: 16),
                child: Row(
                  children: [
                    Text(
                      '추천 과목',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 12,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    Spacer(),
                    InkWell(
                      onTap: () {},
                      child: Text(
                        '전체 보기',
                        style: TextStyle(
                            color: Color(0xff564EA9),
                            fontSize: 10,
                            fontWeight: FontWeight.w400),
                      ),
                    )
                  ],
                ),
              ),
              SizedBox(
                height: 200,
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  children: [
                    for (int i = 0; i < maxRecNum; ++i)
                      _buildCourseCard(vm(context).recommendCourse[i]),
                  ],
                ),
              ),
              const SizedBox(height: 24),
              Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 11, horizontal: 16),
                child: Row(
                  children: [
                    const Text(
                      '무료 과목',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 12,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    const Spacer(),
                    InkWell(
                      onTap: () {},
                      child: const Text(
                        '전체 보기',
                        style: TextStyle(
                            color: Color(0xff564EA9),
                            fontSize: 10,
                            fontWeight: FontWeight.w400),
                      ),
                    )
                  ],
                ),
              ),
              SizedBox(
                height: 200,
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  children: [
                    for (int i = 0; i < maxFreeNum; ++i)
                      _buildCourseCard(vm(context).freeCourse[i]),
                  ],
                ),
              ),
            ],
          );
        });
  }

  Widget _buildCourseCard(Map<String, dynamic> course) {
    List teacher = course['instructors'];
    String title = course['title'];
    String? logoUrl = course['logo_file_url'];
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 6.5),
      child: InkWell(
        onTap: () {},
        child: Column(
          children: [
            Container(
              width: 160,
              height: 136,
              decoration: const BoxDecoration(
                color: Color(0xff938DD0),
                borderRadius: BorderRadius.vertical(
                  top: Radius.circular(8),
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      width: 44,
                      height: 44,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: logoUrl != null
                          ? Image.network(logoUrl)
                          : Image.asset('asset/image/course.png'),
                    ),
                    const SizedBox(height: 14),
                    Text(
                      title,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.w700),
                    )
                  ],
                ),
              ),
            ),
            Container(
              width: 160,
              height: 64,
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.vertical(
                  bottom: Radius.circular(8),
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      teacher.isEmpty ? '선생님 미등록' : teacher[0]['fullname'],
                      style: TextStyle(
                          color: Color(0xff797a7b),
                          fontSize: 12,
                          fontWeight: FontWeight.w400),
                    ),
                    const SizedBox(height: 6),
                    Container(
                      decoration: BoxDecoration(
                          color: const Color(0xff0078b5),
                          borderRadius: BorderRadius.circular(2)),
                      width: 48,
                      height: 22,
                      child: const Center(
                        child: Text(
                          '오프라인',
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 10,
                              fontWeight: FontWeight.w700),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
