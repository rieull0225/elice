import 'dart:convert';

import 'package:elice/course_repository.dart';
import 'package:http/http.dart' as http;

class CourseProvider {
  Future<List> getRecommendCourse() async {
    late CourseStat courseStat;
    late List course;
    const baseUrl =
        'https://api-rest.elice.io/org/academy/course/list/?filter_is_free=false&filter_is_recommended=true&offset=0&count=10';
    http.Response response = await http
        .get(Uri.parse(baseUrl), headers: {"Accept": "application/json"});
    if (response.statusCode == 200) {
      course = jsonDecode(response.body)['courses'];
      print('Recommend : ${course}');
    }
    return course;
  }

  Future<List> getFreeCourse() async {
    late CourseStat courseStat;
    late List course;
    const baseUrl =
        'https://api-rest.elice.io/org/academy/course/list/?filter_is_free=true&filter_is_recommended=false&offset=0&count=10 ';
    http.Response response = await http
        .get(Uri.parse(baseUrl), headers: {"Accept": "application/json"});
    if (response.statusCode == 200) {
      course = jsonDecode(response.body)['courses'];
      print('free : ${course}');
    }
    return course;
  }

  //
  // Future<List<News>> getNews() async {
  //   List<News> news = [];
  //
  //   final response = await http.get(uri);
  //
  //   if (response.statusCode == 200) {
  //     news = jsonDecode(response.body)['articles'].map<News>( (article) {
  //       return News.fromMap(article);
  //     }).toList();
  //   }
  //
  //   return news;
  // }

  void getRecommendCourses() async {
    const baseUrl =
        'https://api-rest.elice.io/org/academy/course/list/?filter_is_free=false&filter_is_recommended=true&offset=0&count=10';
    http.Response response = await http
        .get(Uri.parse(baseUrl), headers: {"Accept": "application/json"});
    Map<String, dynamic> responseBodyMap = jsonDecode(response.body);

    print(response.body); // 결과 출력 ==> {"restapi" : "get" }
    print(responseBodyMap["restapi"]); // 결과 출력 ==> get
  }

  void getFreeCourses() async {
    const baseUrl =
        'https://api-rest.elice.io/org/academy/course/list/?filter_is_free=true&filter_is_recommended=false&offset=0&count=10 ';
    http.Response response = await http
        .get(Uri.parse(baseUrl), headers: {"Accept": "application/json"});
    Map<String, dynamic> responseBodyMap = jsonDecode(response.body);

    print(response.body); // 결과 출력 ==> {"restapi" : "get" }
    print(responseBodyMap["restapi"]); // 결과 출력 ==> get
  }
}
