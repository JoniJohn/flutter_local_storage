import 'package:local_storage/models/agent/title.dart';
import 'package:sqflite/sqflite.dart';

class TitleBasicQueries {
  TitleBasicQueries({required this.db});

  final Future<Database> db;

  // Title CRUD
  // create
  Future<int> insertJobTitle(JobTitle title) async {
    Database db = await this.db;
    int res = await db.insert('jobTitle', title.toMap());
    return res;
  }

  // read
  Future<List<JobTitle>> getJobTitles() async {
    Database db = await this.db;
    var res = await db.query('jobTitle');
    List<JobTitle> titles = res.map((e) => JobTitle.fromObject(e)).toList();
    return titles;
  }

  Future<List<JobTitle>> getJobTitleByID(int id) async {
    Database db = await this.db;
    var res = await db.query('jobTitle', where: "id = ?", whereArgs: [id]);
    List<JobTitle> titles = res.map((e) => JobTitle.fromObject(e)).toList();
    return titles;
  }

  // update
  Future<int> updateJobTitle(JobTitle title) async {
    Database db = await this.db;
    int res = await db.update('jobTitle', title.toMap());
    return res;
  }

  // delete
  Future<int> deleteJobTitle(int id) async {
    Database db = await this.db;
    int res = await db.delete('jobTitle', where: "id = ?", whereArgs: [id]);
    return res;
  }

  Future close() async {
    Database db = await this.db;
    db.close();
  }
}
