import 'package:easy_barn/barn_details_page.dart';
import 'package:easy_barn/person_list.dart';
import 'package:flutter/material.dart';
import 'animal_class.dart' as animalClass;
import 'animal_detail_page.dart' as animalDetails;
import 'main.dart' as main;

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
        endDrawer: NavigationDrawer(
          selectedIndex: 3,
          children: [
            SizedBox(
                height: 100,
                child: DrawerHeader(
                    decoration: BoxDecoration(color: Colors.blueGrey.shade800),
                    child: const Text('Menu'))),
            ListTile(
              title: const Text("Barn Information"),
              onTap: () {
                Navigator.of(ctx).push(MaterialPageRoute(
                    builder: (ctx) =>
                        BarnDetailPage(barn: main.MyApp.selectedBarn)));
              },
            ),
            Divider(
              height: 1,
              color: Colors.blueGrey.shade800,
              thickness: 1,
            ),
            ListTile(
              title: const Text("Barn Members"),
              onTap: () {
                Navigator.of(ctx)
                    .push(MaterialPageRoute(builder: (ctx) => PeopleList()));
              },
            ),
            Divider(
              height: 1,
              color: Colors.blueGrey.shade800,
              thickness: 1,
            ),
          ],
        ),
        body: Center(child: buildAnimals(pickAnimalList(widget.name))));
  }
}
