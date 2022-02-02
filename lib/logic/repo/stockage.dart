import 'package:shared_preferences/shared_preferences.dart';

class Stockage {
  Future<void> setInfo(String username, int age) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('username', username);
    prefs.setInt('age', age);
  }

  Future<Map> getInfo() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    return {
      'username': (prefs.getString('username') ?? ''),
      'age': (prefs.getInt('age') ?? 20),
    };
  }

  saveScores(List scores) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String> newScores = [];
    List oldScoresStringFormat = (prefs.getStringList('scores') ?? []);
    List oldScores = [
      for (String score in oldScoresStringFormat)
        [
          score.split(';')[0],
          score.split(';')[1]
        ]
    ];

    for (List score in scores) {
      bool find = false;
      for (List oldScore in oldScores) {
        if (score[0] == oldScore[0]) {
          find = true;
          if (score[1] < int.parse(oldScore[1]) && score[1] > 0) {
            newScores.add(score[0] + ";" + score[1].toString());
          } else {
            newScores.add(oldScore[0] + ";" + oldScore[1].toString());
          }
        }
      }

      if (!find) {
        if (score[1] > 0) newScores.add(score[0] + ";" + score[1].toString());
      }
    }

    for (List oldScore in oldScores) {
      bool find = false;
      for (String score in newScores) {
        if (score.contains(oldScore[0] + ';')) {
          find = true;
        }
      }
      if (!find) {
        newScores.add(oldScore[0] + ";" + oldScore[1].toString());
      }
    }

    prefs.setStringList('scores', newScores);
    print(newScores);
  }

  saveMyScore(String username, int score) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String> newScores = [];
    List oldScoresStringFormat = (prefs.getStringList('scores') ?? []);
    List oldScores = [
      for (String score in oldScoresStringFormat)
        [
          score.split(';')[0],
          score.split(';')[1]
        ]
    ];
    for (List oldScore in oldScores) {
      if (oldScore[0] == username) {
        if (score < int.parse(oldScore[1]) && score > 0) {
          newScores.add(username + ";" + score.toString());
        } else {
          newScores.add(username + ";" + oldScore[1].toString());
        }
      } else {
        newScores.add(oldScore[0] + ";" + oldScore[1].toString());
      }
    }

    prefs.setStringList('scores', newScores);
    print(newScores);
  }

  Future<List> getScores() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String> newScores = [];
    List oldScoresStringFormat = (prefs.getStringList('scores') ?? []);
    List oldScores = [
      for (String score in oldScoresStringFormat)
        [
          score.split(';')[0],
          int.parse(score.split(';')[1])
        ]
    ];
    return oldScores;
  }
}
