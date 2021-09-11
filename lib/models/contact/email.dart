class EmailAddress {
  int? id;
  String? address;

  EmailAddress(this.address);

  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{};

    map['email_address'] = address;
    if (id != null) map['id'] = id;

    return map;
  }

  EmailAddress.fromObject(dynamic obj) {
    id = obj['id'];
    address = obj['address'];
  }
}
