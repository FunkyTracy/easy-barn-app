import 'package:easy_barn/animal_pages/edit_animal_form.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import '../main.dart';

class AnimalDetailPage extends StatefulWidget {
  const AnimalDetailPage({super.key});

  @override
  State<AnimalDetailPage> createState() => _AnimalDetailPage();
}

class _AnimalDetailPage extends State<AnimalDetailPage> {
  @override
  Widget build(BuildContext ctx) {
    return Scaffold(
        backgroundColor: const Color.fromARGB(255, 244, 221, 177),
        appBar: AppBar(
          title: const Text(
            "Easy Barn",
          ),
          actions: <Widget>[
            Padding(
              padding: const EdgeInsets.only(right: 10),
              child: GestureDetector(
                onTap: () async {
                  await Navigator.of(ctx).push(MaterialPageRoute(
                      builder: (ctx) => const EditAnimalForm()));
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
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
              Container(
                padding: const EdgeInsets.all(10.0),
                height: 200,
                width: 200,
                child: FutureBuilder(
                  future: getAnimalImage(MyApp.selectedAnimal.photoLocation),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      // While waiting for the image, you can show a placeholder
                      return const CircularProgressIndicator();
                    } else if (snapshot.hasError) {
                      // Handle error if any
                      return const ColoredBox(color: Colors.white);
                    } else {
                      // Once the image is loaded, display it
                      return Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10.0),
                          image: DecorationImage(
                            image: snapshot.data!.image,
                            fit: BoxFit.cover,
                          ),
                        ),
                      );
                    }
                  },
                ),
              ),
              Card(
                  child: ListTile(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10)),
                title: Text(MyApp.selectedAnimal.name),
                subtitle: const Text("Animal Name"),
              )),
              Card(
                  child: ListTile(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10)),
                title: Text(MyApp.people
                    .firstWhere(
                        (person) => person.id == MyApp.selectedAnimal.ownerid)
                    .name),
                subtitle: const Text("Owner Name"),
              )),
              Card(
                  child: ListTile(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10)),
                title: Text(MyApp.selectedAnimal.description),
                subtitle: const Text("Description"),
              )),
              Card(
                  child: ListTile(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10)),
                title: Text(MyApp.selectedAnimal.stall),
                subtitle: const Text("Stall Location"),
              )),
              Card(
                  child: ListTile(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10)),
                title: Text(MyApp.selectedAnimal.feedingInstructions),
                subtitle: const Text("Feeding Instructions"),
              )),
              Card(
                  child: ListTile(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10)),
                title: Text(MyApp.selectedAnimal.medications),
                subtitle: const Text("Medications"),
              )),
              Card(
                  child: ListTile(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10)),
                title: Text(MyApp.selectedAnimal.vet),
                subtitle: const Text("Veterinarian"),
              )),
              Card(
                  child: ListTile(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10)),
                title: Text(MyApp.selectedAnimal.farrier),
                subtitle: const Text("Farrier"),
              )),
            ])));
  }

  Future<Image> getAnimalImage(String imageUrl) async {
    Reference imageRef = MyApp.firebaseStorage.ref().child(imageUrl);

    String url = await imageRef.getDownloadURL();

    return Image.network(url);
  }
}
