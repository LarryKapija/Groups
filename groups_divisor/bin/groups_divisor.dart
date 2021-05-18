import 'package:groups_divisor/groups_divisor.dart' as lib;
import 'package:groups_divisor/models/groups_models.dart';
import 'package:groups_divisor/models/student_model.dart';

void main(List<String> args) async {
// ====> [cantidad de grupos, lista de estudiantes, lista de temas]
  var groupQuantity = int.parse(args[0]);
  var studentsFile = args[1];
  var topicsFile = args[2];

  List<Student> students = await lib.getStudents(studentsFile);
  List<String> topics = await lib.getTopics(topicsFile);

  students.shuffle();
  topics.shuffle();

  List<Group> groups = lib.generateGroups(groupQuantity, students, topics);
  printGroups(groups);
}

void printGroups(List<Group> groups) {
  groups.forEach((element) {
    print('========================================');
    print(element);
    print(' Temas: ' + element.topics.toString());
    element.students.forEach((student) {
      print(' ' + student.toString());
    });
  });
}
