import 'package:easy_barn/animal_class.dart';
import 'package:easy_barn/barn_class.dart';
import 'package:easy_barn/person_class.dart';
import 'package:flutter/material.dart';
import './barns_list_page.dart' as BarnListPage;

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  //hardcoded barns in barn_class
  static List<Barn> barnList = barns.map<Barn>(Barn.fromJson).toList();
  static Barn selectedBarn =
      const Barn(Address: "", Name: "", Owner: "", PhoneNumber: "");

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
  static Person selectedPerson = const Person(
      Name: "", PhoneNumber: "", EmergencyPerson: "", EmergencyNumber: "");

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'EasyBarn',
      theme: ThemeData(
        colorScheme:
            ColorScheme.fromSeed(seedColor: const Color.fromARGB(255, 226, 157, 30)),
        useMaterial3: true,
      ),
      home: const BarnListPage.BarnList(),
    );
  }
}
