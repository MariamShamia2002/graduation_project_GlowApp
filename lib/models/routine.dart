class routines {
  late String id;
  late String description;
  late String name;
  late String urlImage;
  late String steps;
  late String skinType;
  late List skinConcerns;

  routines();
  routines.fromMap(Map<String, dynamic> documentMap) {
    // id = documentMap['id'];
    description = documentMap['description'];
    name = documentMap['name'];
    urlImage = documentMap['urlImage'];
    steps = documentMap['steps'];
    skinType = documentMap['skinType'];
    skinConcerns = documentMap['skinConcerns'];
  }
  Map<String, dynamic> toMap() {
    Map<String, dynamic> map = <String, dynamic>{};
    map['description'] = description;
    map['name'] = name;
    map['steps'] = steps;
    map['urlImage'] = urlImage;
    map['skinType'] = skinType;
    map['skinConcerns'] = skinConcerns;
    return map;
  }
}
