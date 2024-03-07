import 'package:easy_barn/edit_person_form.dart';
import 'package:easy_barn/main.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class PersonDetailPage extends StatefulWidget {
  const PersonDetailPage({super.key});

  @override
  State<PersonDetailPage> createState() => _PersonDetailPage();
}

class _PersonDetailPage extends State<PersonDetailPage> {
  @override
  Widget build(BuildContext ctx) {
    return Scaffold(
        backgroundColor: Color.fromARGB(255, 244, 221, 177),
        appBar: AppBar(
          title: const Text(
            "Easy Barn",
          ),
          actions: <Widget>[
            Padding(
              padding: const EdgeInsets.only(right: 10),
              child: GestureDetector(
                onTap: () async {
                  await Navigator.of(ctx).push(MaterialPageRoute(
                      builder: (ctx) => const EditPersonForm()));
                  setState(() {});
                },
                child: const Icon(
                  Icons.edit,
                  color: Color.fromARGB(255, 244, 221, 177),
                ),
              ),
            )
          ],
        ),
        body: SingleChildScrollView(
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
              Card(
                  child: ListTile(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10)),
                title: Text(MyApp.selectedPerson.name),
                subtitle: const Text("Name"),
              )),
              Card(
                  child: ListTile(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10)),
                title: Text(MyApp.selectedPerson.phoneNumber),
                subtitle: const Text("Phone Number"),
              )),
              Card(
                  child: ListTile(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10)),
                title: Text(MyApp.selectedPerson.emergencyPerson),
                subtitle: const Text("Emergency Contact Name"),
              )),
              Card(
                  child: ListTile(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10)),
                title: Text(MyApp.selectedPerson.emergencyNumber),
                subtitle: const Text("Emergency Contact Phone Number"),
              )),
            ])));
  }
}
