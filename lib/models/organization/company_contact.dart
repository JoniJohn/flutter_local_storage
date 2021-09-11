import 'package:local_storage/models/abstract/entity_contact.dart';

class CompanyContact extends EntityContact {
  @override
  String entityFieldName = 'company_id';

  CompanyContact(int? entity, int? contact) : super(entity, contact);
}
