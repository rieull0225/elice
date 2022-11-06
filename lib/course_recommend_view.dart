import 'package:elice/base_widget.dart';
import 'package:elice/course_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class CourseRecommendViewModel with ChangeNotifier {
  CourseRecommendViewModel() {
    init();
  }

  final CourseProvider courseProvider = CourseProvider();
  Future init() async {
    recommendCourse = await courseProvider.getRecommendCourse();
    scrollController.addListener(() {
      if (scrollController.position.pixels ==
          scrollController.position.maxScrollExtent) {
        onLoading();
      }
    });

    notifyListeners();
  }

  RefreshController refreshController = RefreshController();
  ScrollController scrollController = ScrollController();

  void onRefresh() async {
    recommendCourse = await courseProvider
        .getMoreRecommendCourse(recommendCourse.length + 10);
    refreshController.refreshCompleted();
    notifyListeners();
  }

  void onLoading() async {
    recommendCourse = await courseProvider
        .getMoreRecommendCourse(recommendCourse.length + 10);
    refreshController.loadComplete();
    notifyListeners();
  }

  late List recommendCourse = [];
}

class CourseRecommendView extends BaseView<CourseRecommendViewModel> {
  CourseRecommendView({Key? key}) : super(key: key);

  @override
  CourseRecommendViewModel createViewModel(BuildContext context) =>
      CourseRecommendViewModel();

  @override
  PreferredSizeWidget? appBar(BuildContext context) {
    return AppBar(
      foregroundColor: const Color(0xff202044),
      backgroundColor: const Color(0xff202044),
      elevation: 0,
      leading: BackButton(
        color: Colors.white,
        onPressed: () => Navigator.pop(context),
      ),
      title: const Text(
        '추천 과목',
        style: TextStyle(
            color: Colors.white, fontSize: 16, fontWeight: FontWeight.w700),
      ),
      centerTitle: true,
    );
  }

  @override
  Widget buildBody(BuildContext context) {
    return Selector<CourseRecommendViewModel, List>(
        selector: (p0, p1) => p1.recommendCourse,
        builder: (context, value, child) {
          return SmartRefresher(
            controller: vm(context).refreshController,
            enablePullDown: true,
            enablePullUp: true,
            onRefresh: () => vm(context).onRefresh(),
            onLoading: () => vm(context).onLoading(),
            header: const WaterDropHeader(),
            child: Container(
              child: ListView.builder(
                controller: vm(context).scrollController,
                itemCount: vm(context).recommendCourse.length,
                itemBuilder: (_, idx) {
                  return _buildCourseCard(
                      context, vm(context).recommendCourse[idx]);
                },
              ),
            ),
          );
        });
  }

  Widget _buildCourseCard(context, Map<String, dynamic> course) {
    List teacher = course['instructors'];
    String title = course['title'];
    String? logoUrl = course['logo_file_url'];
    return InkWell(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 14),
        child: Container(
          width: MediaQuery.of(context).size.width,
          height: 120,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              children: [
                Container(
                  width: 88,
                  height: 88,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(4),
                    color: const Color(0xfff0f0f0),
                  ),
                  child: logoUrl != null
                      ? Image.network(logoUrl)
                      : Image.asset('asset/image/course.png'),
                ),
                const SizedBox(
                  width: 16,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      width: MediaQuery.of(context).size.width - 180,
                      child: RichText(
                        maxLines: 2,
                        strutStyle: const StrutStyle(
                            fontSize: 16, fontWeight: FontWeight.w700),
                        text: TextSpan(
                            text: title,
                            style: const TextStyle(color: Colors.black)),
                      ),
                    ),
                    const Spacer(),
                    Text(
                      teacher.isEmpty ? '선생님 미등록' : teacher[0]['fullname'],
                      style: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                          color: Color(0xff7e7e7e)),
                    ),
                    const SizedBox(height: 5),
                    Container(
                        width: 48,
                        height: 22,
                        decoration: BoxDecoration(
                          color: const Color(0xff0078b5),
                          borderRadius: BorderRadius.circular(2),
                        ),
                        child: const Center(
                          child: Text(
                            '오프라인',
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 10,
                                fontWeight: FontWeight.w700),
                          ),
                        ))
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
