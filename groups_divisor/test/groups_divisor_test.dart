import 'package:groups_divisor/groups_divisor.dart' as lib;
import 'package:groups_divisor/models/groups_models.dart';
import 'package:groups_divisor/models/student_model.dart';
import 'package:test/test.dart';

void main() {
  test('Aleatoriedad', () async {
    var theoricProb = 2 / 3;
    var studentsGroups = <List<int>>[[], [], []];

    for (var i = 0; i < 2000; i++) {
      var students = await lib.getStudents('./lib/documents/students-20.csv');
      var topics = await lib.getTopics('./lib/documents/topics-5.csv');
      var groups = lib.generateGroups(3, students, topics);
      for (var j = 0; j < groups.length; j++) {
        studentsGroups[j].add(groups[j].students.length);
      }
    }
    var factualProb = <double>[];
    for (var i = 0; i < studentsGroups.length; i++) {
      var isSeven = 0;
      for (var j = 0; j < studentsGroups[i].length; j++) {
        if (studentsGroups[i][j] == 7) {
          isSeven++;
        }
      }
      factualProb.add(isSeven / 2000);
    }

    var isAccurate = true;

    for (var i = 0; i < factualProb.length; i++) {
      var diff = (theoricProb - factualProb[i]).abs();
      if (diff > 0.05) {
        isAccurate = false;
      }
    }

    expect(isAccurate, true);
  });
}
