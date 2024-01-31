import 'package:easy_barn/animal_class.dart';
import 'package:easy_barn/person_class.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import './animal_list_page.dart' as animalList;
import 'barn_class.dart' as barnClass;
import 'main.dart' as main;

class BarnList extends StatefulWidget {
  const BarnList({super.key});

  @override
  State<BarnList> createState() => _BarnList();
}

class _BarnList extends State<BarnList> {
  void pickAnimalList(String barnName) {
    if (barnName.contains('Sterling Creek')) {
      main.MyApp.animals =
          sterlingCreekAnimals.map<Animal>(Animal.fromJson).toList();
    } else {
      main.MyApp.animals =
          whippleCreekAnimals.map<Animal>(Animal.fromJson).toList();
    }
  }

  void pickPeopleList() {
    if (main.MyApp.selectedBarn.Name.contains('Sterling Creek')) {
      main.MyApp.people = sterlingPeople.map<Person>(Person.fromJson).toList();
    } else {
      main.MyApp.people = whipplePeople.map<Person>(Person.fromJson).toList();
    }
  }

  Widget buildBarns(List<barnClass.Barn> barns) => ListView.builder(
      itemCount: barns.length,
      itemBuilder: (context, index) {
        final barn = barns[index];

        return Card(
          child: ListTile(
            title: Text(barn.Name),
            subtitle: Text(barn.Address),
            onTap: () {
              main.MyApp.selectedBarn = barn;
              pickAnimalList(barn.Name);
              pickPeopleList();
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (ctx) => animalList.AnimalList(name: barn.Name)));
            },
          ),
        );
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
        body: Container(
            decoration: const BoxDecoration(
                image: DecorationImage(
                    image: AssetImage(
                        'assets/images/pexels-brandon-randolph-2042161.jpg'),
                    fit: BoxFit.cover,
                    opacity: 0.5)),
            child: buildBarns(main.MyApp.barnList)));
  }
}
