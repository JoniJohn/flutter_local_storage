import 'package:flutter_test/flutter_test.dart';
import 'package:local_storage/db/db_basic_quries.dart';
import 'package:local_storage/db/db_strings.dart';
import 'package:local_storage/models/contact/email.dart';
import 'package:local_storage/models/contact/phone.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';

Future main() async {
  setUpAll(() {
    sqfliteFfiInit();
    databaseFactory = databaseFactoryFfi;
  });
  Phone phone = Phone('zip', 'name', 'number');
  EmailAddress email = EmailAddress('address');

  group('Contacts Quries:', () {
    test('Create Phone', () async {
      var dbhelper = openDatabase(inMemoryDatabasePath, version: 1,
          onCreate: (db, version) async {
        DBStrings().all.forEach((query) async => await db.execute(query));
      }, onConfigure: (db) async {
        await db.execute("PRAGMA foreign_keys = ON");
      });

      // arrange
      DBBasicQuiries db = DBBasicQuiries(db: dbhelper);

      // assert
      expect(await db.insertPhone(phone), 1);

      await db.close();
    });
    test('Create EmailAddress', () async {
      var dbhelper = openDatabase(inMemoryDatabasePath, version: 1,
          onCreate: (db, version) async {
        DBStrings().all.forEach((query) async => await db.execute(query));
      }, onConfigure: (db) async {
        await db.execute("PRAGMA foreign_keys = ON");
      });
      // arrange
      DBBasicQuiries db = DBBasicQuiries(db: dbhelper);

      // assert
      expect(await db.insertEmail(email), 1);

      await db.close();
    });
    test('Read Phones', () async {
      var dbhelper = openDatabase(inMemoryDatabasePath, version: 1,
          onCreate: (db, version) async {
        DBStrings().all.forEach((query) async => await db.execute(query));
      }, onConfigure: (db) async {
        await db.execute("PRAGMA foreign_keys = ON");
      });
      // arrange
      DBBasicQuiries db = DBBasicQuiries(db: dbhelper);

      await db.insertPhone(phone);

      // act
      var res = await db.getPhones();

      // assert
      expect(res.length, 1);
      expect(res[0].name, phone.name);

      await db.close();
    });
    test('Read EmailAddresses', () async {
      var dbhelper = openDatabase(inMemoryDatabasePath, version: 1,
          onCreate: (db, version) async {
        DBStrings().all.forEach((query) async => await db.execute(query));
      }, onConfigure: (db) async {
        await db.execute("PRAGMA foreign_keys = ON");
      });

      // arrange
      DBBasicQuiries db = DBBasicQuiries(db: dbhelper);
      await db.insertEmail(email);

      // act
      var res = await db.getEmailAddresses();

      // assert
      expect(res.length, 1);
      expect(res[0].address, email.address);

      await db.close();
    });
    test('Read Phone', () async {
      var dbhelper = openDatabase(inMemoryDatabasePath, version: 1,
          onCreate: (db, version) async {
        DBStrings().all.forEach((query) async => await db.execute(query));
      }, onConfigure: (db) async {
        await db.execute("PRAGMA foreign_keys = ON");
      });

      // arrange
      DBBasicQuiries db = DBBasicQuiries(db: dbhelper);
      var res = await db.insertPhone(phone);

      // assert
      expect((await db.getPhoneByID(res)).toMap(), {
        'id': res,
        'zip_code': phone.zip,
        'type_name': phone.name,
        'phone_number': phone.number,
      });

      await db.close();
    });
    test('Read Email', () async {
      var dbhelper = openDatabase(inMemoryDatabasePath, version: 1,
          onCreate: (db, version) async {
        DBStrings().all.forEach((query) async => await db.execute(query));
      }, onConfigure: (db) async {
        await db.execute("PRAGMA foreign_keys = ON");
      });

      // arrange
      DBBasicQuiries db = DBBasicQuiries(db: dbhelper);
      var res = await db.insertEmail(email);

      // assert
      expect((await db.getEmailAddressByID(res)).toMap(), {
        'id': res,
        'description': email.desc,
        'address': email.address,
      });

      await db.close();
    });
    test('Update Phone', () async {
      var dbhelper = openDatabase(inMemoryDatabasePath, version: 1,
          onCreate: (db, version) async {
        DBStrings().all.forEach((query) async => await db.execute(query));
      }, onConfigure: (db) async {
        await db.execute("PRAGMA foreign_keys = ON");
      });

      // arrange
      DBBasicQuiries db = DBBasicQuiries(db: dbhelper);
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

      await db.close();
    });
    test('Update EmailAddress', () async {
      var dbhelper = openDatabase(inMemoryDatabasePath, version: 1,
          onCreate: (db, version) async {
        DBStrings().all.forEach((query) async => await db.execute(query));
      }, onConfigure: (db) async {
        await db.execute("PRAGMA foreign_keys = ON");
      });

      // arrange
      DBBasicQuiries db = DBBasicQuiries(db: dbhelper);
      var res = await db.insertEmail(email);
      EmailAddress update = EmailAddress('newemail');
      update.id = res;

      // act
      var val = await db.updateEmailAddress(update);

      // assert
      expect(val, 1);

      await db.close();
    });
    test('Delete Phone', () async {
      var dbhelper = openDatabase(inMemoryDatabasePath, version: 1,
          onCreate: (db, version) async {
        DBStrings().all.forEach((query) async => await db.execute(query));
      }, onConfigure: (db) async {
        await db.execute("PRAGMA foreign_keys = ON");
      });

      // arrange
      DBBasicQuiries db = DBBasicQuiries(db: dbhelper);
      var res = await db.insertPhone(phone);

      // act
      var val = await db.deletePhone(res);

      // assert
      // where 1 is the number of rows affected
      expect(val, 1);

      await db.close();
    });
    test('Delete EmailAddress', () async {
      var dbhelper = openDatabase(inMemoryDatabasePath, version: 1,
          onCreate: (db, version) async {
        DBStrings().all.forEach((query) async => await db.execute(query));
      }, onConfigure: (db) async {
        await db.execute("PRAGMA foreign_keys = ON");
      });

      // arrange
      DBBasicQuiries db = DBBasicQuiries(db: dbhelper);
      var res = await db.insertEmail(email);

      // act
      var val = await db.deleteEmailAddress(res);

      // assert
      expect(val, 1);

      await db.close();
    });
  });
}
