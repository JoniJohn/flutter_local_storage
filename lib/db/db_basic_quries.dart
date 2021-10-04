import 'package:local_storage/models/contact/email.dart';
import 'package:local_storage/models/contact/phone.dart';
import 'package:sqflite/sqflite.dart';

class DBBasicQuiries {
  DBBasicQuiries({required this.db});

  final Future<Database> db;

  //CRUD METHODS
  // Contacts
  // Create Contacts
  Future<int> insertPhone(Phone phone) async {
    Database db = await this.db;
    var res = await db.insert('phone', phone.toMap());
    return res;
  }

  Future<int> insertEmail(EmailAddress email) async {
    Database db = await this.db;
    var res = await db.insert('email', email.toMap());
    return res;
  }

  // Read Contacts
  Future<List<Phone>> getPhones() async {
    Database db = await this.db;
    var res = await db.query('phone');
    // convert to list of phones
    List<Phone> phones = res.map((e) => Phone.fromObject(e)).toList();
    return phones;
  }

  Future<Phone> getPhoneByID(int id) async {
    Database db = await this.db;
    var res = await db.query('phone', where: "id = ?", whereArgs: [id]);
    // Convert to list
    List<Phone> phones = res.map((e) => Phone.fromObject(e)).toList();
    // Return the first and only element of the list
    return phones.first;
  }

  Future<List<EmailAddress>> getEmailAddresses() async {
    Database db = await this.db;
    var res = await db.query('email');
    // convert to list
    List<EmailAddress> addresses =
        res.map((e) => EmailAddress.fromObject(e)).toList();
    return addresses;
  }

  Future<EmailAddress> getEmailAddressByID(int id) async {
    Database db = await this.db;
    var res = await db.query('email', where: "id = ?", whereArgs: [id]);
    // Convertr to list
    List<EmailAddress> emails =
        res.map((e) => EmailAddress.fromObject(e)).toList();
    // return the first and only element in array
    return emails.first;
  }

  // Update Contacts
  Future<int> updatePhone(Phone phone) async {
    Database db = await this.db;
    var res = await db.update('phone', phone.toMap());
    return res;
  }

  Future<int> updateEmailAddress(EmailAddress email) async {
    Database db = await this.db;
    var res = await db.update('email', email.toMap());
    return res;
  }

  // Delete Contacts
  Future<int> deletePhone(int id) async {
    Database db = await this.db;
    var res = db.delete('phone', where: "id = ?", whereArgs: [id]);
    return res;
  }

  Future<int> deleteEmailAddress(int id) async {
    Database db = await this.db;
    var res = await db.delete('email', where: "id = ?", whereArgs: [id]);
    return res;
  }

  Future<void> close() async {
    Database db = await this.db;
    db.close();
  }
}
