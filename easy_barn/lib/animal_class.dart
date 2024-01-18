class Animal {
  final String Name;
  final String Owner;

  const Animal({required this.Name, required this.Owner});

  static Animal fromJson(json) =>
      Animal(Name: json['name'], Owner: json['owner']);
}

const sterlingCreekAnimals = [
  {'name': 'Smokey', 'owner': 'Ashlyn'},
  {'name': 'Wimpy', 'owner': 'Sandy'}
];

const whippleCreekAnimals = [
  {'name': 'Casino', 'owner': 'Jennifer'},
  {'name': 'Cash', 'owner': 'Kristen'}
];
