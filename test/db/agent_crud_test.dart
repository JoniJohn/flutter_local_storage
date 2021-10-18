// import 'dart:math';

import 'package:flutter_test/flutter_test.dart';
import 'package:local_storage/db/db_basic_quries.dart';
import 'package:local_storage/db/db_strings.dart';
import 'package:local_storage/models/agent/agent.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';

Future main() async {
  setUpAll(() {
    sqfliteFfiInit();
    databaseFactory = databaseFactoryFfi;
  });
  Agent agent =
      Agent("salutation", "firstname", "middlenames", "lastname", 1, "M");
  late Future<Database> dbhelper;
  late DBBasicQuiries db;

  setUp(() async {
    dbhelper = openDatabase(inMemoryDatabasePath, version: 1,
        onCreate: (db, version) async {
      DBStrings().all.forEach((query) async => await db.execute(query));
    }, onConfigure: (db) async {
      await db.execute("PRAGMA foreign_keys = ON");
    });
    db = DBBasicQuiries(db: dbhelper);
  });

  tearDown(() async {
    await db.close();
  });

  group("Agent CRUD:", () {
    test("Create Agent", () async {
      // act
      int res = await db.insertAgent(agent);
      // assert
      expect(res, 1);
    });
    test("Read Agents", () async {
      // read when there is no record
      List<Agent> res = await db.getAgents();

      // assert
      expect(res, []);

      // arrange
      var id = await db.insertAgent(agent);

      // act
      res = await db.getAgents();

      // assert
      expect(res.first.toMap(), {
        'id': id,
        'salutation': agent.salutation,
        'firstname': agent.firstname,
        'middlenames': agent.middlenames,
        'lastname': agent.lastname,
        'user_id': agent.user,
        'gender': agent.gender,
      });
    });
    test("Read Agent by ID", () async {
      // read when there is no matching record
      List<Agent> res = await db.getAgentByID(1);

      // assert
      expect(res, []);

      // arrange
      int id = await db.insertAgent(agent);

      // act
      res = await db.getAgentByID(id);

      // assert
      expect(res.first.toMap(), {
        'id': id,
        'salutation': agent.salutation,
        'firstname': agent.firstname,
        'middlenames': agent.middlenames,
        'lastname': agent.lastname,
        'user_id': agent.user,
        'gender': agent.gender,
      });
    });
    test("Update Agent", () async {
      // update when there is no matching record
      Agent updated = Agent(
          "salutation1", "firstname1", "middlenames1", "lastname1", 1, "F");
      updated.id = 1;
      // act
      int res = await db.updateAgent(updated);
      // assert
      expect(res, 0);
      // arrange
      int id = await db.insertAgent(agent);

      // act
      res = await db.updateAgent(updated);

      // assert
      expect(res, 1);
      expect((await db.getAgentByID(id)).first.toMap(), {
        'id': id,
        'salutation': updated.salutation,
        'firstname': updated.firstname,
        'middlenames': updated.middlenames,
        'lastname': updated.lastname,
        'user_id': updated.user,
        'gender': updated.gender,
      });
    });
    test("Delete Agent", () async {
      // deletion where there is no matching record
      int res = await db.deleteAgent(1);
      // assert
      expect(res, 0);
      // arrange
      int id = await db.insertAgent(agent);
      // act
      res = await db.deleteAgent(id);
      // assert
      expect(res, 1);
    });
  });
}
