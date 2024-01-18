class Animal {
  final String Name;
  final String Owner;
  final String Description;
  final String Stall;
  final String FeedingInstructions;
  final String Medications;
  final String Vet;
  final String Farrier;

  const Animal(
      {required this.Description,
      required this.Stall,
      required this.FeedingInstructions,
      required this.Medications,
      required this.Vet,
      required this.Farrier,
      required this.Name,
      required this.Owner});

  static Animal fromJson(json) => Animal(
      Description: json['description'],
      Stall: json['stall'],
      FeedingInstructions: json['feeding'],
      Medications: json['medications'],
      Vet: json['vet'],
      Farrier: json['farrier'],
      Name: json['name'],
      Owner: json['owner']);
}

const sterlingCreekAnimals = [
  {
    'name': 'Smokey',
    'owner': 'Ashlyn Funk-Tracy',
    'description': 'Buckskin Morgan',
    'stall': 'Second to last on the North side',
    'feeding': 'One AM baggy in the morning, one PM baggy in the evening',
    'medications': 'None',
    'vet': 'Countryside Equine Veterinary - (360)887-7814',
    'farrier': 'Shelby'
  },
  {
    'name': 'Wimpy',
    'owner': 'Sandy',
    'description': 'Bay Quarter Horse',
    'stall': 'Last on the North side',
    'feeding': 'One scoop alfalfa pellets and one baggie AM and PM',
    'medications': 'None',
    'vet': 'Countryside Equine Veterinary - (360)887-7814',
    'farrier': 'Scott'
  }
];

const whippleCreekAnimals = [
  {'name': 'Casino', 'owner': 'Jennifer'},
  {'name': 'Cash', 'owner': 'Kristen'}
];
