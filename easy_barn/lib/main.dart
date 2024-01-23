import 'package:easy_barn/barn_class.dart';
import 'package:flutter/material.dart';
import './barns_list_page.dart' as BarnList;

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  static Barn selectedBarn =
      Barn(Address: "", Name: "", Owner: "", PhoneNumber: "");

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'EasyBarn',
      theme: ThemeData(
        colorScheme:
            ColorScheme.fromSeed(seedColor: Color.fromARGB(255, 226, 157, 30)),
        useMaterial3: true,
      ),
      home: const BarnList.BarnList(),
    );
  }
}
