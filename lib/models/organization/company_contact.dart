import 'package:local_storage/models/abstract/entity_contact.dart';

class CompanyNumber extends EntityContact {
  @override
  String entityFieldName = 'company_id';

  CompanyNumber(int? entity, int? contact) : super(entity, contact);

  @override
  String contactFieldName = 'phone_id';
}

class CompanyEmail extends EntityContact {
  @override
  String contactFieldName = 'company_id';

  @override
  String entityFieldName = 'email_id';

  CompanyEmail(int? entity, int? contact) : super(entity, contact);
}
