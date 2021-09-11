class Role {
  int? id;
  String? name; // options Support
  String? desc; //

  Role(this.name, this.desc);

  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{};

    map['name'] = name;
    map['description'] = desc;
    if (id != null) map['id'] = id;

    return {};
  }

  Role.fromObject(dynamic obj) {
    id = obj['id'];
    name = obj['name'];
    desc = obj['description'];
  }
}
