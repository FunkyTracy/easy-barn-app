// ignore_for_file: unnecessary_string_escapes, use_build_context_synchronously, avoid_print

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:easy_barn/animal_pages/animal_class.dart';
import 'package:easy_barn/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:google_fonts/google_fonts.dart';

// '[^\s!@#\$%^&*(){}[]:;\'"<>?/\\_]+'

class EditAnimalForm extends StatefulWidget {
  const EditAnimalForm({super.key});

  @override
  State<EditAnimalForm> createState() {
    return _EditAnimalForm();
  }
}

class _EditAnimalForm extends State<EditAnimalForm> {
  final _animalFormKey = GlobalKey<FormBuilderState>();

  bool _nameHasError = false;
  bool _ownerHasError = false;
  bool _descriptionHasError = false;
  bool _stallLocationHasError = false;
  bool _feedingHasError = false;
  bool _medicationHasError = false;
  bool _vetHasError = false;
  bool _farrierHasError = false;

  Animal placeholderAnimal = Animal(
      id: MyApp.selectedAnimal.id,
      description: MyApp.selectedAnimal.description,
      stall: MyApp.selectedAnimal.stall,
      feedingInstructions: MyApp.selectedAnimal.feedingInstructions,
      medications: MyApp.selectedAnimal.medications,
      vet: MyApp.selectedAnimal.vet,
      farrier: MyApp.selectedAnimal.farrier,
      name: MyApp.selectedAnimal.name,
      ownerid: MyApp.selectedAnimal.ownerid);

  String newOwnerId = "";

