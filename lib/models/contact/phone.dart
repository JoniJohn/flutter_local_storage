class Phone {
  int? id;
  String? name; // type e.g mobile, direct, ext
  String? zip;
  String? number;

  Phone(this.zip, this.name, this.number);

  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{};

    map['type_name'] = name;
    map['zip_code'] = zip;
    map['phone_number'] = number;
    if (id != null) map['id'] = id;

    return map;
  }

  Phone.fromObject(dynamic obj) {
    id = obj['id'];
    name = obj['type_name'];
    zip = obj['zip_code'];
    number = obj['phone_number'];
  }
}
