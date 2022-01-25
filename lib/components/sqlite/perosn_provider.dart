import 'dart:io';

import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:synchronized/synchronized.dart';
import 'package:uuid/uuid.dart';

import 'model_constant.dart';
import 'person.dart';

class DbPersonProvider {
  final lock = Lock(reentrant: true);
  Database? db;

  DbPersonProvider();

  Future openPath(String dbName) async {
    var databasesPath = await getDatabasesPath();
    var path = join(databasesPath, dbName);

    try {
      await Directory(databasesPath).create(recursive: true);
    } catch (_) {}

    db = await openDatabase(path,
        version: kVersion1,
        onCreate: (db, version) async {
          await _createDb(db);
        },
        onUpgrade: (db, oldVersion, newVersion) async {
          if (oldVersion < kVersion1) {
            await _createDb(db);
          }
        });
  }

  Future _createDb(Database db) async {
    await db.execute('DROP TABLE If EXISTS $tableNotes');
    await db.execute(
        'CREATE TABLE $tableNotes($columnId TEXT PRIMARY KEY, $columnName TEXT, $columnPhone TEXT)');
  }

  //判断db是否初始化成功
  Future<Database?> get ready async => db ??= await lock.synchronized(() async {
    if (db == null) {
      await openPath(dbName);
    }
    return db;
  });

  Future<List<Person>> getPersons() async {
    List<Map<String, Object?>> dataList = await db!.query(tableNotes);

    List<Person> persons = [];
    dataList.forEach((element) {
      persons.add(Person.fromJson(element));
    });
    return persons;
  }

  Future savePerson(Person person) async {
    if (person.id != null) {
      await db!.update(tableNotes, person.toJson(),
          where: '$columnId = ?', whereArgs: <Object?>[person.id]);
    } else {
      person.id = Uuid().v4();
      await db!.insert(tableNotes, person.toJson());
    }
  }

  Future delete(Person person) async {
    await db!.delete(tableNotes, where: '$columnId = ?', whereArgs: [person.id]);
  }
}