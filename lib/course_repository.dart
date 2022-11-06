class Course {
  late List<CourseStat> courses;
  late int course_count;
  late var result;

  Course(
      {required this.courses,
      required this.course_count,
      required this.result});

  Course.fromMap(Map<String, dynamic>? map) {
    courses = map?['courses'] ?? '';
    course_count = map?['course_count'] ?? '';
    result = map?['_result'] ?? '';
  }
}

class CourseStat {
  late String logoFileUrl; // logo_file_url
  late String title;
  late List instructors;

  CourseStat(
      {required this.logoFileUrl,
      required this.title,
      required this.instructors});

  CourseStat.fromMap(Map<String, dynamic> json) {
    logoFileUrl = json['logo_file_url'] ?? '';
    title = json['title'] ?? '';
    instructors = json['instructors'] ?? [];
  }
}
