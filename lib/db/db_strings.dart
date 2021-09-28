class DBStrings {
  // contact Strings
  String phone = '''
  create table phone(
    id INTEGER PRIMARY KEY,
    type_name TEXT NOT NULL,
    zip_code TEXT NOT NULL,
    phone_number TEXT NOT NULL
  );
  ''';
  String email = '''
  create table email(
    id INTEGER PRIMARY KEY,
    description TEXT,
    address TEXT NOT NULL 
  );
  ''';

  // company Strings
  String company = '''
  create table company(
    id INTEGER PRIMARY KEY,
    name TEXT UNIQUE NOT NULL,
    country TEXT NOT NULL
  );
  ''';
  String department = '''
  create table department(
    id INTEGER PRIMARY KEY,
    name TEXT UNIQUE NOT NULL,
    description TEXT,
    company_id INTEGER NOT NULL,
    CONSTRAINT fk_company FOREIGN KEY (company_id) REFERENCES company(id) ON DELETE CASCADE
  );
  ''';
  String deptDept = '''
  create table deptdept(
    id INTEGER PRIMARY KEY,
    above_dept_id INTEGER NOT NULL,
    below_dept_id INTEGER NOT NULL,
    CONSTRAINT fk_dept1 FOREIGN KEY (above_dept_id) REFERENCES department(id) ON DELETE CASCADE,
    CONSTRAINT fk_dept2 FOREIGN KEY (below_dept_id) REFERENCES department(id) ON DELETE CASCADE,
  );
  ''';
  String companyPhone = '';
  String companyEmail = '';
  String deptPhone = '';
  String deptEmail = '';

  // role and title
  String role = '';
  String title = '';

  // agent Strings
  String agent = '''
  create table agent(
    id INTEGER PRIMARY KEY,
    salutation TEXT,
    firstname TEXT NOT NULL,
    middlenames TEXT,
    lastname TEXT NOT NULL,
    user_id INTEGER UNIQUE NOT NULL,
    gender TEXT NOT NULL,
    CONSTRAINT gender_check CHECK(gender = 'M' or gender = 'F' or gender = 'O')
  );
  ''';
  String agentPhone = '';
  String agentEmail = '';
  String agentRole = '';
  String agentTitle = '';

  List<String> get contactQuries => [phone, email];
  List<String> get companyQueries => [
        company,
        department,
        deptDept,
        companyPhone,
        deptPhone,
        companyEmail,
        deptEmail,
      ];
  List<String> get roleQueries => [role, title];
  List<String> get agentQueries => [
        agent,
        agentPhone,
        agentEmail,
        agentRole,
        agentTitle,
      ];
  List<String> get all => contactQuries
    ..addAll(companyQueries)
    ..addAll(roleQueries)
    ..addAll(agentQueries);
}
