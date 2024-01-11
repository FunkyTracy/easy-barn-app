import 'package:flutter/material.dart';
import 'animal_class.dart' as animalClass;

class AnimalList extends StatefulWidget {
  const AnimalList({super.key});

  @override
  State<AnimalList> createState() => _AnimalList();
}

class _AnimalList extends State<AnimalList> {
  List<animalClass.Animal> animals =
      animalClass.SterlingCreekAnimals.map<animalClass.Animal>(
              animalClass.Animal.fromJson)
          .toList();

  Widget buildAnimals(List<animalClass.Animal> animals) => ListView.builder(
      itemCount: animals.length,
      itemBuilder: (context, index) {
        final animal = animals[index];

        return Card(
            child: ListTile(
          title: Text(animal.Name),
          subtitle: Text(animal.Owner),
        ));
      });

  @override
  Widget build(BuildContext ctx) {
    return Center(child: buildAnimals(animals));
  }
}
