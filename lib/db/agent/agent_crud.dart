import 'package:local_storage/models/agent/agent.dart';
import 'package:sqflite/sqflite.dart';

class AgentCRUD {
  AgentCRUD({required this.db});

  final Future<Database> db;
  // Agent CRUD
  // create
  Future<int> insertAgent(Agent agent) async {
    Database db = await this.db;
    var res = await db.insert('agent', agent.toMap());
    return res;
  }

  // read
  Future<List<Agent>> getAgents() async {
    Database db = await this.db;
    var res = await db.query('agent');
    List<Agent> agents = res.map((e) => Agent.fromObject(e)).toList();
    return agents;
  }

  Future<List<Agent>> getAgentByID(int id) async {
    Database db = await this.db;
    var res = await db.query('agent', where: "id = ?", whereArgs: [id]);
    List<Agent> agents = res.map((e) => Agent.fromObject(e)).toList();
    return agents;
  }

  // update
  Future<int> updateAgent(Agent agent) async {
    Database db = await this.db;
    var res = await db.update('agent', agent.toMap());
    return res;
  }

  // delete
  Future<int> deleteAgent(int id) async {
    Database db = await this.db;
    var res = await db.delete('agent', where: "id = ?", whereArgs: [id]);
    return res;
  }

  // close db
  Future close() async {
    Database db = await this.db;
    db.close();
  }
}
