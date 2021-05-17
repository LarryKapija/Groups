import 'package:groups_develop/models/student_model.dart';

class Group {
  String id;
  List<Student> students;
  List<String> themes;

  Group(this.students, this.themes);
}
