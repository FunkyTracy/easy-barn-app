import 'package:flutter/material.dart';
import 'animal_class.dart' as animalClass;
import 'animal_detail_page.dart' as animalDetails;

class AnimalList extends StatefulWidget {
  final String name;

  const AnimalList({super.key, required this.name});

  @override
  State<AnimalList> createState() => _AnimalList();
}

class _AnimalList extends State<AnimalList> {
  List<animalClass.Animal> pickAnimalList(String barnName) {
    if (barnName.contains('Sterling Creek')) {
      return animalClass.sterlingCreekAnimals
          .map<animalClass.Animal>(animalClass.Animal.fromJson)
          .toList();
    } else {
      return animalClass.whippleCreekAnimals
          .map<animalClass.Animal>(animalClass.Animal.fromJson)
          .toList();
    }
  }

  Widget buildAnimals(List<animalClass.Animal> animals) => ListView.builder(
      itemCount: animals.length,
      itemBuilder: (context, index) {
        final animal = animals[index];

        return Card(
            child: ListTile(
          title: Text(animal.Name),
          subtitle: Text(animal.Owner),
          onTap: () {
            Navigator.of(context).push(MaterialPageRoute(
                builder: (context) =>
                    animalDetails.AnimalDetailPage(animal: animal)));
          },
        ));
      });

  @override
  Widget build(BuildContext ctx) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.lightBlue.shade900,
          title: const Text("Easy Barn"),
        ),
        body: Center(child: buildAnimals(pickAnimalList(widget.name))));
  }
}
