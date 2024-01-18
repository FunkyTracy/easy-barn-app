class Barn {
  final String Name;
  final String Owner;
  final String Address;

  const Barn({required this.Address, required this.Name, required this.Owner});

  static Barn fromJson(json) =>
      Barn(Address: json['address'], Name: json['name'], Owner: json['owner']);
}

const barns = [
  {
    'address': '12410 NE 152nd Ave, Brush Prairie, WA 98606',
    'name': 'Sterling Creek Farm',
    'owner': 'Jill Standish-Barker'
  },
  {
    'address': '16712 NW 11th Ave, Ridgefield, WA 98642',
    'name': 'Whipple Creek Farms',
    'owner': 'Jesus Chavez'
  }
];
