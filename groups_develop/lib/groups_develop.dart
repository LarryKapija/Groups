import 'dart:convert';
import 'dart:io';
import 'dart:async';

import 'package:groups_develop/models/groups_model.dart';

import 'models/student_model.dart';

bool isBigger(int a, int b) => a >= b;

Future<List<Student>> getStudents(String fileloc) async {
  final File file = File(fileloc);
  List<Student> students = [];
  Stream<String> sLines =
      file.openRead().transform(utf8.decoder).transform(LineSplitter());
  int counter = 0;
  await for (var line in sLines) {
    counter++;
    if (counter == 1) continue;
    var lineArgs = line.split(',');
    Student student = Student(
      id: lineArgs[0],
      name: lineArgs[1],
    );

    students.add(student);
  }

  return students;
}

Future<List<String>> getTopics(String fileloc) async {
  final File file = File(fileloc);
  List<String> topics = [];
  Stream<String> sLines =
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
    int quantity, List<Student> Originalstudents, List<String> Originaltopics) {
  List<Group> groups = [];
  List<Student> students = List.from(Originalstudents);
  List<String> topics = List.from(Originaltopics);
  if (isBigger(students.length, quantity) &&
      isBigger(topics.length, quantity)) {
    double studentsPerGroup = students.length / quantity;
    double topicsPerGroup = topics.length / quantity;
    double topicsRes = topicsPerGroup % 1;
    double studentRes = studentsPerGroup % 1;
    studentsPerGroup =
        studentRes > 0.5 || studentRes == 0 ? studentsPerGroup : studentRes;
    topicsPerGroup =
        topicsRes > 0.5 || topicsRes == 0 ? topicsPerGroup : topicsRes;

    var list = List<int>.generate(quantity, (i) => i + 1);
    for (int i = 0; i < quantity; i++) {
      List<Student> studentGroup = [];

      for (int j = 0; j < studentsPerGroup; j++) {
        if (students.isNotEmpty) {
          Student newStudent = students.removeAt(0);

          studentGroup.add(newStudent);
        }
        if (topicsRes > 0 && topicsRes < 0.5) {
          studentRes = 0;
          Student newStudent = students.removeAt(0);
          studentGroup.add(newStudent);
        }
      }

      List<String> topicsGroup = [];
      for (int j = 0; j < topicsPerGroup; j++) {
        if (topics.isNotEmpty) {
          String newTheme = topics.removeAt(0);
          topicsGroup.add(newTheme);
        }
        if (topicsRes > 0 && topicsRes < 0.5) {
          topicsRes = 0;
          String newTheme = topics.removeAt(0);
          topicsGroup.add(newTheme);
        }
      }
      list.shuffle();
      Group group =
          Group(list.removeAt(0).toString(), studentGroup, topicsGroup);
      groups.add(group);
    }
  }
  groups.sort((a, b) => a.id.compareTo(b.id));
  return groups;
}
