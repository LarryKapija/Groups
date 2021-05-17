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

Future<List<String>> getThemes(String fileloc) async {
  final File file = File(fileloc);
  List<String> themes = [];
  Stream<String> sLines =
      file.openRead().transform(utf8.decoder).transform(LineSplitter());
  int counter = 0;
  await for (var line in sLines) {
    counter++;
    if (counter == 1) continue;
    themes.add(line);
  }

  return themes;
}

List<Group> getGroups(
    int quantity, List<Student> students, List<String> themes) {
  List<Group> groups = [];
  if (isBigger(students.length, quantity) &&
      isBigger(themes.length, quantity)) {
    double studentsPerGroup = students.length / quantity;
    double themesPerGroup = themes.length / quantity;
    for (int i = 0; i < quantity; i++) {
      List<Student> studentGroup = [];

      for (int j = 0; j < studentsPerGroup; j++) {
        if (students.isNotEmpty) {
          Student newStudent = students.removeAt(0);

          studentGroup.add(newStudent);
        }
      }

      List<String> themesGroup = [];
      for (int j = 0; j < themesPerGroup; j++) {
        if (themes.isNotEmpty) {
          String newTheme = themes.removeAt(0);
          themesGroup.add(newTheme);
        }
      }

      Group group = Group((i + 1).toString(), studentGroup, themesGroup);
      groups.add(group);
    }
  }
  groups.shuffle();
  return groups;
}
