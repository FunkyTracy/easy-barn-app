import 'package:easy_barn/edit_barn_page.dart';
import 'package:easy_barn/main.dart';
import 'package:flutter/material.dart';

class BarnDetailPage extends StatefulWidget {
  const BarnDetailPage({super.key});

  @override
  State<BarnDetailPage> createState() => _BarnDetailPage();
}

class _BarnDetailPage extends State<BarnDetailPage> {
  @override
  Widget build(BuildContext ctx) {
    return Scaffold(
        backgroundColor: const Color.fromARGB(255, 17, 59, 94),
        appBar: AppBar(
          backgroundColor: Colors.lightBlue.shade900,
          title: const Text("Easy Barn"),
          actions: <Widget>[
            Padding(
              padding: const EdgeInsets.only(right: 10),
              child: GestureDetector(
                onTap: () async {
                  await Navigator.of(ctx).push(MaterialPageRoute(
                      builder: (ctx) => const EditBarnForm()));
                  setState(() {});
                },
                child: const Icon(Icons.edit),
              ),
            )
          ],
        ),
        body: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 4, vertical: 4),
                  child: ListTile(
                    tileColor: const Color.fromARGB(255, 233, 208, 135),
                    title: Text(MyApp.selectedBarn.Name),
                    subtitle: const Text("Barn Name"),
                  )),
              Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 4, vertical: 4),
                  child: ListTile(
                    tileColor: const Color.fromARGB(255, 233, 208, 135),
                    title: Text(MyApp.selectedBarn.Owner),
                    subtitle: const Text("Barn Owner"),
                  )),
              Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 4, vertical: 4),
                  child: ListTile(
                    tileColor: const Color.fromARGB(255, 233, 208, 135),
                    title: Text(MyApp.selectedBarn.Address),
                    subtitle: const Text("Address"),
                  )),
              Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 4, vertical: 4),
                  child: ListTile(
                    tileColor: const Color.fromARGB(255, 233, 208, 135),
                    title: Text(MyApp.selectedBarn.PhoneNumber),
                    subtitle: const Text("Phone Number"),
                  )),
            ]));
  }
}
