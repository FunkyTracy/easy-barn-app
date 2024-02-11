import 'package:easy_barn/barn_details_page.dart';
import 'package:easy_barn/create_animal_form.dart';
import 'package:easy_barn/create_barn_form.dart';
import 'package:easy_barn/create_person_form.dart';
import 'package:easy_barn/person_list.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
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
          title: Text(animal.name),
          subtitle: Text(main.MyApp.people
              .firstWhere((person) => person.id == animal.ownerid)
              .name),
          onTap: () async {
            main.MyApp.selectedAnimal = animal;
            await Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => const AnimalDetailPage()));
            setState(() {});
          },
        ));
      });

  @override
  Widget build(BuildContext ctx) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Color.fromARGB(255, 51, 91, 122),
          title: Text(
            "Easy Barn",
            style: GoogleFonts.bitter(
                textStyle: const TextStyle(
                    color: Color.fromARGB(255, 244, 221, 177),
                    fontSize: 28,
                    fontWeight: FontWeight.w600)),
          ),
        ),
        endDrawer: NavigationDrawer(
          children: [
            SizedBox(
                height: 80,
                child: DrawerHeader(
                    decoration:
                        BoxDecoration(color: Color.fromARGB(255, 51, 91, 122)),
                    child: Center(
                        child: Text(
                      'Menu',
                      style: GoogleFonts.bitter(
                          textStyle: const TextStyle(
                              color: Color.fromARGB(255, 244, 221, 177),
                              fontSize: 24,
                              fontWeight: FontWeight.w600)),
                    )))),
            ListTile(
              title: const Text("Add New"),
              onTap: () {
                showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                          title: const Text('Add New'),
                          content: SizedBox(
                              height: 200,
                              child: Column(children: [
                                TextButton(
                                    onPressed: () async {
                                      await Navigator.of(ctx).push(
                                          MaterialPageRoute(
                                              builder: (ctx) =>
                                                  const CreatePersonForm()));
                                      setState(() {});
                                    },
                                    child: const Text('Add Person')),
                                TextButton(
                                    onPressed: () async {
                                      await Navigator.of(ctx).push(
                                          MaterialPageRoute(
                                              builder: (ctx) =>
                                                  const CreateBarnForm()));
                                      setState(() {});
                                    },
                                    child: const Text('Add Barn')),
                                TextButton(
                                    onPressed: () async {
                                      await Navigator.of(ctx).push(
                                          MaterialPageRoute(
                                              builder: (ctx) =>
                                                  const CreateAnimalForm()));
                                      setState(() {});
                                    },
                                    child: const Text('Add Animal'))
                              ])));
                    });
              },
            ),
            Divider(
              height: 1,
              color: Colors.blueGrey.shade800,
              thickness: 1,
            ),
            ListTile(
              title: const Text("Barn Information"),
              onTap: () async {
                await Navigator.of(ctx).push(MaterialPageRoute(
                    builder: (ctx) => const BarnDetailPage()));
                setState(() {});
              },
            ),
            Divider(
              height: 1,
              color: Colors.blueGrey.shade800,
              thickness: 1,
            ),
            ListTile(
              title: const Text("Barn Members"),
              onTap: () async {
                await Navigator.of(ctx).push(
                    MaterialPageRoute(builder: (ctx) => const PeopleList()));
                setState(() {});
              },
            ),
            Divider(
              height: 1,
              color: Colors.blueGrey.shade800,
              thickness: 1,
            ),
          ],
        ),
        body: Container(
            decoration: const BoxDecoration(
                image: DecorationImage(
                    image: AssetImage(
                        'assets/images/pexels-ahmet-çığşar-17406674.jpg'),
                    fit: BoxFit.cover,
                    opacity: 0.5)),
            child: buildAnimals()));
  }
}
