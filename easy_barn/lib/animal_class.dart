class Animal {
  String id;
  String name;
  String owner;
  String description;
  String stall;
  String feedingInstructions;
  String medications;
  String vet;
  String farrier;

  Animal(
      {required this.id,
      required this.description,
      required this.stall,
      required this.feedingInstructions,
      required this.medications,
      required this.vet,
      required this.farrier,
      required this.name,
      required this.owner});
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
