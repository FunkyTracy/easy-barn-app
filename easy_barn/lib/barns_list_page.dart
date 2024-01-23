import 'package:flutter/material.dart';
import './animal_list_page.dart' as animalList;
import 'barn_class.dart' as barnClass;
import 'main.dart' as main;

class BarnList extends StatefulWidget {
  const BarnList({super.key});

  @override
  State<BarnList> createState() => _BarnList();
}

class _BarnList extends State<BarnList> {
  List<barnClass.Barn> barns =
      barnClass.barns.map<barnClass.Barn>(barnClass.Barn.fromJson).toList();

  Widget buildBarns(List<barnClass.Barn> barns) => ListView.builder(
      itemCount: barns.length,
      itemBuilder: (context, index) {
        final barn = barns[index];

        return Card(
          child: ListTile(
            title: Text(barn.Name),
            subtitle: Text(barn.Address),
            onTap: () {
              main.MyApp.selectedBarn = barn;
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (ctx) => animalList.AnimalList(name: barn.Name)));
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
        body: Center(child: buildBarns(barns)));
  }
}
