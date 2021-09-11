class Company {
  int? id;
  String? name;
  String? country;

  Company(
    this.name,
    this.country,
  );

  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{};

    map['company_name'] = name;
    map['country'] = country;
    if (id != null) map['company_id'] = id;

    return map;
  }

  Company.fromObject(dynamic obj) {
    id = obj['id'];
    name = obj['company_name'];
    country = obj['country'];
  }
}
