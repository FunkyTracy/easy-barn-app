import 'package:easy_barn/animal_class.dart';
import 'package:easy_barn/barn_class.dart';
import 'package:easy_barn/login/log_in_page.dart';
import 'package:easy_barn/person_class.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import './barns_list_page.dart' as BarnListPage;
import 'firebase_options.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  static Person currentUser = Person(
      id: "",
      name: "",
      phoneNumber: "",
      emergencyPerson: "",
      emergencyNumber: "",
      uid: "");

  //hardcoded barns in barn_class
  static List<Barn> barnList = List<Barn>.empty(growable: true);
  static Barn selectedBarn =
      Barn(id: "", address: "", name: "", ownerid: "", phoneNumber: "");

  static List<Animal> animals = List<Animal>.empty(growable: true);
  static Animal selectedAnimal = Animal(
      id: "",
      description: "",
      stall: "",
      feedingInstructions: "",
      medications: "",
      vet: "",
      farrier: "",
      name: "",
      ownerid: "");

  static List<Person> people = List<Person>.empty(growable: true);
  static Person selectedPerson = Person(
      id: "",
      name: "",
      phoneNumber: "",
      emergencyPerson: "",
      emergencyNumber: "",
      uid: "");

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
      return ownerSnapshot.id;
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
          Barn(id: "", address: "", name: "", ownerid: "", phoneNumber: "");

      barn.id = barnDoc.id;

      Map<String, dynamic> item = barnDoc.data() as Map<String, dynamic>;
      barn.name = item['name'] ?? '';
      barn.address = item['address'] ?? '';
      barn.phoneNumber = item['number'] ?? '';
      barn.ownerid = await getBarnOwner(item['owner']);

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
        home: const LoginPage());
  }

  Future<void> linkPersonToBarn(String barnid) async {
    DocumentReference barnRef =
        FirebaseFirestore.instance.collection('barns').doc(barnid);
    DocumentReference personRef =
        FirebaseFirestore.instance.collection('people').doc();

    FirebaseFirestore.instance
        .collection('barn_to_person')
        .add({'barnid': barnRef, 'personid': personRef});
  }
}
