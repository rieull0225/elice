import 'package:elice/course_free_view.dart';
import 'package:elice/course_recommend_view.dart';
import 'package:elice/home_view.dart';
import 'package:go_router/go_router.dart';

final router = GoRouter(
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => HomeView(),
    ),
    GoRoute(
      path: '/freeCourse',
      builder: (context, state) => CourseFreeView(),
    ),
    GoRoute(
      path: '/recommendCourse',
      builder: (context, state) => CourseRecommendView(),
    ),
  ],
);
