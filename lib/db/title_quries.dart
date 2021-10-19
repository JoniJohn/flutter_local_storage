import 'package:local_storage/models/agent/title.dart';
import 'package:sqflite/sqflite.dart';

class TitleBasicQueries {
  TitleBasicQueries({required this.db});

  final Future<Database> db;

  // Title CRUD
  // create
  Future<int> insertJobTitle(JobTitle title) async {
    return 0;
  }

  // read
  Future<List<JobTitle>> getJobTitles() async {
    return [];
  }

  Future<List<JobTitle>> getJobTitleByID(int id) async {
    return [];
  }

  // update
  Future<int> updateJobTitle(JobTitle title) async {
    return 0;
  }

  // delete
  Future<int> deleteJobTitle(int id) async {
    return 0;
  }

  Future close() async {
    Database db = await this.db;
    db.close();
  }
}
