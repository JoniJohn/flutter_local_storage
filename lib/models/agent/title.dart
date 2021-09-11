class JobTitle {
  int? id;
  String? name; // e.g Manager
  String? desc;

  JobTitle(this.name, this.desc);

  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{};

    map['name'] = name;
    map['description'] = desc;
    if (id != null) map['id'] = id;

    return map;
  }

  JobTitle.fromObject(dynamic obj) {
    id = obj['id'];
    name = obj['name'];
    desc = obj['description'];
  }
}
