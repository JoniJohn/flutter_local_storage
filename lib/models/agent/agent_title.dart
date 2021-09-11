class AgentTitle {
  int? id;
  int? agent;
  int? dept;
  int? title;
  String? start; // start date
  String? end; // end date
  String? reason;

  AgentTitle(this.agent, this.dept, this.title, this.start);

  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{};

    map['agent_id'] = agent;
    map['dept_id'] = dept;
    map['title_id'] = title;
    map['start_date'] = start;
    map['end_date'] = end;
    map['reason'] = reason;
    if (id != null) map['id'] = id;

    return map;
  }

  AgentTitle.fromObject(dynamic obj) {
    id = obj['id'];
    agent = obj['agent_id'];
    dept = obj['dept_id'];
    title = obj['title_id'];
    start = obj['start_date'];
    end = obj['end_date'];
    reason = obj['reason'];
  }
}
