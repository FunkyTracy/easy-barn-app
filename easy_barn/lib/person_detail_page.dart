import 'package:easy_barn/main.dart';

import 'person_class.dart';
import 'package:flutter/material.dart';

class PersonDetailPage extends StatefulWidget {
  const PersonDetailPage({super.key});

  @override
  State<PersonDetailPage> createState() => _PersonDetailPage();
}

class _PersonDetailPage extends State<PersonDetailPage> {
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
                    title: Text(MyApp.selectedPerson.Name),
                    subtitle: const Text("Name"),
                  )),
              Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 4, vertical: 4),
                  child: ListTile(
                    tileColor: const Color.fromARGB(255, 233, 208, 135),
                    title: Text(MyApp.selectedPerson.PhoneNumber),
                    subtitle: const Text("Phone Number"),
                  )),
              Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 4, vertical: 4),
                  child: ListTile(
                    tileColor: const Color.fromARGB(255, 233, 208, 135),
                    title: Text(MyApp.selectedPerson.EmergencyPerson),
                    subtitle: const Text("Emergency Contact Name"),
                  )),
              Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 4, vertical: 4),
                  child: ListTile(
                    tileColor: const Color.fromARGB(255, 233, 208, 135),
                    title: Text(MyApp.selectedPerson.EmergencyNumber),
                    subtitle: const Text("Emergency Contact Phone Number"),
                  )),
            ]));
  }
}
