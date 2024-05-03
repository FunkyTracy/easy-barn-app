import 'package:easy_barn/animal_pages/animal_class.dart';
import 'package:easy_barn/barn_pages/barn_class.dart';
import 'package:easy_barn/login/log_in_page.dart';
import 'package:easy_barn/person_pages/person_class.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'firebase_options.dart';
import 'package:firebase_storage/firebase_storage.dart';

// Default horse icon used within application <a href="https://www.flaticon.com/free-icons/horse" title="horse icons">Horse icons created by Freepik - Flaticon</a>

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  static FirebaseStorage firebaseStorage = FirebaseStorage.instance;

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
      ownerid: "",
      photoLocation: "");

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

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'EasyBarn',
        theme: ThemeData(
          appBarTheme: AppBarTheme(
              backgroundColor: const Color.fromARGB(255, 51, 91, 122),
              titleTextStyle: GoogleFonts.bitter(
                  textStyle: const TextStyle(
                      color: Color.fromARGB(255, 244, 221, 177),
                      fontSize: 28,
                      fontWeight: FontWeight.w600))),
          inputDecorationTheme: const InputDecorationTheme(
              border: OutlineInputBorder(
                  borderSide:
                      BorderSide(color: Color.fromARGB(255, 51, 91, 122)))),
          useMaterial3: true,
        ),
        home: const LoginPage());
  }
}
