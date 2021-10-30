import 'package:flutter_test/flutter_test.dart';
import 'package:local_storage/db/db_strings.dart';
import 'package:local_storage/db/agent/role_crud.dart';
import 'package:local_storage/db/organization/department_crud.dart';
import 'package:local_storage/db/organization/organization_crud.dart';
import 'package:local_storage/models/agent/role.dart';
import 'package:local_storage/models/organization/company.dart';
import 'package:local_storage/models/organization/department.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';

Future main() async {
  setUpAll(() {
    sqfliteFfiInit();
    databaseFactory = databaseFactoryFfi;
  });

  late Department dept;
  late Company company;
  late int deptID, coID;

  late Future<Database> dbhelper;
  late RoleCRUD db;

  late Role role;

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
    db = RoleCRUD(db: dbhelper);
    CompanyCRUD cDB = CompanyCRUD(db: dbhelper);
    DeptCRUD dDB = DeptCRUD(db: dbhelper);
    company = Company("name", "country");
    coID = await cDB.insertCompany(company);
    dept = Department("name", "desc", coID);
    deptID = await dDB.insertDept(dept);
    role = Role("name", "desc", deptID);
  });

  tearDown(() {
    db.close();
  });

  group('CRUD for Role Model:', () {
    test('Create Role', () async {
      // act
      int res = await db.insertRole(role);

      // assert
      expect(res, 1);
    });
    test('Read Roles', () async {
      // read when there is nothing on table
      List<Role> roles = await db.getRoles();
      // assert
      expect(roles, []);

      // arrange
      int id = await db.insertRole(role);

      // act
      roles = await db.getRoles();

      // assert
      expect(roles.length, 1);
      expect(roles.first.toMap(), {
        'id': id,
        'name': role.name,
        'description': role.desc,
        'dept_id': role.dept,
      });
    });
    test('Read Role by ID', () async {
      // read by id when there is no matching ID
      List<Role> roles = await db.getRoleByID(1);
      // assert
      expect(roles, []);
      // arrange
      int id = await db.insertRole(role);
      // act
      roles = await db.getRoleByID(id);
      // assert
      expect(roles.length, 1);
      expect(roles.first.toMap(), {
        'id': id,
        'name': role.name,
        'description': role.desc,
        'dept_id': role.dept,
      });
    });
    test('Read Roles by Department', () async {
      // read by department id when there is no match
      List<Role> roles = await db.getRolesByDept(deptID);
      // assert
      expect(roles, []);
      // arrange
      int id = await db.insertRole(role);
      // act
      roles = await db.getRolesByDept(deptID);
      // assert
      expect(roles.length, 1);
      expect(roles.first.toMap(), {
        'id': id,
        'name': role.name,
        'description': role.desc,
        'dept_id': role.dept,
      });
    });
    test('Update Role', () async {
      // update when there is no id match
      Role updated = Role("name1", "desc2", deptID);
      updated.id = 1;
      int response = await db.updateRole(updated);
      // assert
      expect(response, 0);
      // arrange
      int id = await db.insertRole(role);
      updated.id = id;
      // act
      response = await db.updateRole(updated);
      // assert
      expect(response, 1);
      expect((await db.getRoleByID(id)).first.toMap(), {
        'id': id,
        'name': updated.name,
        'description': updated.desc,
        'dept_id': updated.dept,
      });
    });
    test('Delete Role', () async {
      // delete when there is no id match
      int response = await db.deleteRole(1);
      // assert
      expect(response, 0);
      // arrange
      int id = await db.insertRole(role);
      // act
      response = await db.deleteRole(id);
      // assert
      expect(response, 1);
    });
  });
}
