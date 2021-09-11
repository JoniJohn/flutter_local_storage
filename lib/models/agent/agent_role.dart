class AgentRole {
  int? id;
  int? agent; // foreign key
  int? dept; // foreign to department
  int? role; // foreign to role
  String? start; // start date
  String? end; // end date
  String? reason; // end reason, retired? promotion? termination? resign?

  AgentRole(this.agent, this.dept, this.role, this.start);

  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{};

    map['agent_id'] = agent;
    map['dept_id'] = dept;
    map['role_id'] = role;
    map['start_date'] = start;
    map['end_date'] = end;
    map['reason'] = reason;
    if (id != null) map['id'] = id;

    return map;
  }

  AgentRole.fromObject(dynamic obj) {
    id = obj['id'];
    role = obj['role_id'];
    agent = obj['agent_id'];
    dept = obj['dept_id'];
    start = obj['start_date'];
    end = obj['end_date'];
    reason = obj['reason'];
  }
}
