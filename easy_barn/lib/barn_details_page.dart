import 'package:easy_barn/barn_class.dart';
import 'package:flutter/material.dart';

class BarnDetailPage extends StatefulWidget {
  final Barn barn;

  const BarnDetailPage({super.key, required this.barn});

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
        ),
        body: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 4, vertical: 4),
                  child: ListTile(
                    tileColor: const Color.fromARGB(255, 233, 208, 135),
                    title: Text(widget.barn.Name),
                    subtitle: const Text("Barn Name"),
                  )),
              Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 4, vertical: 4),
                  child: ListTile(
                    tileColor: const Color.fromARGB(255, 233, 208, 135),
                    title: Text(widget.barn.Owner),
                    subtitle: const Text("Barn Owner"),
                  )),
              Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 4, vertical: 4),
                  child: ListTile(
                    tileColor: const Color.fromARGB(255, 233, 208, 135),
                    title: Text(widget.barn.Address),
                    subtitle: const Text("Address"),
                  )),
              Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 4, vertical: 4),
                  child: ListTile(
                    tileColor: const Color.fromARGB(255, 233, 208, 135),
                    title: Text(widget.barn.PhoneNumber),
                    subtitle: const Text("Phone Number"),
                  )),
            ]));
  }
}
