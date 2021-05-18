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
    var list = List<int>.generate(quantity, (i) => i + 1);
    list.shuffle();
    for (int i = 0; i < quantity; i++) {
      List<String> topicsGroup = [];
      List<Student> studentGroup = [];
      Group group =
          Group(list.removeAt(0).toString(), studentGroup, topicsGroup);
      groups.add(group);
    }
    for (int i = 0; i < studentsPerGroup; i++) {
      for (int j = 0; j < quantity; j++) {
        if (students.isNotEmpty) {
          Student newStudent = students.removeAt(0);
          groups[j].students.add(newStudent);
        }
      }
    }
    for (int i = 0; i < topicsPerGroup; i++) {
      for (int j = 0; j < quantity; j++) {
        if (topics.isNotEmpty) {
          String newTopic = topics.removeAt(0);
          groups[j].topics.add(newTopic);
        }
      }
    }
  }
  groups.sort((a, b) => int.parse(a.id) - int.parse(b.id));
  return groups;
}
