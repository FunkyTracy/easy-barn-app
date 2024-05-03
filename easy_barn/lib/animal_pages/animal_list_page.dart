// ignore_for_file: use_build_context_synchronously

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:easy_barn/barn_pages/barn_class.dart';
import 'package:easy_barn/barn_pages/barn_details_page.dart';
import 'package:easy_barn/animal_pages/create_animal_form.dart';
import 'package:easy_barn/barn_pages/create_barn_form.dart';
import 'package:easy_barn/login/log_in_page.dart';
import 'package:easy_barn/person_pages/person_list.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'animal_class.dart';
import 'animal_detail_page.dart';
import '../main.dart' as main;

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
          leading: Container(
              decoration: const BoxDecoration(shape: BoxShape.circle),
              child: CircleAvatar(
                  child: FutureBuilder(
                future: getAnimalImage(animal.photoLocation),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    // While waiting for the image, you can show a placeholder
                    return const CircleAvatar(
                      backgroundColor: Colors.white,
                    );
                  } else if (snapshot.hasError) {
                    // Handle error if any
                    return const Icon(Icons.error);
                  } else {
                    // Once the image is loaded, display it
                    return CircleAvatar(backgroundImage: snapshot.data!.image);
                  }
                },
              ))),
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
          onLongPress: () async {
            if (main.MyApp.currentUser.id == main.MyApp.selectedBarn.ownerid) {
              showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      title: const Text('Delete Animal'),
                      content: const Text(
                          'You are about to delete the selected animal.\nIs this really what you want?'),
                      actions: [
                        TextButton(
                            onPressed: () async {
                              await deleteAnimal(animal);
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
                      title: Text('Delete Animal'),
                      content: Text(
                          "If you wish for this animal to be removed from the barn, please contact the barn owner"),
                    );
                  });
            }
          },
        ));
      });

  @override
  Widget build(BuildContext ctx) {
    return Scaffold(
        appBar: AppBar(
          title: const Text(
            "Easy Barn",
          ),
        ),
        endDrawer: NavigationDrawer(
          children: [
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
            ListTile(
              title: const Text("Logout"),
              onTap: () async {
                await FirebaseAuth.instance.signOut();

                main.MyApp.animals.isNotEmpty ? main.MyApp.animals.clear() : {};
                main.MyApp.barnList.isNotEmpty
                    ? main.MyApp.barnList.clear()
                    : {};
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

  Future<void> deleteAnimal(Animal animal) async {
    DocumentReference docRef =
        FirebaseFirestore.instance.collection('animals').doc(animal.id);

    await docRef.delete();

    int index =
        main.MyApp.animals.indexWhere((element) => element.id == animal.id);
    main.MyApp.animals.removeAt(index);
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

    FirebaseFirestore.instance
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

  Future<Image> getAnimalImage(String imageUrl) async {
    Reference imageRef = main.MyApp.firebaseStorage.ref().child(imageUrl);

    String url = await imageRef.getDownloadURL();

    return Image.network(url);
  }
}
