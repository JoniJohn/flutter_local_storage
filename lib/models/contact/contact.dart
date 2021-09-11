class Contact {
  int? id;
  String? name;
  String? description;
  int? numbers;
  int? emails;

  Contact(this.name, this.description, this.numbers, this.emails);

  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{};

    map['contact_name'] = name;
    map['description'] = description;
    map['phone_numbers'] = numbers;
    map['email_addresses'] = emails;
    if (id != null) map['id'] = id;

    return map;
  }

  Contact.fromObject(dynamic obj) {
    id = obj['id'];
    name = obj['contact_name'];
    description = obj['description'];
    numbers = obj['phone_numbers'];
    emails = obj['email_addresses'];
  }
}
