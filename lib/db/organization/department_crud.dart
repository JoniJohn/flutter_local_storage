import 'package:local_storage/models/organization/department.dart';
import 'package:sqflite/sqlite_api.dart';

class DeptCRUD {
  DeptCRUD({required this.db});

  final Future<Database> db;

  // Department
  // Create a single [dept]
  Future<int> insertDept(Department dept) async {
    Database db = await this.db;
    var res = await db.insert('department', dept.toMap());
    return res;
  }

  // read a single [dept]
  Future<List<Department>> getDeptByID(int id) async {
    Database db = await this.db;
    var res = await db.query('department', where: "id = ?", whereArgs: [id]);
    List<Department> depts = res.map((e) => Department.fromObject(e)).toList();
    return depts;
  }

  Future<List<Department>> getDeptsByCoID(int id) async {
    Database db = await this.db;
    var res =
        await db.query('department', where: "company_id = ?", whereArgs: [id]);
    List<Department> depts = res.map((e) => Department.fromObject(e)).toList();
    return depts;
  }

  Future<List<Department>> getDepts() async {
    Database db = await this.db;
    var res = await db.query('department');
    List<Department> depts = res.map((e) => Department.fromObject(e)).toList();
    return depts;
  }

  // update
  Future<int> updateDept(Department dept) async {
    Database db = await this.db;
    var res = await db.update('department', dept.toMap());
    return res;
  }

  // delete
  Future<int> deleteDept(int id) async {
    Database db = await this.db;
    var res = await db.delete('department', where: "id = ?", whereArgs: [id]);
    return res;
  }

  // close db when done with it
  Future close() async {
    Database db = await this.db;
    await db.close();
  }
}
