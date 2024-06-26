// ignore_for_file: use_build_context_synchronously, library_prefixes

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:easy_barn/animal_pages/animal_class.dart';
import 'package:easy_barn/barn_pages/barn_class.dart';
import 'package:easy_barn/animal_pages/create_animal_form.dart';
import 'package:easy_barn/barn_pages/create_barn_form.dart';
import 'package:easy_barn/login/log_in_page.dart';
import 'package:easy_barn/person_pages/person_class.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../animal_pages/animal_list_page.dart' as animalList;
import 'barn_class.dart' as barnClass;
import '../main.dart' as main;

class BarnList extends StatefulWidget {
  const BarnList({super.key});

  @override
  State<BarnList> createState() => _BarnList();
}

class _BarnList extends State<BarnList> {
  Widget buildBarns(List<barnClass.Barn> barns) => ListView.builder(
      itemCount: barns.length,
      itemBuilder: (context, index) {
        final barn = barns[index];

        return Card(
          child: ListTile(
            title: Text(barn.name),
            subtitle: Text(barn.address),
            onTap: () async {
              main.MyApp.selectedBarn = barn;
              await pickPeopleList();
              await pickAnimalList();
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (ctx) => animalList.AnimalList(name: barn.name)));
            },
            onLongPress: () async {
              if (main.MyApp.currentUser.id == barn.ownerid) {
                showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: const Text('Delete Barn'),
                        content: const Text(
                            'You are about to delete the selected barn which will delete all animals'
                            ' within it and remove the barn from any boarders\' accounts.\n'
                            'Is this really what you want?'),
                        actions: [
                          TextButton(
                              onPressed: () async {
                                await deleteBarn(barn);
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
                        title: Text('Delete Barn'),
                        content: Text(
                            "If you wish to be removed from the barn, please contact the barn owner"),
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
          title: const Text(
            "Easy Barn",
          ),
        ),
        endDrawer: NavigationDrawer(children: [
          SizedBox(
              height: 80,
              child: DrawerHeader(
                  decoration: const BoxDecoration(
                      color: Color.fromARGB(255, 51, 91, 122)),
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
            title: const Text("Add New Barn or Animal"),
            onTap: () {
              showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                        title: const Text('Add New'),
                        content: SizedBox(
                            child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                              TextButton(
                                  onPressed: () async {
                                    await Navigator.of(ctx).push(
                                        MaterialPageRoute(
                                            builder: (ctx) =>
                                                const CreateBarnForm()));
                                    setState(() {});
                                    Navigator.of(ctx).pop();
                                  },
                                  child: const Text('Add Barn')),
                              TextButton(
                                  onPressed: () async {
                                    await Navigator.of(ctx).push(
                                        MaterialPageRoute(
                                            builder: (ctx) =>
                                                const CreateAnimalForm()));
                                    setState(() {});
                                    Navigator.of(ctx).pop();
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
              title: const Text("Join Existing Barn"),
              onTap: () {
                String barnToJoin = "";

                showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: const Text('Join Barn'),
                        content: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            const Text(
                                "Enter the invite code for the barn\n you wish to join"),
                            TextFormField(
                              onChanged: (value) {
                                barnToJoin = value.trim();
                              },
                            ),
                            Row(
                              children: <Widget>[
                                Expanded(
                                  child: ElevatedButton(
                                    onPressed: () async {
                                      if (main.MyApp.barnList.isEmpty ||
                                          main.MyApp.barnList
                                                  .firstWhere(
                                                      (element) =>
                                                          element.id ==
                                                          barnToJoin,
                                                      orElse: () => Barn(
                                                          id: "na",
                                                          address: "",
                                                          name: "",
                                                          ownerid: "",
                                                          phoneNumber: ""))
                                                  .id ==
                                              "na") {
                                        await linkPersonToBarn(barnToJoin);
                                      }
                                      setState(() {});
                                      Navigator.of(ctx).pop();
                                    },
                                    child: const Text(
                                      'Join Barn',
                                      style: TextStyle(
                                          color: Color.fromARGB(
                                              255, 37, 109, 168)),
                                    ),
                                  ),
                                ),
                                Expanded(
                                  child: ElevatedButton(
                                    onPressed: () {
                                      Navigator.of(ctx).pop();
                                    },
                                    child: const Text(
                                      'Cancel',
                                      style: TextStyle(
                                          color: Color.fromARGB(
                                              255, 37, 109, 168)),
                                    ),
                                  ),
                                ),
                              ],
                            )
                          ],
                        ),
                      );
                    });
                setState(() {});
              }),
          Divider(
            height: 1,
            color: Colors.blueGrey.shade800,
            thickness: 1,
          ),
          ListTile(
            title: const Text("Logout"),
            onTap: () async {
              await FirebaseAuth.instance.signOut();

              main.MyApp.animals.isNotEmpty ? main.MyApp.animals.clear() : {};
              main.MyApp.barnList.isNotEmpty ? main.MyApp.barnList.clear() : {};
              main.MyApp.people.isNotEmpty ? main.MyApp.people.clear() : {};

              // return to log in page with clear navigation routes
              Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (context) => const LoginPage()),
                  (route) => false);
            },
          ),
          Divider(
            height: 1,
            color: Colors.blueGrey.shade800,
            thickness: 1,
          )
        ]),
        body: Container(
            decoration: const BoxDecoration(
                image: DecorationImage(
                    image: AssetImage(
                        'assets/images/pexels-brandon-randolph-2042161.jpg'),
                    fit: BoxFit.cover,
                    opacity: 0.5)),
            child: buildBarns(main.MyApp.barnList)));
  }

  Future<String> getAnimalOwner(DocumentReference ownerRef) async {
    DocumentSnapshot ownerSnapshot = await ownerRef.get();
    if (ownerSnapshot.exists) {
      return ownerSnapshot.id;
    } else {
      return '';
    }
  }

  Future<void> pickAnimalList() async {
    QuerySnapshot qs = await FirebaseFirestore.instance
        .collection('animals')
        .where('barn',
            isEqualTo: FirebaseFirestore.instance
                .doc('barns/${main.MyApp.selectedBarn.id}'))
        .get();

    List<Animal> animalsTemp = [];
    for (QueryDocumentSnapshot doc in qs.docs) {
      Map<String, dynamic> item = doc.data() as Map<String, dynamic>;
      Animal temp = Animal(
          id: doc.id,
          description: item['description'] ?? "",
          stall: item['stall'] ?? "",
          feedingInstructions: item['feeding'] ?? "",
          medications: item['medications'] ?? "",
          vet: item['vet'] ?? "",
          farrier: item['farrier'] ?? "",
          name: item['name'] ?? "",
          ownerid: await getAnimalOwner(item['owner']),
          photoLocation: item['photo'] ??
              "jumping-horse-silhouette-facing-left-side-view.png");

      animalsTemp.add(temp);
    }

    main.MyApp.animals = animalsTemp;
  }

  Future<Person> getPersonFromId(DocumentReference personRef) async {
    DocumentSnapshot personSnapshot = await personRef.get();

    if (personSnapshot.exists) {
      Map<String, dynamic> person =
          personSnapshot.data() as Map<String, dynamic>;

      Person personToReturn = Person(
          id: personSnapshot.id,
          name: person['name'] ?? '',
          phoneNumber: person['number'] ?? '',
          emergencyPerson: person['emergencyPerson'] ?? '',
          emergencyNumber: person['emergencyNumber'] ?? '',
          uid: person['uid'] ?? '');
      return personToReturn;
    } else {
      return Person(
          id: "",
          name: "",
          phoneNumber: "",
          emergencyPerson: "",
          emergencyNumber: "",
          uid: "");
    }
  }

  Future<void> pickPeopleList() async {
    QuerySnapshot qs = await FirebaseFirestore.instance
        .collection('barn_to_person')
        .where('barnid',
            isEqualTo: FirebaseFirestore.instance
                .doc('barns/${main.MyApp.selectedBarn.id}'))
        .get();

    List<Person> peopleTemp = [];
    for (QueryDocumentSnapshot doc in qs.docs) {
      Map<String, dynamic> item = doc.data() as Map<String, dynamic>;
      Person person = await getPersonFromId(item['personid']);

      peopleTemp.add(person);
    }

    main.MyApp.people = peopleTemp;
  }

  Future<void> deleteBarn(Barn barn) async {
    DocumentReference barnDoc =
        FirebaseFirestore.instance.collection('barns').doc(barn.id);

    QuerySnapshot animalSnapshot = await FirebaseFirestore.instance
        .collection('animals')
        .where('barn',
            isEqualTo: FirebaseFirestore.instance.doc('barns/${barn.id}'))
        .get();

    for (QueryDocumentSnapshot animalDoc in animalSnapshot.docs) {
      await animalDoc.reference.delete();
    }

    QuerySnapshot linkSnapshot = await FirebaseFirestore.instance
        .collection('barn_to_person')
        .where('barnid',
            isEqualTo: FirebaseFirestore.instance.doc('barns/${barn.id}'))
        .get();

    for (QueryDocumentSnapshot linkDoc in linkSnapshot.docs) {
      await linkDoc.reference.delete();
    }

    await barnDoc.delete();

    int index =
        main.MyApp.barnList.indexWhere((element) => element.id == barn.id);
    main.MyApp.barnList.removeAt(index);
  }

  Future<void> linkPersonToBarn(String barnid) async {
    DocumentReference barnRef =
        FirebaseFirestore.instance.collection('barns').doc(barnid);
    DocumentReference personRef = FirebaseFirestore.instance
        .collection('people')
        .doc(main.MyApp.currentUser.id);

    DocumentSnapshot barnInfo = await barnRef.get();
    Map<String, dynamic> barn = barnInfo.data() as Map<String, dynamic>;
    String ownerid = await getBarnOwner(barn['owner']);
    main.MyApp.barnList.add(Barn(
      id: barnRef.id,
      address: barn['address'] ?? '',
      name: barn['name'] ?? '',
      phoneNumber: barn['number'] ?? '',
      ownerid: ownerid,
    ));

    await FirebaseFirestore.instance
        .collection('barn_to_person')
        .add({'barnid': barnRef, 'personid': personRef});
  }

  Future<String> getBarnOwner(DocumentReference ownerRef) async {
    DocumentSnapshot ownerSnapshot = await ownerRef.get();
    if (ownerSnapshot.exists) {
      return ownerSnapshot.id;
    } else {
      return '';
    }
  }
}
