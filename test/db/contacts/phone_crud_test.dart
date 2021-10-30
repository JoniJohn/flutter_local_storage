// ignore_for_file: prefer_typing_uninitialized_variables

import 'package:flutter_test/flutter_test.dart';
import 'package:local_storage/db/contact/phone_crud.dart';
import 'package:local_storage/db/db_strings.dart';
import 'package:local_storage/models/contact/phone.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';

// Below we use functions setUp and tearDown to avoid repeating code
Future main() async {
  setUpAll(() {
    sqfliteFfiInit();
    databaseFactory = databaseFactoryFfi;
  });

  Phone phone = Phone('zip', 'name', 'number');

  late Future<Database> dbhelper;
  late PhoneCRUD db;

  // before every test we create a database
  setUp(() {
    dbhelper = openDatabase(inMemoryDatabasePath, version: 1,
        onCreate: (db, version) async {
      // DBStrings().all.forEach((query) async => await db.execute(query));
      for (final query in DBStrings().all) {
        await db.execute(query);
      }
    }, onConfigure: (db) async {
      await db.execute("PRAGMA foreign_keys = ON");
    });
    db = PhoneCRUD(db: dbhelper);
  });

// after every test we close the db
  tearDown(() async {
    await db.close();
  });

  group('Contacts Quries:', () {
    test('Create Phone', () async {
      // assert
      expect(await db.insertPhone(phone), 1);
    });
    test('Read Phones', () async {
      // arrange
      await db.insertPhone(phone);

      // act
      var res = await db.getPhones();

      // assert
      expect(res.length, 1);
      expect(res[0].name, phone.name);
    });
    test('Read Phone', () async {
      // arrange
      var res = await db.insertPhone(phone);

      // assert
      expect((await db.getPhoneByID(res)).toMap(), {
        'id': res,
        'zip_code': phone.zip,
        'type_name': phone.name,
        'phone_number': phone.number,
      });
    });
    test('Update Phone', () async {
      // arrange
      var res = await db.insertPhone(phone);
      Phone update = Phone('newname', 'newzip', null);
      update.name = 'newname';
      update.zip = 'newzip';
      update.number = 'newnumber';
      update.id = res;

      // act
      var val = await db.updatePhone(update);

      // assert
      expect(val, 1);
    });
    test('Delete Phone', () async {
      // arrange
      var res = await db.insertPhone(phone);

      // act
      var val = await db.deletePhone(res);

      // assert
      // where 1 is the number of rows affected
      expect(val, 1);
    });
  });
}
