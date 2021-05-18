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
    int quantity, List<Student> Originalstudents, List<String> Originalthemes) {
  List<Group> groups = [];
  List<Student> students = List.from(Originalstudents);
  List<String> themes = List.from(Originalthemes);
  if (isBigger(students.length, quantity) &&
      isBigger(themes.length, quantity)) {
    double studentsPerGroup = students.length / quantity;
    double themesPerGroup = themes.length / quantity;
    double themesRes = themesPerGroup % 1;
    double studentRes = studentsPerGroup % 1;
    studentsPerGroup =
        studentRes > 0.5 || studentRes == 0 ? studentsPerGroup : studentRes;
    themesPerGroup =
        themesRes > 0.5 || themesRes == 0 ? themesPerGroup : themesRes;

    var list = List<int>.generate(quantity, (i) => i + 1);
    for (int i = 0; i < quantity; i++) {
      List<Student> studentGroup = [];

      for (int j = 0; j < studentsPerGroup; j++) {
        if (students.isNotEmpty) {
          Student newStudent = students.removeAt(0);

          studentGroup.add(newStudent);
        }
        if (themesRes > 0 && themesRes < 0.5) {
          studentRes = 0;
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
        if (themesRes > 0 && themesRes < 0.5) {
          themesRes = 0;
          String newTheme = themes.removeAt(0);
          themesGroup.add(newTheme);
        }
      }
      list.shuffle();
      Group group =
          Group(list.removeAt(0).toString(), studentGroup, themesGroup);
      groups.add(group);
    }
  }
  groups.sort((a, b) => a.id.compareTo(b.id));
  return groups;
}
