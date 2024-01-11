import 'package:flutter/material.dart';
import './animal_list_page.dart' as animalList;

class BarnList extends StatefulWidget {
  const BarnList({super.key});

  @override
  State<BarnList> createState() => _BarnList();
}

class _BarnList extends State<BarnList> {
  @override
  Widget build(BuildContext ctx) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.lightBlue.shade900,
          title: const Text("Easy Barn"),
        ),
        body: Center(
          child: ListView(children: <ListTile>[
            ListTile(
              title: Text('Sterling Creek Farm'),
              subtitle: Text('Brush Prairie, Wa'),
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (ctx) => animalList.AnimalList()));
              },
            ),
            ListTile(
              title: Text('Whipple Creek Boarding Facility'),
              subtitle: Text('Ridgefield, WA'),
            )
          ]),
        ));
  }
}
