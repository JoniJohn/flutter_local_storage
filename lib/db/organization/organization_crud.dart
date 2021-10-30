import 'package:local_storage/models/organization/company.dart';
import 'package:sqflite/sqlite_api.dart';

class CompanyCRUD {
  CompanyCRUD({required this.db});

  final Future<Database> db;

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

  Future close() async {
    Database db = await this.db;
    await db.close();
  }
}
