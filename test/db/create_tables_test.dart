import 'package:flutter_test/flutter_test.dart';
import 'package:local_storage/db/db_strings.dart';
import 'package:local_storage/models/agent/agent.dart';
import 'package:local_storage/models/contact/email.dart';
import 'package:local_storage/models/contact/phone.dart';
import 'package:local_storage/models/organization/company.dart';
import 'package:local_storage/models/organization/department.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';

Future main() async {
  setUpAll(() {
    sqfliteFfiInit();
    databaseFactory = databaseFactoryFfi;
  });

  group('Table Creation Test:', () {
    test('Phone', () async {
      var dbhelper = await openDatabase(inMemoryDatabasePath, version: 1,
          onCreate: (db, version) async {
        await db.execute(DBStrings().phone);
      }, onConfigure: (db) async {
        await db.execute("PRAGMA foreign_keys = ON");
      });
      // arrange
      var phone = Phone('267', 'Mobile', '71717272');

      // act
      await dbhelper.insert('phone', phone.toMap());

      // assert
      expect(await dbhelper.query('phone'), [
        {
          'id': 1,
          'zip_code': '267',
          'type_name': 'Mobile',
          'phone_number': '71717272',
        }
      ]);

      dbhelper.close();
    });

    test('Email', () async {
      var dbhelper = await openDatabase(inMemoryDatabasePath, version: 1,
          onCreate: (db, version) async {
        await db.execute(DBStrings().email);
      }, onConfigure: (db) async {
        await db.execute("PRAGMA foreign_keys = ON");
      });

      //arrange
      var email = EmailAddress('address@gmail.com');

      // act
      await dbhelper.insert('email', email.toMap());

      // assert
      expect(await dbhelper.query('email'), [
        {
          'id': 1,
          'description': null,
          'address': 'address@gmail.com',
        }
      ]);

      dbhelper.close();
    });

    test('Company', () async {
      var dbhelper = await openDatabase(inMemoryDatabasePath, version: 1,
          onCreate: (db, version) async {
        await db.execute(DBStrings().company);
      }, onConfigure: (db) async {
        await db.execute("PRAGMA foreign_keys = ON");
      });

      // arrange
      var company = Company('Shoppinga', 'Botswana');

      // act
      await dbhelper.insert('company', company.toMap());

      // assert
      expect(await dbhelper.query('company'), [
        {
          'id': 1,
          'name': 'Shoppinga',
          'country': 'Botswana',
        },
      ]);

      dbhelper.close();
    });

    test('Department', () async {
      var dbhelper = await openDatabase(inMemoryDatabasePath, version: 1,
          onCreate: (db, version) async {
        await db.execute(DBStrings().company);
        await db.execute(DBStrings().department);
      }, onConfigure: (db) async {
        await db.execute("PRAGMA foreign_keys = ON");
      });

      // arrange
      var dept = Department('IT Dept', 'For all your IT needs...', 1);
      var comp = Company('Shoppinga', 'BW');

      // act
      await dbhelper.insert('company', comp.toMap());
      await dbhelper.insert('department', dept.toMap());

      // assert
      expect(
        await dbhelper.query('department'),
        [
          {
            'id': 1,
            'name': 'IT Dept',
            'description': 'For all your IT needs...',
            'company_id': 1,
          }
        ],
      );

      dbhelper.close();
    });

    test('Agent', () async {
      var dbhelper = await openDatabase(inMemoryDatabasePath, version: 1,
          onCreate: (db, version) async {
        await db.execute(DBStrings().agent);
      }, onConfigure: (db) async {
        await db.execute("PRAGMA foreign_keys = ON");
      });

      // arrange
      var agent = Agent('Mr.', 'Lesley', 'Thuto', 'Johnson', 1, 'M');

      // act
      await dbhelper.insert('agent', agent.toMap());

      //assert
      expect(
        await dbhelper.query('agent'),
        [
          {
            'id': 1,
            'salutation': 'Mr.',
            'firstname': 'Lesley',
            'middlenames': 'Thuto',
            'lastname': 'Johnson',
            'user_id': 1,
            'gender': 'M'
          }
        ],
      );

      dbhelper.close();
    });
  });
}
