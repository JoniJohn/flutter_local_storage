import 'package:local_storage/models/abstract/entity_contact.dart';

class AgentNumber extends EntityContact {
  @override
  String entityFieldName = 'agent_id';

  AgentNumber(int? entity, int? contact) : super(entity, contact);

  @override
  String contactFieldName = 'phone_id';
}

class AgentEmail extends EntityContact {
  @override
  String contactFieldName = 'agent_id';

  @override
  String entityFieldName = 'email_id';

  AgentEmail(int? entity, int? contact) : super(entity, contact);
}
