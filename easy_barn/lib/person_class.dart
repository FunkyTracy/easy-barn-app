class Person {
  String id;
  String name;
  String phoneNumber;
  String emergencyPerson;
  String emergencyNumber;

  Person(
      {required this.id,
      required this.name,
      required this.phoneNumber,
      required this.emergencyPerson,
      required this.emergencyNumber});

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'number': phoneNumber,
      'emergencyPerson': emergencyPerson,
      'emergencyNumber': emergencyNumber
    };
  }
}
