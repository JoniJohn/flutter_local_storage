class Department {
  int? id;
  String? name;
  String? desc;
  int? company;

  Department(this.name, this.desc, this.company);

  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{};

    map['name'] = name;
    map['description'] = desc;
    map['company_id'] = company;
    if (id != null) map['id'] = id;

    return map;
  }

  Department.fromObject(dynamic obj) {
    id = obj['id'];
    name = obj['name'];
    desc = obj['description'];
    company = obj['company_id'];
  }
}
