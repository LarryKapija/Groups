import 'student_model.dart';

class Group {
  String id;
  List<Student> students;
  List<String> topics;

  Group({this.id, this.students, this.topics});

  @override
  String toString() {
    return 'Grupo $id - ${topics.length} tema${topics.length > 1 ? 's' : ''} - ${students.length} estudiante${students.length > 1 ? 's' : ''}.';
  }
}
