abstract class EntityContact {
  EntityContact(this.entity, this.contact);

  abstract String entityFieldName;

  int? id;
  int? entity;
  int? contact;

  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{};

    map[entityFieldName] = entity;
    map['contact_id'] = contact;
    if (id != null) map['id'] = id;

    return map;
  }

  EntityContact.fromObject(dynamic obj) {
    id = obj['id'];
    entity = obj[entityFieldName];
    contact = obj['contact_id'];
  }
}
