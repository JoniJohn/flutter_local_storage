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
    CONSTRAINT fk_dept2 FOREIGN KEY (below_dept_id) REFERENCES department(id) ON DELETE CASCADE
  );
  ''';
  String companyPhone = '''
  create table companyPhone(
    id INTEGER PRIMARY KEY,
    company_id INTEGER NOT NULL,
    phone_id INTEGER NOT NULL,
    CONSTRAINT fk_company FOREIGN KEY (company_id) REFERENCES company(id) ON DELETE CASCADE,
    CONSTRAINT fk_phone FOREIGN KEY (phone_id) REFERENCES phone(id) ON DELETE CASCADE
  );
  ''';
  String companyEmail = '''
  create table companyEmail(
    id INTEGER PRIMARY KEY,
    company_id INTEGER NOT NULL,
    email_id INTEGER NOT NULL,
    CONSTRAINT fk_company FOREIGN KEY (company_id) REFERENCES company(id) ON DELETE CASCADE,
    CONSTRAINT fk_email FOREIGN KEY (email_id) REFERENCES email(id) ON DELETE CASCADE
  );
  ''';
  String deptPhone = '''
  create table deptPhone(
    id INTEGER PRIMARY KEY,
    dept_id INTEGER NOT NULL,
    phone_id INTEGER NOT NULL,
    CONSTRAINT fk_dept FOREIGN KEY (dept_id) REFERENCES department(id) ON DELETE CASCADE,
    CONSTRAINT fk_phone FOREIGN KEY (phone_id) REFERENCES phone(id) ON DELETE CASCADE
  );
  ''';
  String deptEmail = '''
  create table deptEmail(
    id INTEGER PRIMARY KEY,
    dept_id INTEGER NOT NULL,
    email_id INTEGER NOT NULL,
    CONSTRAINT fk_dept FOREIGN KEY (dept_id) REFERENCES department(id) ON DELETE CASCADE,
    CONSTRAINT fk_email FOREIGN KEY (email_id) REFERENCES email(id) ON DELETE CASCADE
  );
  ''';

  // role and title
  String role = '''
  create table role(
    id INTEGER PRIMARY KEY,
    name TEXT NOT NULL,
    description TEXT NOT NULL,
    dept_id INTEGER NOT NULL,
    CONSTRAINT fk_dept FOREIGN KEY (dept_id) REFERENCES department(id)
  );
  ''';
  String title = '''
  create table jobTitle(
    id INTEGER PRIMARY KEY,
    name TEXT NOT NULL,
    description TEXT NOT NULL
  );
  ''';

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
  String agentPhone = '''
  create table agentPhone(
    id INTEGER PRIMARY KEY,
    agent_id INTEGER NOT NULL,
    phone_id INTEGER NOT NULL,
    CONSTRAINT fk_agent FOREIGN KEY (agent_id) REFERENCES agent(id) ON DELETE CASCADE, 
    CONSTRAINT fk_phone FOREIGN KEY (phone_id) REFERENCES phone(id) ON DELETE CASCADE
  );
  ''';
  String agentEmail = '''
  create table agentEmail(
    id INTEGER PRIMARY KEY,
    agent_id INTEGER NOT NULL,
    email_id INTEGER NOT NULL,
    CONSTRAINT fk_agent FOREIGN KEY (agent_id) REFERENCES agent(id) ON DELETE CASCADE, 
    CONSTRAINT fk_email FOREIGN KEY (email_id) REFERENCES email(id) ON DELETE CASCADE
  );
  ''';
  String agentRole = '''
  create table agentRole(
    id INTEGER PRIMARY KEY,
    role_id INTEGER NOT NULL,
    agent_id INTEGER NOT NULL,
    start_date TEXT NOT NULL,
    end_date TEXT,
    reason TEXT,
    CONSTRAINT fk_role FOREIGN KEY (role_id) REFERENCES role(id) ON DELETE CASCADE,
    CONSTRAINT fk_agent FOREIGN KEY (agent_id) REFERENCES agent(id) ON DELETE CASCADE
  );
  ''';
  String agentTitle = '''
  create table agentTitle(
    id INTEGER PRIMARY KEY,
    agent_id INTEGER NOT NULL,
    dept_id INTEGER NOT NULL,
    title_id INTEGER NOT NULL,
    start_date TEXT NOT NULL,
    end_date TEXT,
    reason TEXT,
    CONSTRAINT fk_agent FOREIGN KEY (agent_id) REFERENCES agent(id) ON DELETE CASCADE,
    CONSTRAINT fk_dept FOREIGN KEY (dept_id) REFERENCES department(id) ON DELETE CASCADE,
    CONSTRAINT fk_title FOREIGN KEY (title_id) REFERENCES jobTitle(id) ON DELETE CASCADE
  );
  ''';

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
