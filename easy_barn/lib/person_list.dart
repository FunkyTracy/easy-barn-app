import 'package:easy_barn/person_detail_page.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'main.dart' as main;

class PeopleList extends StatefulWidget {
  const PeopleList({super.key});

  @override
  State<PeopleList> createState() => _PeopleList();
}

class _PeopleList extends State<PeopleList> {
  Widget buildPeopleList() => ListView.builder(
      itemCount: main.MyApp.people.length,
      itemBuilder: (ctx, index) {
        final person = main.MyApp.people[index];

        return Card(
          child: ListTile(
            title: Text(person.name),
            subtitle: Text(person.phoneNumber),
            onTap: () async {
              main.MyApp.selectedPerson = person;
              await Navigator.of(ctx).push(MaterialPageRoute(
                  builder: (ctx) => const PersonDetailPage()));
              setState(() {});
            },
          ),
        );
      });

  @override
  Widget build(BuildContext ctx) {
    return Scaffold(
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
        ),
        body: Container(
            decoration: const BoxDecoration(
                image: DecorationImage(
                    image: AssetImage(
                        'assets/images/pexels-turuncu-sakal-19228336.jpg'),
                    fit: BoxFit.cover,
                    opacity: 0.5)),
            child: buildPeopleList()));
  }
}
