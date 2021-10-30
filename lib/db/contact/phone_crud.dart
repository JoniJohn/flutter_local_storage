import 'package:local_storage/models/contact/phone.dart';
import 'package:sqflite/sqflite.dart';

class PhoneCRUD {
  PhoneCRUD({required this.db});
  final Future<Database> db;

  //CRUD METHODS
  // Contacts
  // Create Contacts
  Future<int> insertPhone(Phone phone) async {
    Database db = await this.db;
    var res = await db.insert('phone', phone.toMap());
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

  // Update Contacts
  Future<int> updatePhone(Phone phone) async {
    Database db = await this.db;
    var res = await db.update('phone', phone.toMap());
    return res;
  }

  // Delete Contacts
  Future<int> deletePhone(int id) async {
    Database db = await this.db;
    var res = db.delete('phone', where: "id = ?", whereArgs: [id]);
    return res;
  }

  Future<void> close() async {
    Database db = await this.db;
    await db.close();
  }
}
