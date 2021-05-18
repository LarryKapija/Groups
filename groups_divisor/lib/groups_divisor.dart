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

List<Group> generateGroups(int groupQuantity, List<Student> originalStudents,
    List<String> originalTopics) {
  List<Group> groups = [];
  List<Student> students = List.from(originalStudents);
  List<String> topics = List.from(originalTopics);
  if (isBigger(students.length, groupQuantity) &&
      isBigger(topics.length, groupQuantity)) {
    double studentsPerGroup = students.length / groupQuantity;
    double topicsPerGroup = topics.length / groupQuantity;

    var list = List<int>.generate(groupQuantity, (index) => index + 1);
    list.shuffle();

    for (var i = 0; i < groupQuantity; i++) {
      var topicsGroup = <String>[];
      var studentsGroup = <Student>[];

      Group group = Group(
        id: list.removeAt(0).toString(),
        students: studentsGroup,
        topics: topicsGroup,
      );

      groups.add(group);
    }

    for (var i = 0; i < studentsPerGroup; i++) {
      for (var j = 0; j < groupQuantity; j++) {
        if (students.isNotEmpty) {
          Student newStudent = students.removeAt(0);

          groups[j].students.add(newStudent);
        }
      }
    }

    for (var i = 0; i < topicsPerGroup; i++) {
      for (var j = 0; j < groupQuantity; j++) {
        if (topics.isNotEmpty) {
          var newTopic = topics.removeAt(0);

          groups[j].topics.add(newTopic);
        }
      }
    }
  } else {
    throw RangeError('Cantidad de grupos demasiado alta');
  }

  groups.sort((a, b) => int.parse(a.id) - int.parse(b.id));
  return groups;
}
