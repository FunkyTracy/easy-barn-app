class Barn {
  String id;
  String name;
  String owner;
  String address;
  String phoneNumber;

  Barn(
      {required this.id,
      required this.address,
      required this.name,
      required this.owner,
      required this.phoneNumber});

  Map<String, dynamic> toMap() {
    return {
      'address': address,
      'name': name,
      'owner': owner,
      'number': phoneNumber
    };
  }
}
