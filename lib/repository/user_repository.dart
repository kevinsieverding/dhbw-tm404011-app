import 'package:times/model/user.dart';
import 'package:times/infrastructure/database.dart' as database;

class UserRepository {
  static Future<List<User>> findAll() async {
    final db = await database.db;
    final userEntities = await db.query('Users');
    final List<User> userModels = [];
    for (var userEntity in userEntities) {
      userModels.add(User.fromMap(userEntity));
    }
    return userModels;
  }

  static Future<int> insert(User user) async {
    final db = await database.db;
    return await db.insert('Users', user.toMap());
  }
}
