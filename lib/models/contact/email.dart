class EmailAddress {
  int? id;
  String? desc;
  String? address;

  EmailAddress(this.address);

  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{};

    map['description'] = desc;
    map['email_address'] = address;
    if (id != null) map['id'] = id;

    return map;
  }

  EmailAddress.fromObject(dynamic obj) {
    id = obj['id'];
    desc = obj['description'];
    address = obj['address'];
  }
}
