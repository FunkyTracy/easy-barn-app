class Animal {
  final String Name;
  final String Owner;

  const Animal({required this.Name, required this.Owner});

  static Animal fromJson(json) =>
      Animal(Name: json['name'], Owner: json['owner']);
}

const SterlingCreekAnimals = [
  {'name': 'Smokey', 'owner': 'Ashlyn'},
  {'name': 'Wimpy', 'owner': 'Sandy'}
];

const WhippleCreekAnimals = [
  {'name': 'Casino', 'owner': 'Jennifer'},
  {'name': 'Cash', 'owner': 'Kristen'}
];
