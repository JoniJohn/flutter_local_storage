abstract class EntityContact {
  EntityContact(this.entity, this.contact);

  abstract String entityFieldName;
  abstract String contactFieldName;

  int? id;
  int? entity;
  int? contact;

  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{};

    map[entityFieldName] = entity;
    map[contactFieldName] = contact;
    if (id != null) map['id'] = id;

    return map;
  }

  EntityContact.fromObject(dynamic obj) {
    id = obj['id'];
    entity = obj[entityFieldName];
    contact = obj[contactFieldName];
  }
}
