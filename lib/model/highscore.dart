class Highscore {
  int? id;
  int? userId;
  int? score;

  Highscore();

  Highscore.fromMap(Map<String, dynamic> map)
      : id = map['id'],
        userId = map['userId'],
        score = map['score'];

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'userId': userId,
      'score': score,
    };
  }

  @override
  String toString() {
    return 'Highscore{id: $id, userId: $userId, score: $score}';
  }
}
