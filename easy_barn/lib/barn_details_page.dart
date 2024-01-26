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
        appBar: AppBar(
          backgroundColor: Color.fromARGB(255, 66, 151, 193),
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
        body: Container(
            decoration: const BoxDecoration(
                image: DecorationImage(
                    image:
                        AssetImage('assets/images/pexels-pixabay-235725.jpg'),
                    fit: BoxFit.cover,
                    opacity: 0.5)),
            child: ListView(children: [
              Card(
                  child: ListTile(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10)),
                title: Text(MyApp.selectedBarn.Name),
                subtitle: const Text("Barn Name"),
              )),
              Card(
                  child: ListTile(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10)),
                title: Text(MyApp.selectedBarn.Owner),
                subtitle: const Text("Barn Owner"),
              )),
              Card(
                  child: ListTile(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10)),
                title: Text(MyApp.selectedBarn.Address),
                subtitle: const Text("Address"),
              )),
              Card(
                  child: ListTile(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10)),
                title: Text(MyApp.selectedBarn.PhoneNumber),
                subtitle: const Text("Phone Number"),
              )),
            ])));
  }
}
