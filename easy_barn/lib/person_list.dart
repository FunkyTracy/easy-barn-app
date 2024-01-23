import 'package:easy_barn/person_class.dart';
import 'package:easy_barn/person_detail_page.dart';
import 'package:flutter/material.dart';
import 'main.dart' as main;

class PeopleList extends StatefulWidget {
  const PeopleList({super.key});

  @override
  State<PeopleList> createState() => _PeopleList();
}

class _PeopleList extends State<PeopleList> {
  List<Person> pickPeopleList() {
    if (main.MyApp.selectedBarn.Name.contains('Sterling Creek')) {
      return sterlingPeople.map<Person>(Person.fromJson).toList();
    } else {
      return whipplePeople.map<Person>(Person.fromJson).toList();
    }
  }

  Widget buildPeopleList(List<Person> people) => ListView.builder(
      itemCount: people.length,
      itemBuilder: (ctx, index) {
        final person = people[index];

        return Card(
          child: ListTile(
            title: Text(person.Name),
            subtitle: Text(person.PhoneNumber),
            onTap: () {
              Navigator.of(ctx).push(MaterialPageRoute(
                  builder: (ctx) => PersonDetailPage(person: person)));
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
        body: Center(child: buildPeopleList(pickPeopleList())));
  }
}
