class Barn {
  String Name;
  String Owner;
  String Address;
  String PhoneNumber;

  Barn(
      {required this.Address,
      required this.Name,
      required this.Owner,
      required this.PhoneNumber});

  static Barn fromJson(json) => Barn(
      Address: json['address'],
      Name: json['name'],
      Owner: json['owner'],
      PhoneNumber: json['phoneNumber']);
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
