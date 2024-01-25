class Person {
  String Name;
  String PhoneNumber;
  String EmergencyPerson;
  String EmergencyNumber;

  Person(
      {required this.Name,
      required this.PhoneNumber,
      required this.EmergencyPerson,
      required this.EmergencyNumber});

  static Person fromJson(json) => Person(
      Name: json['name'],
      PhoneNumber: json['phoneNumber'],
      EmergencyPerson: json['emergencyPerson'],
      EmergencyNumber: json['emergencyNumber']);
}

const sterlingPeople = [
  {
    'name': 'Ashlyn Funk-Tracy',
    'phoneNumber': '5037892368',
    'emergencyPerson': 'Rory McMahon',
    'emergencyNumber': '5032456879'
  },
  {
    'name': 'Sandy Something',
    'phoneNumber': '5031114444',
    'emergencyPerson': 'Sydney Something',
    'emergencyNumber': '5032225887'
  },
];

const whipplePeople = [
  {
    'name': 'Kristen Funk-Tracy',
    'phoneNumber': '50389658234',
    'emergencyPerson': 'Steve Funk-Tracy',
    'emergencyNumber': '5417758842'
  },
  {
    'name': 'Jennifer Something',
    'phoneNumber': '5031136644',
    'emergencyPerson': 'Jennifer\'s Husband',
    'emergencyNumber': '5032896641'
  },
];
