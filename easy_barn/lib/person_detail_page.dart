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
          backgroundColor: Color.fromARGB(255, 51, 91, 122),
          title: Text(
            "Easy Barn",
            style: GoogleFonts.bitter(
                textStyle: const TextStyle(
                    color: Color.fromARGB(255, 244, 221, 177),
                    fontSize: 28,
                    fontWeight: FontWeight.w600)),
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
                title: Text(MyApp.selectedPerson.Name),
                subtitle: const Text("Name"),
              )),
              Card(
                  child: ListTile(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10)),
                title: Text(MyApp.selectedPerson.PhoneNumber),
                subtitle: const Text("Phone Number"),
              )),
              Card(
                  child: ListTile(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10)),
                title: Text(MyApp.selectedPerson.EmergencyPerson),
                subtitle: const Text("Emergency Contact Name"),
              )),
              Card(
                  child: ListTile(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10)),
                title: Text(MyApp.selectedPerson.EmergencyNumber),
                subtitle: const Text("Emergency Contact Phone Number"),
              )),
            ])));
  }
}
