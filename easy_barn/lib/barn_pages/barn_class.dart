class Barn {
  String id;
  String name;
  String ownerid;
  String address;
  String phoneNumber;

  Barn(
      {required this.id,
      required this.address,
      required this.name,
      required this.ownerid,
      required this.phoneNumber});

  Map<String, dynamic> toMap() {
    return {'address': address, 'name': name, 'number': phoneNumber};
  }
}
