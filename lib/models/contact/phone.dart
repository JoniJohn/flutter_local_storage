class Phone {
  int? id;
  String? zip;
  String? number;

  Phone(this.zip, this.number);

  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{};

    map['zip_code'] = zip;
    map['phone_number'] = number;
    if (id != null) map['id'] = id;

    return map;
  }

  Phone.fromObject(dynamic obj) {
    id = obj['id'];
    zip = obj['zip_code'];
    number = obj['phone_number'];
  }
}
