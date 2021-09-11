class Agent {
  int? id;
  String? salutation; // e.g DR. Mr. Mrs.
  String? firstname;
  String? middlenames;
  String? lastname;
  int? user; // foreign key to user
  String? gender;

  Agent(this.salutation, this.firstname, this.middlenames, this.lastname,
      this.user, this.gender);

  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{};

    map['salutation'] = salutation;
    map['firstname'] = firstname;
    map['middlenames'] = middlenames;
    map['lastname'] = lastname;
    map['user_id'] = user;
    map['gender'] = gender;
    if (id != null) map['id'] = id;

    return map;
  }

  Agent.fromObject(dynamic obj) {
    id = obj['id'];
    salutation = obj['salutation'];
    firstname = obj['firstname'];
    middlenames = obj['middlenames'];
    lastname = obj['lastname'];
    user = obj['user_id'];
    gender = obj['gender'];
  }
}
