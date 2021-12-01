import 'package:times/model/highscore.dart';

class HighscoreWithUserName extends Highscore {
  String? userName;

  HighscoreWithUserName();

  HighscoreWithUserName.fromMap(Map<String, dynamic> map)
      : userName = map['userName'],
        super.fromMap(map);

  @override
  Map<String, dynamic> toMap() {
    final map = super.toMap();
    map.addAll({'userName': userName});
    return map;
  }

  @override
  String toString() {
    return 'HighscoreWithUserName{id: $id, userId: $userId, userName: $userName, score: $score}';
  }
}
