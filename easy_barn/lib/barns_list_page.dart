import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:easy_barn/animal_class.dart';
import 'package:easy_barn/person_class.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import './animal_list_page.dart' as animalList;
import 'barn_class.dart' as barnClass;
import 'main.dart' as main;

class BarnList extends StatefulWidget {
  const BarnList({super.key});

  @override
  State<BarnList> createState() => _BarnList();
}

class _BarnList extends State<BarnList> {
  Future<String> getOwnerName(DocumentReference ownerRef) async {
    DocumentSnapshot ownerSnapshot = await ownerRef.get();

    if (ownerSnapshot.exists) {
      Map<String, dynamic> owner = ownerSnapshot.data() as Map<String, dynamic>;

      return owner['name'];
    } else {
      return "Problem getting owner information";
    }
  }

  Future<void> pickAnimalList(String barnName) async {
    QuerySnapshot qs = await FirebaseFirestore.instance
        .collection('animals')
        .where('barn',
            isEqualTo: FirebaseFirestore.instance
                .doc('barns/${main.MyApp.selectedBarn.id}'))
        .get();

    List<Animal> animalsTemp = [];
    for (QueryDocumentSnapshot doc in qs.docs) {
      Map<String, dynamic> item = doc.data() as Map<String, dynamic>;
      Animal temp = Animal(
          id: doc.id,
          description: item['description'] ?? "",
          stall: item['stall'] ?? "",
          feedingInstructions: item['feeding'] ?? "",
          medications: item['medications'] ?? "",
          vet: item['vet'] ?? "",
          farrier: item['farrier'] ?? "",
          name: item['name'] ?? "",
          owner: "");

      temp.owner = await getOwnerName(item['owner']);

      animalsTemp.add(temp);
    }

    main.MyApp.animals = animalsTemp;
  }

  Future<Person> getPersonFromId(DocumentReference personRef) async {
    DocumentSnapshot personSnapshot = await personRef.get();

    if (personSnapshot.exists) {
      Map<String, dynamic> person =
          personSnapshot.data() as Map<String, dynamic>;

      Person personToReturn = Person(
          id: personSnapshot.id,
          name: person['name'] ?? '',
          phoneNumber: person['number'] ?? '',
          emergencyPerson: person['emergencyPerson'] ?? '',
          emergencyNumber: person['emergencyNumber'] ?? '');
      return personToReturn;
    } else {
      return Person(
          id: "",
          name: "",
          phoneNumber: "",
          emergencyPerson: "",
          emergencyNumber: "");
    }
  }

  Future<void> pickPeopleList() async {
    QuerySnapshot qs = await FirebaseFirestore.instance
        .collection('barn_to_person')
        .where('barnid',
            isEqualTo: FirebaseFirestore.instance
                .doc('barns/${main.MyApp.selectedBarn.id}'))
        .get();

    List<Person> peopleTemp = [];
    for (QueryDocumentSnapshot doc in qs.docs) {
      Map<String, dynamic> item = doc.data() as Map<String, dynamic>;
      Person person = await getPersonFromId(item['personid']);

      peopleTemp.add(person);
    }

    main.MyApp.people = peopleTemp;
  }

  Widget buildBarns(List<barnClass.Barn> barns) => ListView.builder(
      itemCount: barns.length,
      itemBuilder: (context, index) {
        final barn = barns[index];

        return Card(
          child: ListTile(
            title: Text(barn.name),
            subtitle: Text(barn.address),
            onTap: () async {
              main.MyApp.selectedBarn = barn;
              await pickAnimalList(barn.name);
              await pickPeopleList();
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (ctx) => animalList.AnimalList(name: barn.name)));
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
                        'assets/images/pexels-brandon-randolph-2042161.jpg'),
                    fit: BoxFit.cover,
                    opacity: 0.5)),
            child: buildBarns(main.MyApp.barnList)));
  }
}
