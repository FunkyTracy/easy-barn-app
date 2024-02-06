class Animal {
  String id;
  String name;
  String ownerid;
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
      required this.ownerid});

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'description': description,
      'farrier': farrier,
      'feeding': feedingInstructions,
      'medications': medications,
      'stall': stall,
      'vet': vet
    };
  }
}
