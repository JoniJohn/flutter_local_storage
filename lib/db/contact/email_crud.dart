import 'package:local_storage/models/contact/email.dart';
import 'package:sqflite/sqflite.dart';

class EmailCRUD {
  EmailCRUD({required this.db});
  final Future<Database> db;

  //CRUD METHODS
  // Contacts
  // Create Contacts
  Future<int> insertEmail(EmailAddress email) async {
    Database db = await this.db;
    var res = await db.insert('email', email.toMap());
    return res;
  }

  // Read Contacts

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
  Future<int> updateEmailAddress(EmailAddress email) async {
    Database db = await this.db;
    var res = await db.update('email', email.toMap());
    return res;
  }

  // Delete Contacts
  Future<int> deleteEmailAddress(int id) async {
    Database db = await this.db;
    var res = await db.delete('email', where: "id = ?", whereArgs: [id]);
    return res;
  }

  Future<void> close() async {
    Database db = await this.db;
    await db.close();
  }
}
