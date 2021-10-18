import 'package:flutter_test/flutter_test.dart';
import 'package:local_storage/db/db_basic_quries.dart';
import 'package:local_storage/db/db_strings.dart';
import 'package:local_storage/models/organization/company.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';

Future main() async {
  setUpAll(() {
    sqfliteFfiInit();
    databaseFactory = databaseFactoryFfi;
  });
  Company company = Company('Flutter Co', 'BW');

  late Future<Database> dbhelper;
  late DBBasicQuiries db;

  setUp(() {
    dbhelper = openDatabase(inMemoryDatabasePath, version: 1,
        onCreate: (db, version) async {
      DBStrings().all.forEach((query) async => await db.execute(query));
    }, onConfigure: (db) async {
      await db.execute("PRAGMA foreign_keys = ON");
    });
    db = DBBasicQuiries(db: dbhelper);
  });

  tearDown(() {
    db.close();
  });

  group('Company CRUD:', () {
    test('Insert Company', () async {
      // act
      var res = await db.insertCompany(company);
      // assert
      expect(res, 1);
    });
    test('Read Company', () async {
      // arrange
      var id = await db.insertCompany(company);

      // act
      var res = await db.getCompanyByID(id);

      // arrange
      expect(res.toMap(), {
        'id': id,
        'name': company.name,
        'country': company.country,
      });
    });
    test('Read Companies', () async {
      // arrange
      var id = await db.insertCompany(company);

      // act
      var res = await db.getCompanies();

      // assert
      expect(res.first.toMap(), {
        'id': id,
        'name': company.name,
        'country': company.country,
      });
    });
    test('Update Company', () async {
      // arrange
      var id = await db.insertCompany(company);
      Company updated = Company(null, null);
      updated.id = id;
      updated.name = 'New Co';
      updated.country = 'MZ';

      // act
      var res = await db.updateCompany(updated);

      // assert
      expect(res, 1);
    });
    test('Delete Company', () async {
      // arrange
      var id = await db.insertCompany(company);

      expect(id, 1);

      // act
      var res = await db.deleteCompany(id);

      // assert
      expect(res, id);
    });
  });
}
