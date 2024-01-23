import 'package:easy_barn/barn_details_page.dart';
import 'package:easy_barn/person_list.dart';
import 'package:flutter/material.dart';
import 'animal_class.dart';
import 'animal_detail_page.dart';
import 'main.dart' as main;

class AnimalList extends StatefulWidget {
  final String name;

  const AnimalList({super.key, required this.name});

  @override
  State<AnimalList> createState() => _AnimalList();
}

class _AnimalList extends State<AnimalList> {
  Widget buildAnimals() => ListView.builder(
      itemCount: main.MyApp.animals.length,
      itemBuilder: (context, index) {
        final Animal animal = main.MyApp.animals[index];

        return Card(
            child: ListTile(
          title: Text(animal.Name),
          subtitle: Text(animal.Owner),
          onTap: () {
            main.MyApp.selectedAnimal = animal;
            Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => const AnimalDetailPage()));
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
                    builder: (ctx) => const BarnDetailPage()));
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
                Navigator.of(ctx).push(
                    MaterialPageRoute(builder: (ctx) => const PeopleList()));
              },
            ),
            Divider(
              height: 1,
              color: Colors.blueGrey.shade800,
              thickness: 1,
            ),
          ],
        ),
        body: Center(child: buildAnimals()));
  }
}
