import 'package:flutter_test/flutter_test.dart';
import 'package:local_storage/db/db_strings.dart';
import 'package:local_storage/db/agent/title_crud.dart';
import 'package:local_storage/models/agent/title.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';

Future main() async {
  setUpAll(() {
    sqfliteFfiInit();
    databaseFactory = databaseFactoryFfi;
  });

  JobTitle testTitle = JobTitle("name", "desc");
  late Future<Database> dbhelper;
  late TitleCRUD db;

  setUp(() async {
    dbhelper = openDatabase(inMemoryDatabasePath, version: 1,
        onCreate: (db, version) async {
      // DBStrings().all.forEach((query) async => await db.execute(query));
      for (final query in DBStrings().all) {
        await db.execute(query);
      }
    }, onConfigure: (db) async {
      await db.execute("PRAGMA foreign_keys = ON");
    });
    db = TitleCRUD(db: dbhelper);
  });

  tearDown(() async {
    await db.close();
  });
  group('JobTitle CRUD:', () {
    test('Create JobTitle', () async {
      // act
      int res = await db.insertJobTitle(testTitle);

      // assert
      expect(res, 1);
    });
    test('Read JobTitles', () async {
      // read when there is no record
      List<JobTitle> res = await db.getJobTitles();
      // assert
      expect(res, []);

      // arrange
      int id = await db.insertJobTitle(testTitle);

      // act
      res = await db.getJobTitles();

      // assert
      expect(res.length, 1);
      expect(res.first.toMap(), {
        'id': id,
        'name': testTitle.name,
        'description': testTitle.desc,
      });
    });
    test('Read JobTitle by ID', () async {
      // read when there is no matching record
      List<JobTitle> res = await db.getJobTitleByID(1);
      // assert
      expect(res, []);

      // arrange
      int id = await db.insertJobTitle(testTitle);

      // act
      res = await db.getJobTitleByID(id);

      // assert
      expect(res.length, 1);
      expect(res.first.toMap(), {
        'id': id,
        'name': testTitle.name,
        'description': testTitle.desc,
      });
    });
    test('Update JobTitle', () async {
      // update when there is no matching record
      JobTitle updated = JobTitle("name1", "desc1");
      updated.id = 1;

      // act
      int res = await db.updateJobTitle(updated);

      // assert
      expect(res, 0);

      // arrange
      int id = await db.insertJobTitle(testTitle);

      // act
      res = await db.updateJobTitle(updated);

      // assert
      expect(res, 1);
      expect((await db.getJobTitleByID(id)).first.toMap(), {
        'id': id,
        'name': updated.name,
        'description': updated.desc,
      });
    });
    test('Delete JobTitle', () async {
      // delete when there is nothing to delete
      int res = await db.deleteJobTitle(1);
      // assert
      expect(res, 0);

      // arrange
      int id = await db.insertJobTitle(testTitle);

      // act
      res = await db.deleteJobTitle(id);

      // assert
      expect(res, 1);
    });
  });
}
