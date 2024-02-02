import 'package:easy_barn/animal_class.dart';
import 'package:easy_barn/barn_class.dart';
import 'package:easy_barn/person_class.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import './barns_list_page.dart' as BarnListPage;
import 'firebase_options.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  //hardcoded barns in barn_class
  static List<Barn> barnList = List<Barn>.empty();
  static Barn selectedBarn =
      Barn(id: "", address: "", name: "", owner: "", phoneNumber: "");

  static List<Animal> animals = List<Animal>.empty();
  static Animal selectedAnimal = Animal(
      Description: "",
      Stall: "",
      FeedingInstructions: "",
      Medications: "",
      Vet: "",
      Farrier: "",
      Name: "",
      Owner: "");

  static List<Person> people = List<Person>.empty();
  static Person selectedPerson = Person(
      id: "",
      name: "",
      phoneNumber: "",
      emergencyPerson: "",
      emergencyNumber: "");

  @override
  State<MyApp> createState() => _MyApp();
}

class _MyApp extends State<MyApp> {
  Future<void> initializeFirebase() async {
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
  }

  Future<String> getBarnOwner(DocumentReference ownerRef) async {
    DocumentSnapshot ownerSnapshot = await ownerRef.get();
    if (ownerSnapshot.exists) {
      Map<String, dynamic> owner = ownerSnapshot.data() as Map<String, dynamic>;
      return owner['name'];
    } else {
      return '';
    }
  }

  Future<List<Barn>> getBarnsFromDatabase() async {
    await initializeFirebase();
    List<Barn> barns = [];

    QuerySnapshot qs =
        await FirebaseFirestore.instance.collection('barns').get();

    for (QueryDocumentSnapshot barnDoc in qs.docs) {
      Barn barn =
          Barn(id: "", address: "", name: "", owner: "", phoneNumber: "");

      barn.id = barnDoc.id;

      Map<String, dynamic> item = barnDoc.data() as Map<String, dynamic>;
      barn.name = item['name'] ?? '';
      barn.address = item['address'] ?? '';
      barn.phoneNumber = item['number'] ?? '';
      barn.owner = await getBarnOwner(item['owner']);

      barns.add(barn);
    }

    MyApp.barnList = barns;

    return barns;
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'EasyBarn',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(
              seedColor: const Color.fromARGB(255, 226, 157, 30)),
          useMaterial3: true,
        ),
        home: FutureBuilder<List<Barn>>(
            future: getBarnsFromDatabase(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return CircularProgressIndicator();
              } else if (!(snapshot.data == null)) {
                MyApp.barnList = snapshot.data!;
                return const BarnListPage.BarnList();
              } else {
                return Text('Error: ${snapshot.error}');
              }
            }));
  }
}
