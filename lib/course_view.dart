import 'package:elice/change_font_button.dart';
import 'package:elice/home_view.dart';
import 'package:elice/theme_provider.dart';
import 'package:elice/viewmodel_provider_mixin.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

class CourseView extends StatelessWidget with ViewModelMixin<CourseViewModel> {
  const CourseView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Selector<CourseViewModel, List>(
        selector: (p0, p1) => p1.freeCourse,
        builder: (context, value, child) {
          int maxRecNum = vm(context).recommendCourse.length > 10
              ? 10
              : vm(context).recommendCourse.length;
          int maxFreeNum = vm(context).freeCourse.length > 10
              ? 10
              : vm(context).freeCourse.length;
          return value.isEmpty
              ? const Center(child: CircularProgressIndicator())
              : ListView(
                  children: [
                    const SizedBox(height: 11),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 11, horizontal: 16),
                      child: Row(
                        children: [
                          const Text(
                            '추천 과목',
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          const Spacer(),
                          InkWell(
                            onTap: () {
                              context.push('/recommendCourse');
                              // Navigator.push(
                              //   context,
                              //   MaterialPageRoute(
                              //     builder: (context) => CourseFreeView(),
                              //   ),
                              // );
                            },
                            child: const Text(
                              '전체 보기',
                              style: TextStyle(
                                  fontSize: 10,
                                  fontWeight: FontWeight.w400),
                            ),
                          )
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 200,
                      child: Selector<CourseViewModel, List>(
                          selector: (p0, p1) => p1.recommendCourse,
                          builder: (context, value, child) {
                            return ListView(
                              scrollDirection: Axis.horizontal,
                              children: [
                                for (int i = 0; i < maxRecNum; ++i)
                                  _buildCourseCard(
                                      vm(context).recommendCourse[i]),
                              ],
                            );
                          }),
                    ),
                    const SizedBox(height: 24),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 11, horizontal: 16),
                      child: Row(
                        children: [
                          const Text(
                            '무료 과목',
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          const Spacer(),
                          InkWell(
                            onTap: () {
                              context.push('/freeCourse');
                            },
                            child: const Text(
                              '전체 보기',
                              style: TextStyle(
                                  fontSize: 10, fontWeight: FontWeight.w400),
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
                    Column(
                      children: [
                        IncreaseFontButton(),
                        DecreaseFontButton(),
                        Selector<ThemeProvider, double>(
                            selector: (p0, p1) => p1.fontScale,
                            builder: (_, value, child) {
                              return Text('fontSize : $value');
                            })
                      ],
                    )
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
                      style: const TextStyle(
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
                      style: const TextStyle(
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
