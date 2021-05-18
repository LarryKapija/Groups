import 'package:groups_develop/groups_develop.dart';
import 'package:groups_develop/models/groups_model.dart';
import 'package:groups_develop/models/student_model.dart';
import 'package:test/test.dart';
import 'package:groups_develop/groups_develop.dart' as lib;

void main() {
  test('grupos más que estudiantes', () {
    expect(isBigger(6, 5), true);
  });

  test('Aleatoriedad estudiantes', () async {
    double theoricProb = 2 / 3;
    List<List<int>> studentsGroups = [[], [], []];

    for (int i = 0; i < 750; i++) {
      List<Student> students =
          await lib.getStudents('./lib/documents/students-20.csv');
      List<String> themes = await lib.getTopics('./lib/documents/topics-5.csv');
      List<Group> groups = lib.generateGroups(3, students, themes);
      for (int j = 0; j < 3; j++) {
        studentsGroups[j].add(groups[j].students.length);
      }
    }

    List<double> factualProb = [];

    for (int i = 0; i < studentsGroups.length; i++) {
      int isSeven = 0;
      for (int j = 0; j < studentsGroups[i].length; j++) {
        if (studentsGroups[i][j] == 7) {
          isSeven++;
        }
      }
      factualProb.add(isSeven / 750);
    }
    bool isAccurate = true;

    for (int i = 0; i < factualProb.length; i++) {
      double diff = (theoricProb - factualProb[i]).abs();
      print(diff);
      if (diff > 0.05) {
        isAccurate = false;
      }
    }
    expect(isAccurate, true);
  });
}
