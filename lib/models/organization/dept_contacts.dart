import 'package:local_storage/models/abstract/entity_contact.dart';

class DeptNumber extends EntityContact {
  @override
  String entityFieldName = 'dept_id';

  DeptNumber(int? entity, int? contact) : super(entity, contact);

  @override
  String contactFieldName = 'phone_id';
}

class DeptEmail extends EntityContact {
  @override
  String contactFieldName = 'dept_id';

  @override
  String entityFieldName = 'email_id';

  DeptEmail(int? entity, int? contact) : super(entity, contact);
}
