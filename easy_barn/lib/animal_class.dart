class Animal {
  String Name;
  String Owner;
  String Description;
  String Stall;
  String FeedingInstructions;
  String Medications;
  String Vet;
  String Farrier;

  Animal(
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
  {
    'name': 'Casino',
    'owner': 'Jennifer',
    'description': 'Chestnut Quarter Horse',
    'stall': 'Stall #45',
    'feeding': 'One baggie AM and PM',
    'medications': 'None',
    'vet': 'Unknown',
    'farrier': 'Unknown'
  },
  {
    'name': 'Cash',
    'owner': 'Kristen',
    'description': 'Sorrel Quarter Horse Paint',
    'stall': 'Stall #61',
    'feeding': 'One scoop LMF and one scoop haystack AM and PM',
    'medications': 'None',
    'vet': 'Unknown',
    'farrier': 'Unknown'
  }
];
