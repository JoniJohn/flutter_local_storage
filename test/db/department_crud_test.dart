import 'package:flutter_test/flutter_test.dart';
import 'package:local_storage/db/db_basic_quries.dart';
import 'package:local_storage/db/db_strings.dart';
import 'package:local_storage/models/organization/company.dart';
import 'package:local_storage/models/organization/department.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';

Future main() async {
  setUpAll(() {
    sqfliteFfiInit();
    databaseFactory = databaseFactoryFfi;
  });

  Company company = Company('Flutter Co', 'BW');
  Department dept = Department('IT Dept', 'For your Support', null);
  late Future<Database> dbhelper;
  late DBBasicQuiries db;
  late int res;

  setUp(() async {
    dbhelper = openDatabase(inMemoryDatabasePath, version: 1,
        onCreate: (db, version) async {
      DBStrings().all.forEach((query) async => await db.execute(query));
    }, onConfigure: (db) async {
      await db.execute("PRAGMA foreign_keys = ON");
    });
    db = DBBasicQuiries(db: dbhelper);
    res = await db.insertCompany(company);
    dept.company = res;
  });

  tearDown(() {
    db.close();
  });

  group('Department CRUD:', () {
    test('Create Department', () async {
      // act
      var id = await db.insertDept(dept);

      // assert
      expect(id, res);
    });
    test('Read Departments', () async {
      // act when there is nothing on dept table
      var depts = await db.getDepts();

      expect(depts.length, 0);

      // arrange
      var id = await db.insertDept(dept);

      // act
      depts = await db.getDepts();

      // assert
      expect(depts.first.toMap(), {
        'id': id,
        'name': dept.name,
        'description': dept.desc,
        'company_id': res
      });
    });
    test('Read Departments by Company ID', () async {
      // act when company ID does not exits
      var depts = await db.getDeptsByCoID(100);

      // assert
      expect(depts.length, 0);

      // arrange
      var id = await db.insertDept(dept);

      // act
      depts = await db.getDeptsByCoID(res);

      // assert
      expect(depts.first.toMap(), {
        'id': id,
        'name': dept.name,
        'description': dept.desc,
        'company_id': res
      });
    });
    test('Read Department by ID', () async {
      // act when there is no matching ID
      var department = await db.getDeptByID(100);

      // assert
      expect(department, []);

      // arrange
      var id = await db.insertDept(dept);

      // act
      department = await db.getDeptByID(id);

      // assert
      expect(department.first.toMap(), {
        'id': id,
        'name': dept.name,
        'description': dept.desc,
        'company_id': res
      });
    });
    test('Update Deparment', () async {
      // update when there is no record
      Department updated = dept;
      updated.id = 1;
      updated.name = 'New Name';
      updated.desc = 'New Desc';
      // act
      var response = await db.updateDept(updated);
      // assert
      expect(response, 0);

      // arrange
      var id = await db.insertDept(dept);
      updated = dept;
      updated.id = id;
      updated.name = 'New Name';
      updated.desc = 'New Desc';

      // act
      response = await db.updateDept(updated);

      // assert
      expect(response, 1);
      expect((await db.getDeptByID(id)).first.toMap(), {
        'id': id,
        'name': updated.name,
        'description': updated.desc,
        'company_id': res
      });
    });
    test('Delete Deparment', () async {
      // act when there is nothing to delete
      // where deleted is the number of rows deleted
      var deleted = await db.deleteDept(1);
      // assert
      expect(deleted, 0);

      // arrange
      var response = await db.insertDept(dept);

      // act
      deleted = await db.deleteDept(response);

      // assert
      expect(deleted, 1);
    });
  });
}
