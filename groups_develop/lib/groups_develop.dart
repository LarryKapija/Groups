import 'dart:convert';
import 'dart:io';
import 'dart:async';

import 'models/student_model.dart';

bool isBigger(int a, int b) => a > b;

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
