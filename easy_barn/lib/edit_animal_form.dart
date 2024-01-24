import 'package:easy_barn/main.dart';
import 'package:flutter/material.dart';

class EditAnimalForm extends StatefulWidget {
  const EditAnimalForm({super.key});

  @override
  State<EditAnimalForm> createState() {
    return _EditAnimalForm();
  }
}

class _EditAnimalForm extends State<EditAnimalForm> {
  final _animalFormKey = GlobalKey<FormState>();

  //controllers for the form fields
  final nameController = TextEditingController(text: MyApp.selectedAnimal.Name);

  @override
  void dispose() {
    nameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext ctx) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.lightBlue.shade900,
          title: const Text("Easy Barn"),
        ),
        body: Form(
            key: _animalFormKey,
            child: Column(
              children: <Widget>[
                Padding(
                    padding: const EdgeInsets.all(5),
                    child: TextFormField(
                      controller: nameController,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter a value';
                        }
                        //regex pattern doesn't work
                        if (value.contains(RegExp(r'[^&!;:%\$<>/\\?[]{}@#]'))) {
                          return 'Invalid entry';
                        }
                        return null;
                      },
                    )),
                ElevatedButton(
                    onPressed: () {
                      if (_animalFormKey.currentState!.validate()) {
                        ScaffoldMessenger.of(ctx).showSnackBar(const SnackBar(
                          content: Text('Saving Changes'),
                          duration: Durations.short3,
                        ));
                        MyApp.selectedAnimal.Name = nameController.text;
                        Navigator.of(ctx).maybePop();
                      }
                    },
                    child: const Text('Save'))
              ],
            )));
  }
}
