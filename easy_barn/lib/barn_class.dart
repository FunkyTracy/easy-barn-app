class Barn {
  String name;
  String owner;
  String address;
  String phoneNumber;

  Barn(
      {required this.address,
      required this.name,
      required this.owner,
      required this.phoneNumber});

  static Barn fromJson(json) => Barn(
      address: json['address'],
      name: json['name'],
      owner: json['owner'],
      phoneNumber: json['phoneNumber']);

  Map<String, dynamic> toMap() {
    return {
      'address': address,
      'name': name,
      'owner': owner,
      'number': phoneNumber
    };
  }

  Barn.fromMap(Map<String, dynamic> barnMap)
      : name = barnMap['name'],
        address = barnMap['address'],
        owner = barnMap['owner'].toString(),
        phoneNumber = barnMap['number'];

  factory Barn.fromFirestore(Map<String, dynamic> data) {
    return Barn(
        name: data['name'] ?? '',
        address: data['address'],
        owner: data['owner'],
        phoneNumber: data['phoneNumber']);
  }
}

const barns = [
  {
    'address': '12410 NE 152nd Ave, Brush Prairie, WA 98606',
    'name': 'Sterling Creek Farm',
    'owner': 'Jill Standish-Barker',
    'phoneNumber': '503-145-2369'
  },
  {
    'address': '16712 NW 11th Ave, Ridgefield, WA 98642',
    'name': 'Whipple Creek Farms',
    'owner': 'Jesus Chavez',
    'phoneNumber': '541-896-7456'
  }
];
