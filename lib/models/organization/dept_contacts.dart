import 'package:local_storage/models/abstract/entity_contact.dart';

class DeptContacts extends EntityContact {
  @override
  String entityFieldName = 'dept_id';

  DeptContacts(int? entity, int? contact) : super(entity, contact);
}
