import 'package:local_storage/models/abstract/entity_contact.dart';

class AgentContact extends EntityContact {
  @override
  String entityFieldName = 'agent_id';

  AgentContact(int? entity, int? contact) : super(entity, contact);
}
