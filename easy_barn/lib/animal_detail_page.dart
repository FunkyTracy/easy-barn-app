import 'package:flutter/material.dart';
import 'animal_class.dart' as animalClass;

class AnimalDetailPage extends StatefulWidget {
  final animalClass.Animal animal;

  const AnimalDetailPage({super.key, required this.animal});

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
        ),
        body: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 4, vertical: 4),
                  child: ListTile(
                    tileColor: const Color.fromARGB(255, 233, 208, 135),
                    title: Text(widget.animal.Name),
                    subtitle: const Text("Animal Name"),
                  )),
              Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 4, vertical: 4),
                  child: ListTile(
                    tileColor: const Color.fromARGB(255, 233, 208, 135),
                    title: Text(widget.animal.Owner),
                    subtitle: const Text("Owner Name"),
                  )),
              Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 4, vertical: 4),
                  child: ListTile(
                    tileColor: const Color.fromARGB(255, 233, 208, 135),
                    title: Text(widget.animal.Description),
                    subtitle: const Text("Description"),
                  )),
              Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 4, vertical: 4),
                  child: ListTile(
                    tileColor: const Color.fromARGB(255, 233, 208, 135),
                    title: Text(widget.animal.Stall),
                    subtitle: const Text("Stall Location"),
                  )),
              Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 4, vertical: 4),
                  child: ListTile(
                    tileColor: const Color.fromARGB(255, 233, 208, 135),
                    title: Text(widget.animal.FeedingInstructions),
                    subtitle: const Text("Feeding Instructions"),
                  )),
              Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 4, vertical: 4),
                  child: ListTile(
                    tileColor: const Color.fromARGB(255, 233, 208, 135),
                    title: Text(widget.animal.Medications),
                    subtitle: const Text("Medications"),
                  )),
              Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 4, vertical: 4),
                  child: ListTile(
                    tileColor: const Color.fromARGB(255, 233, 208, 135),
                    title: Text(widget.animal.Vet),
                    subtitle: const Text("Veterinarian"),
                  )),
              Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 4, vertical: 4),
                  child: ListTile(
                    tileColor: const Color.fromARGB(255, 233, 208, 135),
                    title: Text(widget.animal.Farrier),
                    subtitle: const Text("Farrier"),
                  )),
            ]));
  }
}
