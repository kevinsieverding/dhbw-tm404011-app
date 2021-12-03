import 'package:flutter/widgets.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:times/constants.dart' as constants;

/// Open DB and provide as global object
final db = _openDatabase(constants.dbName);

Future<Database> _openDatabase(String dbName) async {
  WidgetsFlutterBinding.ensureInitialized();
  return openDatabase(join(await getDatabasesPath(), dbName),
      onCreate: _onCreate, version: 1);
}

/// Initialize DB schema
Future<void> _onCreate(Database db, int version) async {
  await db.execute('''
    create table user(
      id integer primary key autoincrement,
      name txt
    );
    ''');
  await db.execute('''
  create table highscore(
      id integer primary key autoincrement,
      userId integer,
      score integer,
      foreign key(userId) references user(id)
    );
    ''');
}