  @override
  Widget build(BuildContext ctx) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: const Color.fromARGB(255, 51, 91, 122),
          title: Text(
            "Easy Barn",
            style: GoogleFonts.bitter(
                textStyle: const TextStyle(
                    color: Color.fromARGB(255, 244, 221, 177),
                    fontSize: 28,
                    fontWeight: FontWeight.w600)),
          ),
        ),
        body: SingleChildScrollView(
            child: Column(children: <Widget>[
          FormBuilder(
              key: _animalFormKey,
              initialValue: {
                'name': MyApp.selectedAnimal.name,
                'owner': MyApp.people.firstWhere(
                    (person) => person.id == MyApp.selectedAnimal.ownerid),
                'description': MyApp.selectedAnimal.description,
                'stall_location': MyApp.selectedAnimal.stall,
                'feeding': MyApp.selectedAnimal.feedingInstructions,
                'meds': MyApp.selectedAnimal.medications,
                'vet': MyApp.selectedAnimal.vet,
                'farrier': MyApp.selectedAnimal.farrier
              },
              child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Column(
                    children: <Widget>[
                      FormBuilderTextField(
                        name: 'name',
                        maxLines: null,
                        autovalidateMode: AutovalidateMode.always,
                        decoration: InputDecoration(
                            labelText: 'Animal Name',
                            suffixIcon: _nameHasError
                                ? const Icon(Icons.error, color: Colors.red)
                                : const Icon(Icons.check, color: Colors.green)),
                        onChanged: (value) {
                          setState(() {
                            _nameHasError = !(_animalFormKey
                                    .currentState?.fields['name']
                                    ?.validate() ??
                                false);
                          });
                          if (!_nameHasError) {
                            MyApp.selectedAnimal.name = value!;
                          }
                        },
                        validator: FormBuilderValidators.compose([
                          FormBuilderValidators.required(),
                          FormBuilderValidators.match('^[a-zA-Z \t\n-]+\$'),
                          FormBuilderValidators.maxLength(40),
                        ]),
                        keyboardType: TextInputType.name,
                        textInputAction: TextInputAction.next,
                      ),
                      const SizedBox(height: 20.0),
                      FormBuilderDropdown(
                          name: 'owner',
                          decoration: InputDecoration(
                              labelText: 'Owner',
                              suffix: _ownerHasError
                                  ? const Icon(Icons.error, color: Colors.red)
                                  : const Icon(Icons.check,
                                      color: Colors.green),
                              hintText: 'Select owner of the animal'),
                          validator: FormBuilderValidators.compose(
                              [FormBuilderValidators.required()]),
                          items: MyApp.people
                              .map((person) => DropdownMenuItem(
                                    value: person,
                                    alignment: AlignmentDirectional.center,
                                    onTap: () {
                                      newOwnerId = person.id;
                                    },
                                    child: Text(person.name),
                                  ))
                              .toList(),
                          onChanged: (value) async {
                            setState(() {
                              _ownerHasError = !(_animalFormKey
                                      .currentState?.fields['owner']
                                      ?.validate() ??
                                  false);
                            });
                          }),
                      const SizedBox(height: 20.0),
                      FormBuilderTextField(
                        name: 'description',
                        maxLines: null,
                        autovalidateMode: AutovalidateMode.always,
                        decoration: InputDecoration(
                            labelText: 'Description',
                            suffixIcon: _descriptionHasError
                                ? const Icon(Icons.error, color: Colors.red)
                                : const Icon(Icons.check, color: Colors.green)),
                        onChanged: (value) {
                          setState(() {
                            _descriptionHasError = !(_animalFormKey
                                    .currentState?.fields['description']
                                    ?.validate() ??
                                false);
                          });
                          if (!_descriptionHasError) {
                            MyApp.selectedAnimal.description = value!;
                          }
                        },
                        validator: FormBuilderValidators.compose([
                          FormBuilderValidators.required(),
                          FormBuilderValidators.match(
                              '^[a-zA-Z0-9 \n\t\(\),\.-]+\$'),
                          FormBuilderValidators.maxLength(100),
                        ]),
                        keyboardType: TextInputType.multiline,
                        textInputAction: TextInputAction.next,
                      ),
                      const SizedBox(height: 20.0),
                      FormBuilderTextField(
                        name: 'stall_location',
                        maxLines: null,
                        autovalidateMode: AutovalidateMode.always,
                        decoration: InputDecoration(
                            labelText: 'Stall Location',
                            suffixIcon: _stallLocationHasError
                                ? const Icon(Icons.error, color: Colors.red)
                                : const Icon(Icons.check, color: Colors.green)),
                        onChanged: (value) {
                          setState(() {
                            _stallLocationHasError = !(_animalFormKey
                                    .currentState?.fields['stall_location']
                                    ?.validate() ??
                                false);
                          });
                          if (!_stallLocationHasError) {
                            MyApp.selectedAnimal.stall = value!;
                          }
                        },
                        validator: FormBuilderValidators.compose([
                          FormBuilderValidators.required(),
                          FormBuilderValidators.match(
                              '^[a-zA-Z0-9# \n\t\(\),\.-]+\$'),
                          FormBuilderValidators.maxLength(100),
                        ]),
                        keyboardType: TextInputType.multiline,
                        textInputAction: TextInputAction.next,
                      ),
                      const SizedBox(height: 20.0),
                      FormBuilderTextField(
                        name: 'feeding',
                        maxLines: null,
                        autovalidateMode: AutovalidateMode.always,
                        decoration: InputDecoration(
                            labelText: 'Feeding Instructions',
                            suffixIcon: _feedingHasError
                                ? const Icon(Icons.error, color: Colors.red)
                                : const Icon(Icons.check, color: Colors.green)),
                        onChanged: (value) {
                          setState(() {
                            _feedingHasError = !(_animalFormKey
                                    .currentState?.fields['feeding']
                                    ?.validate() ??
                                false);
                          });
                          if (!_feedingHasError) {
                            MyApp.selectedAnimal.feedingInstructions = value!;
                          }
                        },
                        validator: FormBuilderValidators.compose([
                          FormBuilderValidators.required(),
                          FormBuilderValidators.match(
                              '^[a-zA-Z0-9 \n\t\(\),\.-]+\$'),
                          FormBuilderValidators.maxLength(100),
                        ]),
                        keyboardType: TextInputType.multiline,
                        textInputAction: TextInputAction.next,
                      ),
                      const SizedBox(height: 20.0),
                      FormBuilderTextField(
                        name: 'meds',
                        maxLines: null,
                        autovalidateMode: AutovalidateMode.always,
                        decoration: InputDecoration(
                            labelText: 'Medications',
                            suffixIcon: _medicationHasError
                                ? const Icon(Icons.error, color: Colors.red)
                                : const Icon(Icons.check, color: Colors.green)),
                        onChanged: (value) {
                          setState(() {
                            _medicationHasError = !(_animalFormKey
                                    .currentState?.fields['meds']
                                    ?.validate() ??
                                false);
                          });
                          if (!_medicationHasError) {
                            MyApp.selectedAnimal.medications = value!;
                          }
                        },
                        validator: FormBuilderValidators.compose([
                          FormBuilderValidators.required(),
                          FormBuilderValidators.match(
                              '^[a-zA-Z0-9 \n\t\(\),\.-]+\$'),
                          FormBuilderValidators.maxLength(100),
                        ]),
                        keyboardType: TextInputType.multiline,
                        textInputAction: TextInputAction.next,
                      ),
                      const SizedBox(height: 20.0),
                      FormBuilderTextField(
                        name: 'vet',
                        maxLines: null,
                        autovalidateMode: AutovalidateMode.always,
                        decoration: InputDecoration(
                            labelText: 'Veterinarian',
                            suffixIcon: _vetHasError
                                ? const Icon(Icons.error, color: Colors.red)
                                : const Icon(Icons.check, color: Colors.green)),
                        onChanged: (value) {
                          setState(() {
                            _vetHasError = !(_animalFormKey
                                    .currentState?.fields['vet']
                                    ?.validate() ??
                                false);
                          });
                          if (!_vetHasError) {
                            MyApp.selectedAnimal.vet = value!;
                          }
                        },
                        validator: FormBuilderValidators.compose([
                          FormBuilderValidators.required(),
                          FormBuilderValidators.match(
                              '^[a-zA-Z0-9 \n\t\(\),\.-]+\$'),
                          FormBuilderValidators.maxLength(70),
                        ]),
                        keyboardType: TextInputType.multiline,
                        textInputAction: TextInputAction.next,
                      ),
                      const SizedBox(height: 20.0),
                      FormBuilderTextField(
                        name: 'farrier',
                        maxLines: null,
                        autovalidateMode: AutovalidateMode.always,
                        decoration: InputDecoration(
                            labelText: 'Farrier',
                            suffixIcon: _farrierHasError
                                ? const Icon(Icons.error, color: Colors.red)
                                : const Icon(Icons.check, color: Colors.green)),
                        onChanged: (value) {
                          setState(() {
                            _farrierHasError = !(_animalFormKey
                                    .currentState?.fields['farrier']
                                    ?.validate() ??
                                false);
                          });
                          if (!_farrierHasError) {
                            MyApp.selectedAnimal.farrier = value!;
                          }
                        },
                        validator: FormBuilderValidators.compose([
                          FormBuilderValidators.required(),
                          FormBuilderValidators.match(
                              '^[a-zA-Z0-9 \n\t\(\),\.-]+\$'),
                          FormBuilderValidators.maxLength(50),
                        ]),
                        keyboardType: TextInputType.multiline,
                        textInputAction: TextInputAction.next,
                      ),
                    ],
                  ))),
          const SizedBox(height: 20.0),
          Row(
            children: <Widget>[
              Expanded(
                child: ElevatedButton(
                  onPressed: () async {
                    if (_animalFormKey.currentState?.saveAndValidate() ??
                        false) {
                      await updateAnimals();
                      debugPrint(_animalFormKey.currentState?.value.toString());
                      Navigator.of(ctx).maybePop();
                    } else {
                      debugPrint(_animalFormKey.currentState?.value.toString());
                      debugPrint('validation failed');
                    }
                  },
                  child: const Text(
                    'Save',
                    style: TextStyle(color: Color.fromARGB(255, 37, 109, 168)),
                  ),
                ),
              ),
              Expanded(
                child: ElevatedButton(
                  onPressed: () async {
                    MyApp.selectedAnimal = placeholderAnimal;
                    Navigator.of(ctx).maybePop();
                  },
                  child: const Text(
                    'Cancel',
                    style: TextStyle(color: Color.fromARGB(255, 37, 109, 168)),
                  ),
                ),
              ),
            ],
          )
        ])));
  }

  Future<void> updateAnimals() async {
    if (newOwnerId.isNotEmpty) {
      MyApp.selectedAnimal.ownerid = newOwnerId;
    }

    Animal found = MyApp.animals
        .firstWhere((element) => element.id == MyApp.selectedAnimal.id);
    int index = MyApp.animals.indexOf(found);
    MyApp.animals[index] = MyApp.selectedAnimal;

    DocumentReference ownerRef = FirebaseFirestore.instance
        .collection('people')
        .doc(MyApp.selectedAnimal.ownerid);

    FirebaseFirestore.instance
        .collection('animals')
        .doc(MyApp.selectedAnimal.id)
        .update({
          'name': MyApp.selectedAnimal.name,
          'description': MyApp.selectedAnimal.description,
          'farrier': MyApp.selectedAnimal.farrier,
          'feeding': MyApp.selectedAnimal.feedingInstructions,
          'medications': MyApp.selectedAnimal.medications,
          'stall': MyApp.selectedAnimal.stall,
          'vet': MyApp.selectedAnimal.vet,
          'owner': ownerRef
        })
        .then((value) => print('Updated successfully'))
        .catchError((error) => print('Failed to update: $error'));
  }
}
