import 'package:local_storage/models/contact/email.dart';
import 'package:local_storage/models/contact/phone.dart';
import 'package:local_storage/models/organization/company.dart';
import 'package:local_storage/models/organization/department.dart';
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

  // Company
  // insert
  Future<int> insertCompany(Company company) async {
    Database db = await this.db;
    var res = await db.insert('company', company.toMap());
    return res;
  }

  // read
  Future<Company> getCompanyByID(int id) async {
    Database db = await this.db;
    var res = await db.query('company', where: "id = ?", whereArgs: [id]);
    List<Company> companies = res.map((e) => Company.fromObject(e)).toList();
    return companies.first;
  }

  Future<List<Company>> getCompanies() async {
    Database db = await this.db;
    var res = await db.query('company');
    List<Company> companies = res.map((e) => Company.fromObject(e)).toList();
    return companies;
  }

  // update
  Future<int> updateCompany(Company company) async {
    Database db = await this.db;
    var res = await db.update('company', company.toMap());
    return res;
  }

  // delete
  Future<int> deleteCompany(int id) async {
    Database db = await this.db;
    var res = await db.delete('company', where: 'id = ?', whereArgs: [id]);
    return res;
  }

  // Department
  // Create
  Future<int> insertDept(Department dept) async {
    return 0;
  }

  // read
  Future<Department> getDeptByID(int id) async {
    return Department(null, null, null);
  }

  Future<List<Department>> getDeptsByCoID(int id) async {
    return [];
  }

  Future<List<Department>> getDepts() async {
    return [];
  }

  // update
  Future<int> updateDept(Department dept) async {
    return 0;
  }

  // delete
  Future<int> deleteDept(int id) async {
    return 0;
  }
}
