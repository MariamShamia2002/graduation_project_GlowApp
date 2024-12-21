class Person {
  late String id;
  late String name;
  late String email;
  late int age;

  late String skinType;
  late List<String> skinConcerns;
  late List<Map<String, dynamic>> savedRoutines;

  // late DateTime dateOfBirth ;

  Person();
  Person.fromMap(Map<String, dynamic> documentMap) {
    id = documentMap['id'];
    name = documentMap['name'];
    email = documentMap['email'];
    age = documentMap['age'];
    skinType = documentMap['skinType'];
    skinConcerns = List<String>.from(documentMap['skinConcerns']);
    savedRoutines =
        List<Map<String, dynamic>>.from(documentMap['savedRoutines']);
  }
  Map<String, dynamic> toMap() {
    Map<String, dynamic> map = <String, dynamic>{};
    map['id'] = id;
    map['name'] = name;
    map['email'] = email;
    map['age'] = age;
    map['skinConcerns'] = skinConcerns;
    map['skinType'] = skinType;
    map['savedRoutines'] = savedRoutines;

    return map;
  }
}
