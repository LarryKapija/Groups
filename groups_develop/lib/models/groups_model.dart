import 'package:groups_develop/models/student_model.dart';

class Group {
  String id;
  List<Student> students;
  List<String> themes;

  Group(this.id, this.students, this.themes);

  @override
  String toString() {
    return 'Grupo $id - ${themes.length} tema${themes.length > 1 ? 's' : ''} - ${students.length} estudiante${students.length > 1 ? 's' : ''}.';
  }
}
