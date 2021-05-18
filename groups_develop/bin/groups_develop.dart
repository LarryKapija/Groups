//import 'dart:io';

//import 'dart:async';
//import 'dart:convert';

//import 'dart:math';

import 'package:groups_develop/groups_develop.dart' as lib;
import 'package:groups_develop/models/groups_model.dart';
import 'package:groups_develop/models/student_model.dart';

void main(List<String> args) async {
  //[cantidad grupos, archivo estudiantes, archivo temas]

  var groupQuantity = int.parse(args[0]);
  var studentsFile = args[1];
  var topicsFile = args[2];

  List<Student> students = await lib.getStudents(studentsFile);
  List<String> topics = await lib.getTopics(topicsFile);

  students.shuffle();
  topics.shuffle();

  // students.forEach((element) {
  //   print(element);
  // });

  // themes.forEach((element) {
  //   print(element);
  // });

  List<Group> groups = lib.generateGroups(groupQuantity, students, topics);

  printGroups(groups);
}

void printGroups(List<Group> groups) {
  groups.forEach((element) {
    print(element);
    print('  Temas: ' + element.topics.toString());
    element.students.forEach((student) {
      print('  ' + student.toString());
    });
    print('==================================');
  });
}
