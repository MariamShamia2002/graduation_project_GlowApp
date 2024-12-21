class Dermatologist {
  late String id;
  late String name;
  late String email;

  Dermatologist();
  Dermatologist.fromMap(Map<String, dynamic> documentMap) {
    // id = documentMap['id'];
    name = documentMap['name'];
    email = documentMap['email'];
  }
  Map<String, dynamic> toMap() {
    Map<String, dynamic> map = <String, dynamic>{};
    map['id'] = id;
    map['name'] = name;
    map['email'] = email;
    return map;
  }
}
