import 'package:easy_barn/person_detail_page.dart';
import 'package:flutter/material.dart';
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
            title: Text(person.Name),
            subtitle: Text(person.PhoneNumber),
            onTap: () {
              main.MyApp.selectedPerson = person;
              Navigator.of(ctx).push(MaterialPageRoute(
                  builder: (ctx) => const PersonDetailPage()));
            },
          ),
        );
      });

  @override
  Widget build(BuildContext ctx) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.lightBlue.shade900,
          title: const Text("Easy Barn"),
        ),
        body: Center(child: buildPeopleList()));
  }
}
