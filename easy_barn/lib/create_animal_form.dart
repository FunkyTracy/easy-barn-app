import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:easy_barn/animal_class.dart';
import 'package:easy_barn/main.dart';
import 'package:easy_barn/person_class.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:google_fonts/google_fonts.dart';

// '[^\s!@#\$%^&*(){}[]:;\'"<>?/\\_]+'

class CreateAnimalForm extends StatefulWidget {
  const CreateAnimalForm({super.key});

  @override
  State<CreateAnimalForm> createState() {
    return _CreateAnimalForm();
  }
}

class _CreateAnimalForm extends State<CreateAnimalForm> {
  final _createAnimalFormKey = GlobalKey<FormBuilderState>();

  bool _nameHasError = false;
  bool _ownerHasError = false;
  bool _descriptionHasError = false;
  bool _stallLocationHasError = false;
  bool _feedingHasError = false;
  bool _medicationHasError = false;
  bool _vetHasError = false;
  bool _farrierHasError = false;
  bool _barnHasError = false;

  List<Person> allPeople = [];
  String barnId = "";

  static Animal newAnimal = Animal(
      id: "",
      description: "",
      stall: "",
      feedingInstructions: "",
      medications: "",
      vet: "",
      farrier: "",
      name: "",
      ownerid: "");

  @override
  void initState() {
    super.initState();
    getAllPeople().then((_) {
      setState(() {});
    });
  }

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
        body: SingleChildScrollView(
            child: Column(children: <Widget>[
          FormBuilder(
              key: _createAnimalFormKey,
              onChanged: () {
                _createAnimalFormKey.currentState!.save();
              },
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
                        _nameHasError = !(_createAnimalFormKey
                                .currentState?.fields['name']
                                ?.validate() ??
                            false);
                      });
                      if (!_nameHasError) {
                        newAnimal.name = value!;
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
                  FormBuilderDropdown(
                    name: 'owner',
                    decoration: InputDecoration(
                        labelText: 'Owner',
                        suffix: _ownerHasError
                            ? const Icon(Icons.error, color: Colors.red)
                            : const Icon(Icons.check, color: Colors.green),
                        hintText: 'Select owner of the animal'),
                    validator: FormBuilderValidators.compose(
                        [FormBuilderValidators.required()]),
                    items: allPeople
                        .map((person) => DropdownMenuItem(
                              child: Text(person.name),
                              value: person,
                              alignment: AlignmentDirectional.center,
                              onTap: () {
                                newAnimal.ownerid = person.id;
                              },
                            ))
                        .toList(),
                    onChanged: (value) async {
                      setState(() {
                        _ownerHasError = !(_createAnimalFormKey
                                .currentState?.fields['owner']
                                ?.validate() ??
                            false);
                      });
                    },
                  ),
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
                        _descriptionHasError = !(_createAnimalFormKey
                                .currentState?.fields['description']
                                ?.validate() ??
                            false);
                      });
                      if (!_descriptionHasError) {
                        newAnimal.description = value!;
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
                        _stallLocationHasError = !(_createAnimalFormKey
                                .currentState?.fields['stall_location']
                                ?.validate() ??
                            false);
                      });
                      if (!_stallLocationHasError) {
                        newAnimal.stall = value!;
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
                        _feedingHasError = !(_createAnimalFormKey
                                .currentState?.fields['feeding']
                                ?.validate() ??
                            false);
                      });
                      if (!_feedingHasError) {
                        newAnimal.feedingInstructions = value!;
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
                        _medicationHasError = !(_createAnimalFormKey
                                .currentState?.fields['meds']
                                ?.validate() ??
                            false);
                      });
                      if (!_medicationHasError) {
                        newAnimal.medications = value!;
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
                        _vetHasError = !(_createAnimalFormKey
                                .currentState?.fields['vet']
                                ?.validate() ??
                            false);
                      });
                      if (!_vetHasError) {
                        newAnimal.vet = value!;
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
                        _farrierHasError = !(_createAnimalFormKey
                                .currentState?.fields['farrier']
                                ?.validate() ??
                            false);
                      });
                      if (!_farrierHasError) {
                        newAnimal.farrier = value!;
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
              )),
          FormBuilderDropdown(
            name: 'placement_barn',
            decoration: InputDecoration(
                labelText: 'Barn',
                suffix: _barnHasError
                    ? const Icon(Icons.error, color: Colors.red)
                    : const Icon(Icons.check, color: Colors.green),
                hintText: 'Select barn to add animal to'),
            validator: FormBuilderValidators.compose(
                [FormBuilderValidators.required()]),
            items: MyApp.barnList
                .map((barn) => DropdownMenuItem(
                      child: Text(barn.name),
                      value: barn,
                      alignment: AlignmentDirectional.center,
                      onTap: () {
                        barnId = barn.id;
                      },
                    ))
                .toList(),
            onChanged: (value) {
              setState(() {
                _barnHasError = !(_createAnimalFormKey
                        .currentState?.fields['placement_barn']
                        ?.validate() ??
                    false);
              });
            },
          ),
          Row(
            children: <Widget>[
              Expanded(
                child: ElevatedButton(
                  onPressed: () async {
                    if (_createAnimalFormKey.currentState?.saveAndValidate() ??
                        false) {
                      await addAnimalToDatabase();
                      debugPrint(
                          _createAnimalFormKey.currentState?.value.toString());
                      Navigator.of(ctx).maybePop();
                    } else {
                      debugPrint(
                          _createAnimalFormKey.currentState?.value.toString());
                      debugPrint('validation failed');
                    }
                  },
                  child: const Text(
                    'Save',
                    style: TextStyle(color: Color.fromARGB(255, 37, 109, 168)),
                  ),
                ),
              ),
            ],
          )
        ])));
  }

  Future<void> addAnimalToDatabase() async {
    DocumentReference barnRef =
        FirebaseFirestore.instance.collection('barns').doc(barnId);
    DocumentReference personRef =
        FirebaseFirestore.instance.collection('people').doc(newAnimal.ownerid);

    DocumentReference animalRef =
        await FirebaseFirestore.instance.collection('animals').add({
      'name': newAnimal.name,
      'description': newAnimal.description,
      'farrier': newAnimal.farrier,
      'feeding': newAnimal.feedingInstructions,
      'medications': newAnimal.medications,
      'stall': newAnimal.stall,
      'vet': newAnimal.vet,
      'barn': barnRef,
      'owner': personRef
    });

    newAnimal.id = animalRef.id;
    MyApp.animals.add(newAnimal);
  }

  Future<void> getAllPeople() async {
    QuerySnapshot qs =
        await FirebaseFirestore.instance.collection('people').get();

    for (QueryDocumentSnapshot doc in qs.docs) {
      Map<String, dynamic> item = doc.data() as Map<String, dynamic>;
      Person person = Person(
          id: doc.id,
          name: item['name'] ?? '',
          phoneNumber: item['number'] ?? '',
          emergencyPerson: item['emergencyPerson'] ?? '',
          emergencyNumber: item['emergencyNumber'] ?? '');

      allPeople.add(person);
    }
  }
}
