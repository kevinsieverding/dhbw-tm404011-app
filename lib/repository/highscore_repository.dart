import 'package:times/model/highscore.dart';
import 'package:times/infrastructure/database.dart' as database;
import 'package:times/model/highscore_with_user_name.dart';

class HighscoreRepository {
  static const String table = 'highscore';

  static Future<List<Highscore>> findAll() async {
    final db = await database.db;
    final entities = await db.query(table);
    final List<Highscore> models = [];
    for (var entity in entities) {
      models.add(Highscore.fromMap(entity));
    }
    return models;
  }

  static Future<List<HighscoreWithUserName>>
      findAllWithUserNamesOrderByScore() async {
    final db = await database.db;
    final entities = await db.rawQuery('''
    select user.name as userName, highscore.score from highscore left join user on highscore.userId = user.id order by highscore.score desc;
    ''');
    final List<HighscoreWithUserName> models = [];
    for (var entity in entities) {
      models.add(HighscoreWithUserName.fromMap(entity));
    }
    return models;
  }

  static Future<int> insert(Highscore highscore) async {
    final db = await database.db;
    return await db.insert(table, highscore.toMap());
  }
}
