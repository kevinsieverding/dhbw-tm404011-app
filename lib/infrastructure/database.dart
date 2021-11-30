import 'package:flutter/widgets.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:times/constants.dart' as constants;

final db = _openDatabase(constants.dbName);

Future<Database> _openDatabase(String dbName) async {
  WidgetsFlutterBinding.ensureInitialized();
  return openDatabase(join(await getDatabasesPath(), dbName),
      onCreate: _onCreate, version: 1);
}

Future<void> _onCreate(Database db, int version) async {
  return db.execute(
      'CREATE TABLE Users(id INTEGER PRIMARY KEY AUTOINCREMENT, name TXT);');
}
