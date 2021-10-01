class Role {
  int? id;
  String? name; // options Support
  String? desc;
  int? dept; // foreign key to department

  Role(this.name, this.desc, this.dept);

  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{};

    map['name'] = name;
    map['description'] = desc;
    map['dept_id'] = dept;
    if (id != null) map['id'] = id;

    return map;
  }

  Role.fromObject(dynamic obj) {
    id = obj['id'];
    name = obj['name'];
    desc = obj['description'];
    dept = obj['dept_id'];
  }
}
