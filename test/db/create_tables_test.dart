import 'package:flutter_test/flutter_test.dart';
import 'package:local_storage/db/db_strings.dart';
import 'package:local_storage/models/agent/agent.dart';
import 'package:local_storage/models/agent/agent_contact.dart';
import 'package:local_storage/models/agent/agent_role.dart';
import 'package:local_storage/models/agent/agent_title.dart';
import 'package:local_storage/models/agent/role.dart';
import 'package:local_storage/models/agent/title.dart';
import 'package:local_storage/models/contact/email.dart';
import 'package:local_storage/models/contact/phone.dart';
import 'package:local_storage/models/organization/company.dart';
import 'package:local_storage/models/organization/company_contact.dart';
import 'package:local_storage/models/organization/department.dart';
import 'package:local_storage/models/organization/dept_contacts.dart';
import 'package:local_storage/models/organization/dept_dept.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';

Future main() async {
  setUpAll(() {
    sqfliteFfiInit();
    databaseFactory = databaseFactoryFfi;
  });

  group('Table Creation Test:', () {
    test('Phone', () async {
      var dbhelper = await openDatabase(inMemoryDatabasePath, version: 1,
          onCreate: (db, version) async {
        await db.execute(DBStrings().phone);
      }, onConfigure: (db) async {
        await db.execute("PRAGMA foreign_keys = ON");
      });
      // arrange
      var phone = Phone('267', 'Mobile', '71717272');

      // act
      await dbhelper.insert('phone', phone.toMap());

      // assert
      expect(await dbhelper.query('phone'), [
        {
          'id': 1,
          'zip_code': '267',
          'type_name': 'Mobile',
          'phone_number': '71717272',
        }
      ]);

      dbhelper.close();
    });

    test('Email', () async {
      var dbhelper = await openDatabase(inMemoryDatabasePath, version: 1,
          onCreate: (db, version) async {
        await db.execute(DBStrings().email);
      }, onConfigure: (db) async {
        await db.execute("PRAGMA foreign_keys = ON");
      });

      //arrange
      var email = EmailAddress('address@gmail.com');

      // act
      await dbhelper.insert('email', email.toMap());

      // assert
      expect(await dbhelper.query('email'), [
        {
          'id': 1,
          'description': null,
          'address': 'address@gmail.com',
        }
      ]);

      dbhelper.close();
    });

    test('Company', () async {
      var dbhelper = await openDatabase(inMemoryDatabasePath, version: 1,
          onCreate: (db, version) async {
        await db.execute(DBStrings().company);
      }, onConfigure: (db) async {
        await db.execute("PRAGMA foreign_keys = ON");
      });

      // arrange
      var company = Company('Shoppinga', 'Botswana');

      // act
      await dbhelper.insert('company', company.toMap());

      // assert
      expect(await dbhelper.query('company'), [
        {
          'id': 1,
          'name': 'Shoppinga',
          'country': 'Botswana',
        },
      ]);

      dbhelper.close();
    });

    test('Department', () async {
      var dbhelper = await openDatabase(inMemoryDatabasePath, version: 1,
          onCreate: (db, version) async {
        await db.execute(DBStrings().company);
        await db.execute(DBStrings().department);
      }, onConfigure: (db) async {
        await db.execute("PRAGMA foreign_keys = ON");
      });

      // arrange
      var dept = Department('IT Dept', 'For all your IT needs...', 1);
      var comp = Company('Shoppinga', 'BW');

      // act
      await dbhelper.insert('company', comp.toMap());
      await dbhelper.insert('department', dept.toMap());

      // assert
      expect(
        await dbhelper.query('department'),
        [
          {
            'id': 1,
            'name': 'IT Dept',
            'description': 'For all your IT needs...',
            'company_id': 1,
          }
        ],
      );

      dbhelper.close();
    });

    test('Agent', () async {
      var dbhelper = await openDatabase(inMemoryDatabasePath, version: 1,
          onCreate: (db, version) async {
        await db.execute(DBStrings().agent);
      }, onConfigure: (db) async {
        await db.execute("PRAGMA foreign_keys = ON");
      });

      // arrange
      var agent = Agent('Mr.', 'Lesley', 'Thuto', 'Johnson', 1, 'M');

      // act
      await dbhelper.insert('agent', agent.toMap());

      //assert
      expect(
        await dbhelper.query('agent'),
        [
          {
            'id': 1,
            'salutation': 'Mr.',
            'firstname': 'Lesley',
            'middlenames': 'Thuto',
            'lastname': 'Johnson',
            'user_id': 1,
            'gender': 'M'
          }
        ],
      );

      dbhelper.close();
    });

    test('Department Relation test', () async {
      var dbhelper = await openDatabase(inMemoryDatabasePath, version: 1,
          onCreate: (db, version) async {
        await db.execute(DBStrings().company);
        await db.execute(DBStrings().department);
        await db.execute(DBStrings().deptDept);
      }, onConfigure: (db) async {
        await db.execute("PRAGMA foreign_keys = ON");
      });

      // arrange
      Company company = Company('FMB', 'BW');
      Department departmentAbove = Department('Operations', 'Ops', 1);
      Department departmentBelow = Department('CPC', 'Account Opening', 1);
      DeptDept dept = DeptDept(1, 2);

      // act
      await dbhelper.insert('company', company.toMap());
      await dbhelper.insert('department', departmentAbove.toMap());
      await dbhelper.insert('department', departmentBelow.toMap());
      await dbhelper.insert('deptdept', dept.toMap());

      // assert
      expect(await dbhelper.query('deptdept'), [
        {
          'id': 1,
          'above_dept_id': 1,
          'below_dept_id': 2,
        }
      ]);
      dbhelper.close();
    });

    test('Company Phone', () async {
      var dbhelper = await openDatabase(inMemoryDatabasePath, version: 1,
          onCreate: (db, version) async {
        await db.execute(DBStrings().phone);
        await db.execute(DBStrings().company);
        await db.execute(DBStrings().companyPhone);
      }, onConfigure: (db) async {
        await db.execute("PRAGMA foreign_keys = ON");
      });

      // arrange
      Company company = Company('FMB', 'BW');
      Phone phone = Phone('267', 'ext', '71727374');
      CompanyNumber companyNumber = CompanyNumber(1, 1);

      // act
      await dbhelper.insert('phone', phone.toMap());
      await dbhelper.insert('company', company.toMap());
      await dbhelper.insert('companyPhone', companyNumber.toMap());

      // assert
      expect(await dbhelper.query('companyPhone'), [
        {
          'id': 1,
          'company_id': 1,
          'phone_id': 1,
        }
      ]);

      dbhelper.close();
    });

    test('Company Email', () async {
      var dbhelper = await openDatabase(inMemoryDatabasePath, version: 1,
          onCreate: (db, version) async {
        await db.execute(DBStrings().company);
        await db.execute(DBStrings().email);
        await db.execute(DBStrings().companyEmail);
      }, onConfigure: (db) async {
        await db.execute("PRAGMA foreign_keys = ON");
      });

      // arrange
      Company company = Company('FMB', 'BW');
      EmailAddress emailAddress = EmailAddress('whosekid@gmail.com');
      CompanyEmail companyEmail = CompanyEmail(1, 1);

      // act
      await dbhelper.insert('company', company.toMap());
      await dbhelper.insert('email', emailAddress.toMap());
      await dbhelper.insert('companyEmail', companyEmail.toMap());

      // assert
      expect(await dbhelper.query('companyEmail'), [
        {
          'id': 1,
          'company_id': 1,
          'email_id': 1,
        }
      ]);

      dbhelper.close();
    });

    test('Department Phone', () async {
      var dbhelper = await openDatabase(inMemoryDatabasePath, version: 1,
          onCreate: (db, version) async {
        await db.execute(DBStrings().phone);
        await db.execute(DBStrings().company);
        await db.execute(DBStrings().department);
        await db.execute(DBStrings().deptPhone);
      }, onConfigure: (db) async {
        await db.execute("PRAGMA foreign_keys = ON");
      });

      // arrange
      Phone phone = Phone('267', 'main', '71727374');
      Company company = Company('FMB', 'BW');
      Department department = Department('IT', 'Technical Issues', 1);
      DeptNumber deptNumber = DeptNumber(1, 1);

      // act
      await dbhelper.insert('phone', phone.toMap());
      await dbhelper.insert('company', company.toMap());
      await dbhelper.insert('department', department.toMap());
      await dbhelper.insert('deptPhone', deptNumber.toMap());

      // assert
      expect(await dbhelper.query('deptPhone'), [
        {
          'id': 1,
          'dept_id': 1,
          'phone_id': 1,
        }
      ]);

      dbhelper.close();
    });

    test('Department Email', () async {
      var dbhelper = await openDatabase(inMemoryDatabasePath, version: 1,
          onCreate: (db, version) async {
        await db.execute(DBStrings().email);
        await db.execute(DBStrings().company);
        await db.execute(DBStrings().department);
        await db.execute(DBStrings().deptEmail);
      }, onConfigure: (db) async {
        await db.execute("PRAGMA foreign_keys = ON");
      });

      // arrange
      EmailAddress emailAddress = EmailAddress('kid@gmail.com');
      Company company = Company('FMB', 'BW');
      Department department = Department('IT', 'Short desc', 1);
      DeptEmail deptEmail = DeptEmail(1, 1);

      // act
      await dbhelper.insert('email', emailAddress.toMap());
      await dbhelper.insert('company', company.toMap());
      await dbhelper.insert('department', department.toMap());
      await dbhelper.insert('deptEmail', deptEmail.toMap());

      // assert
      expect(await dbhelper.query('deptEmail'), [
        {
          'id': 1,
          'dept_id': 1,
          'email_id': 1,
        }
      ]);

      dbhelper.close();
    });

    test('Agent Phone', () async {
      var dbhelper = await openDatabase(inMemoryDatabasePath, version: 1,
          onCreate: (db, version) async {
        await db.execute(DBStrings().agent);
        await db.execute(DBStrings().phone);
        await db.execute(DBStrings().agentPhone);
      }, onConfigure: (db) async {
        await db.execute("PRAGMA foreign_keys = ON");
      });

      // arrange
      Agent agent = Agent('DR', 'firstname', 'middlenames', 'lastname', 1, 'M');
      Phone phone = Phone('000', 'main', '71727374');
      AgentNumber agentNumber = AgentNumber(1, 1);

      // act
      await dbhelper.insert('agent', agent.toMap());
      await dbhelper.insert('phone', phone.toMap());
      await dbhelper.insert('agentPhone', agentNumber.toMap());

      // assert
      expect(await dbhelper.query('agentPhone'), [
        {
          'id': 1,
          'agent_id': 1,
          'phone_id': 1,
        }
      ]);

      dbhelper.close();
    });

    test('Agent Email', () async {
      var dbhelper = await openDatabase(inMemoryDatabasePath, version: 1,
          onCreate: (db, version) async {
        await db.execute(DBStrings().agent);
        await db.execute(DBStrings().email);
        await db.execute(DBStrings().agentEmail);
      }, onConfigure: (db) async {
        await db.execute("PRAGMA foreign_keys = ON");
      });

      // arrange
      Agent agent = Agent('DR', 'firstname', 'middlenames', 'lastname', 1, 'M');
      EmailAddress emailAddress = EmailAddress('kid@gmail.com');
      AgentEmail agentEmail = AgentEmail(1, 1);

      // act
      await dbhelper.insert('agent', agent.toMap());
      await dbhelper.insert('email', emailAddress.toMap());
      await dbhelper.insert('agentEmail', agentEmail.toMap());

      // assert
      expect(await dbhelper.query('agentEmail'), [
        {
          'id': 1,
          'agent_id': 1,
          'email_id': 1,
        }
      ]);

      dbhelper.close();
    });

    test('Role', () async {
      var dbhelper = await openDatabase(inMemoryDatabasePath, version: 1,
          onCreate: (db, version) async {
        await db.execute(DBStrings().company);
        await db.execute(DBStrings().department);
        await db.execute(DBStrings().role);
      }, onConfigure: (db) async {
        await db.execute("PRAGMA foreign_keys = ON");
      });

      // arrange
      Company company = Company('name', 'BW');
      var resCo = await dbhelper.insert('company', company.toMap());
      Department department = Department('IT', 'desc', resCo);
      var resDept = await dbhelper.insert('department', department.toMap());
      Role role = Role('name', 'desc', resDept);

      // act
      await dbhelper.insert('role', role.toMap());

      // assert
      expect(await dbhelper.query('role'), [
        {
          'id': 1,
          'name': role.name,
          'description': role.desc,
          'dept_id': role.dept,
        }
      ]);

      dbhelper.close();
    });

    test('Title', () async {
      var dbhelper = await openDatabase(inMemoryDatabasePath, version: 1,
          onCreate: (db, version) async {
        await db.execute(DBStrings().title);
      }, onConfigure: (db) async {
        await db.execute("PRAGMA foreign_keys = ON");
      });

      // arrange
      JobTitle title = JobTitle('officer', 'desc');

      // act
      await dbhelper.insert('jobTitle', title.toMap());

      // assert
      expect(await dbhelper.query('jobTitle'), [
        {
          'id': 1,
          'name': title.name,
          'description': title.desc,
        }
      ]);

      dbhelper.close();
    });

    test('Agent Role', () async {
      var dbhelper = await openDatabase(inMemoryDatabasePath, version: 1,
          onCreate: (db, version) async {
        await db.execute(DBStrings().company);
        await db.execute(DBStrings().department);
        await db.execute(DBStrings().role);
        await db.execute(DBStrings().agent);
        await db.execute(DBStrings().agentRole);
      }, onConfigure: (db) async {
        await db.execute("PRAGMA foreign_keys = ON");
      });

      // arrange
      Company company = Company('name', 'country');
      var companyID = await dbhelper.insert('company', company.toMap());
      Department department = Department('name', 'desc', companyID);
      var deptID = await dbhelper.insert('department', department.toMap());
      Role role = Role('name', 'desc', deptID);
      var roleID = await dbhelper.insert('role', role.toMap());
      Agent agent = Agent('DR', 'firstname', 'middlenames', 'lastname', 1, 'M');
      var agentID = await dbhelper.insert('agent', agent.toMap());
      AgentRole agentRole = AgentRole(agentID, roleID, '23.01.2021');

      // act
      await dbhelper.insert('agentRole', agentRole.toMap());

      // assert
      expect(await dbhelper.query('agentRole'), [
        {
          'id': 1,
          'role_id': agentRole.role,
          'agent_id': agentRole.agent,
          'start_date': agentRole.start,
          'end_date': agentRole.end,
          'reason': agentRole.reason,
        }
      ]);

      dbhelper.close();
    });

    test('Agent Job Title', () async {
      var dbhelper = await openDatabase(inMemoryDatabasePath, version: 1,
          onCreate: (db, version) async {
        await db.execute(DBStrings().company);
        await db.execute(DBStrings().department);
        await db.execute(DBStrings().title);
        await db.execute(DBStrings().agent);
        await db.execute(DBStrings().agentTitle);
      }, onConfigure: (db) async {
        await db.execute("PRAGMA foreign_keys = ON");
      });

      // arrange
      Company company = Company('name', 'country');
      var companyID = await dbhelper.insert('company', company.toMap());
      Department department = Department('name', 'desc', companyID);
      var deptID = await dbhelper.insert('department', department.toMap());
      JobTitle title = JobTitle('officer', 'desc');
      var titleID = await dbhelper.insert('jobTitle', title.toMap());
      Agent agent = Agent('DR', 'firstname', 'middlenames', 'lastname', 1, 'M');
      var agentID = await dbhelper.insert('agent', agent.toMap());
      AgentTitle agentTitle =
          AgentTitle(agentID, deptID, titleID, '23.01.2021');

      // act
      await dbhelper.insert('agentTitle', agentTitle.toMap());

      // assert
      expect(await dbhelper.query('agentTitle'), [
        {
          'id': 1,
          'agent_id': agentTitle.agent,
          'dept_id': agentTitle.dept,
          'title_id': agentTitle.title,
          'start_date': agentTitle.start,
          'end_date': agentTitle.end,
          'reason': agentTitle.reason,
        }
      ]);

      dbhelper.close();
    });
  });
}
