import 'package:easy_barn/edit_animal_form.dart';
import 'package:flutter/material.dart';
import 'main.dart';

class AnimalDetailPage extends StatefulWidget {
  const AnimalDetailPage({super.key});

  @override
  State<AnimalDetailPage> createState() => _AnimalDetailPage();
}

class _AnimalDetailPage extends State<AnimalDetailPage> {
  @override
  Widget build(BuildContext ctx) {
    return Scaffold(
        backgroundColor: const Color.fromARGB(255, 17, 59, 94),
        appBar: AppBar(
          backgroundColor: Colors.lightBlue.shade900,
          title: const Text("Easy Barn"),
          actions: <Widget>[
            Padding(
              padding: const EdgeInsets.only(right: 10),
              child: GestureDetector(
                onTap: () async {
                  await Navigator.of(ctx).push(MaterialPageRoute(
                      builder: (ctx) => const EditAnimalForm()));
                  setState(() {});
                },
                child: const Icon(Icons.edit),
              ),
            )
          ],
        ),
        body: SingleChildScrollView(
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
              Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 4, vertical: 4),
                  child: ListTile(
                    tileColor: const Color.fromARGB(255, 233, 208, 135),
                    title: Text(MyApp.selectedAnimal.Name),
                    subtitle: const Text("Animal Name"),
                  )),
              Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 4, vertical: 4),
                  child: ListTile(
                    tileColor: const Color.fromARGB(255, 233, 208, 135),
                    title: Text(MyApp.selectedAnimal.Owner),
                    subtitle: const Text("Owner Name"),
                  )),
              Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 4, vertical: 4),
                  child: ListTile(
                    tileColor: const Color.fromARGB(255, 233, 208, 135),
                    title: Text(MyApp.selectedAnimal.Description),
                    subtitle: const Text("Description"),
                  )),
              Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 4, vertical: 4),
                  child: ListTile(
                    tileColor: const Color.fromARGB(255, 233, 208, 135),
                    title: Text(MyApp.selectedAnimal.Stall),
                    subtitle: const Text("Stall Location"),
                  )),
              Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 4, vertical: 4),
                  child: ListTile(
                    tileColor: const Color.fromARGB(255, 233, 208, 135),
                    title: Text(MyApp.selectedAnimal.FeedingInstructions),
                    subtitle: const Text("Feeding Instructions"),
                  )),
              Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 4, vertical: 4),
                  child: ListTile(
                    tileColor: const Color.fromARGB(255, 233, 208, 135),
                    title: Text(MyApp.selectedAnimal.Medications),
                    subtitle: const Text("Medications"),
                  )),
              Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 4, vertical: 4),
                  child: ListTile(
                    tileColor: const Color.fromARGB(255, 233, 208, 135),
                    title: Text(MyApp.selectedAnimal.Vet),
                    subtitle: const Text("Veterinarian"),
                  )),
              Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 4, vertical: 4),
                  child: ListTile(
                    tileColor: const Color.fromARGB(255, 233, 208, 135),
                    title: Text(MyApp.selectedAnimal.Farrier),
                    subtitle: const Text("Farrier"),
                  )),
            ])));
  }
}
