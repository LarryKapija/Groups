import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'models/groups_models.dart';
import 'models/student_model.dart';

bool isBigger(int a, int b) => a >= b;

Future<List<Student>> getStudents(String locFile) async {
  final File file = File(locFile);
  var students = <Student>[];
  var sLines =
      file.openRead().transform(utf8.decoder).transform(LineSplitter());
  int counter = 0;
  await for (var line in sLines) {
    counter++;
    if (counter == 1) continue;
    var lineArgs = line.split(',');
    var student = Student(
      id: lineArgs[0],
      name: lineArgs[1],
    );
    students.add(student);
  }
  return students;
}

Future<List<String>> getTopics(String locFile) async {
  final File file = File(locFile);
  List<String> topics = [];
  var sLines =
      file.openRead().transform(utf8.decoder).transform(LineSplitter());
  int counter = 0;
  await for (var line in sLines) {
    counter++;
    if (counter == 1) continue;
    topics.add(line);
  }
  return topics;
}

List<Group> generateGroups(
    int quantity, List<Student> students, List<String> topics) {
  return <Group>[];
}
