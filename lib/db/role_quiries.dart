import 'package:local_storage/models/agent/role.dart';
import 'package:sqflite/sqflite.dart';

class RoleQueries {
  RoleQueries({required this.db});

  final Future<Database> db;

  // Role CRUD
  // create
  Future<int> insertRole(Role role) async {
    return 0;
  }

  // read
  Future<List<Role>> getRoles() async {
    return [];
  }

  Future<List<Role>> getRoleByID(int id) async {
    return [];
  }

  Future<List<Role>> getRolesByDept(int id) async {
    return [];
  }

  // update
  Future<int> updateRole(Role role) async {
    return 0;
  }

  // delete
  Future<int> deleteRole(int id) async {
    return 0;
  }

  // close
  Future close() async {
    Database db = await this.db;
    await db.close();
  }
}
