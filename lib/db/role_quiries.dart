import 'package:local_storage/models/agent/role.dart';
import 'package:sqflite/sqflite.dart';

class RoleQueries {
  RoleQueries({required this.db});

  final Future<Database> db;

  // Role CRUD
  // create
  Future<int> insertRole(Role role) async {
    Database db = await this.db;
    int res = await db.insert('role', role.toMap());
    return res;
  }

  // read
  Future<List<Role>> getRoles() async {
    Database db = await this.db;
    var res = await db.query('role');
    List<Role> roles = res.map((e) => Role.fromObject(e)).toList();
    return roles;
  }

  Future<List<Role>> getRoleByID(int id) async {
    Database db = await this.db;
    var res = await db.query('role', where: "id = ?", whereArgs: [id]);
    List<Role> roles = res.map((e) => Role.fromObject(e)).toList();
    return roles;
  }

  Future<List<Role>> getRolesByDept(int id) async {
    Database db = await this.db;
    var res = await db.query('role', where: "dept_id = ?", whereArgs: [id]);
    List<Role> roles = res.map((e) => Role.fromObject(e)).toList();
    return roles;
  }

  // update
  Future<int> updateRole(Role role) async {
    Database db = await this.db;
    int res = await db.update('role', role.toMap());
    return res;
  }

  // delete
  Future<int> deleteRole(int id) async {
    Database db = await this.db;
    int res = await db.delete('role', where: "id = ?", whereArgs: [id]);
    return res;
  }

  // close
  Future close() async {
    Database db = await this.db;
    await db.close();
  }
}
