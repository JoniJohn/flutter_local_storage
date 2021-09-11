class Company {
  int? id;
  String? name;
  String? country;
  int? contact; // foreign key

  Company(this.name, this.country, this.contact);

  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{};

    map['company_name'] = name;
    map['country'] = country;
    map['contact'] = contact;
    if (id != null) map['company_id'] = id;

    return map;
  }

  Company.fromObject(dynamic obj) {
    id = obj['id'];
    name = obj['company_name'];
    country = obj['country'];
    contact = obj['contact'];
  }
}
