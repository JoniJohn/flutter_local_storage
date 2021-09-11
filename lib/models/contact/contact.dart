class Contact {
  int? id;
  // can be options between 'mobile/direct/personal/workemail?'
  String? description;
  int? numbers;
  int? emails;

  Contact(this.description, this.numbers, this.emails);

  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{};

    map['description'] = description;
    map['phone_numbers'] = numbers;
    map['email_addresses'] = emails;
    if (id != null) map['id'] = id;

    return map;
  }

  Contact.fromObject(dynamic obj) {
    id = obj['id'];
    description = obj['description'];
    numbers = obj['phone_numbers'];
    emails = obj['email_addresses'];
  }
}
