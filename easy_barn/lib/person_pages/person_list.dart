// ignore_for_file: use_build_context_synchronously

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:easy_barn/person_pages/person_class.dart';
import 'package:easy_barn/person_pages/person_detail_page.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../main.dart' as main;

class PeopleList extends StatefulWidget {
  const PeopleList({super.key});

  @override
  State<PeopleList> createState() => _PeopleList();
}

class _PeopleList extends State<PeopleList> {
  Widget buildPeopleList() => ListView.builder(
      itemCount: main.MyApp.people.length,
      itemBuilder: (ctx, index) {
        final person = main.MyApp.people[index];

        return Card(
          child: ListTile(
            title: Text(person.name),
            subtitle: Text(person.phoneNumber),
            onTap: () async {
              main.MyApp.selectedPerson = person;
              await Navigator.of(ctx).push(MaterialPageRoute(
                  builder: (ctx) => const PersonDetailPage()));
              setState(() {});
            },
            onLongPress: () async {
              if (main.MyApp.currentUser.id == person.id) {
                showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return const AlertDialog(
                        title: Text('Delete Person'),
                        content:
                            Text("You can't remove yourself from the barn"),
                      );
                    });
              } else if (main.MyApp.currentUser.id ==
                  main.MyApp.selectedBarn.ownerid) {
                showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: const Text('Delete Person'),
                        content: const Text(
                            'You are about to delete the selected Perosn which will delete all animals '
                            'they own within the barn and remove them from the boarders list.\n'
                            'This will not delete their account.\n'
                            'Is this really what you want?'),
                        actions: [
                          TextButton(
                              onPressed: () async {
                                await deletePerson(person);
                                Navigator.pop(context);
                                setState(() {});
                              },
                              child: const Text('Delete')),
                          TextButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              child: const Text('Cancel'))
                        ],
                      );
                    });
              } else {
                showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return const AlertDialog(
                        title: Text('Delete Person'),
                        content: Text(
                            "If you wish for this person to be removed from the barn, please contact the barn owner"),
                      );
                    });
              }
            },
          ),
        );
      });

  @override
  Widget build(BuildContext ctx) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: const Color.fromARGB(255, 51, 91, 122),
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
                        'assets/images/pexels-turuncu-sakal-19228336.jpg'),
                    fit: BoxFit.cover,
                    opacity: 0.5)),
            child: buildPeopleList()));
  }

  Future<void> deletePerson(Person person) async {
    QuerySnapshot animalSnapshot = await FirebaseFirestore.instance
        .collection('animals')
        .where('barn',
            isEqualTo: FirebaseFirestore.instance
                .doc('barns/${main.MyApp.selectedBarn.id}'))
        .where('owner',
            isEqualTo: FirebaseFirestore.instance.doc('people/${person.id}'))
        .get();

    for (QueryDocumentSnapshot animalDoc in animalSnapshot.docs) {
      await animalDoc.reference.delete();
    }

    QuerySnapshot linkSnapshot = await FirebaseFirestore.instance
        .collection('barn_to_person')
        .where('barnid',
            isEqualTo: FirebaseFirestore.instance
                .doc('barns/${main.MyApp.selectedBarn.id}'))
        .where('personid',
            isEqualTo: FirebaseFirestore.instance.doc('people/${person.id}'))
        .get();

    for (QueryDocumentSnapshot linkDoc in linkSnapshot.docs) {
      await linkDoc.reference.delete();

      int index = main.MyApp.animals
          .indexWhere((element) => element.ownerid == person.id);
      if (index > -1) {
        main.MyApp.animals.removeAt(index);
      }
    }

    int index =
        main.MyApp.people.indexWhere((element) => element.id == person.id);
    main.MyApp.people.removeAt(index);
  }
}
