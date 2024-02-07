import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:easy_barn/main.dart';
import 'package:easy_barn/person_class.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:google_fonts/google_fonts.dart';

class CreatePersonForm extends StatefulWidget {
  const CreatePersonForm({super.key});

  @override
  State<CreatePersonForm> createState() {
    return _CreatePersonForm();
  }
}

class _CreatePersonForm extends State<CreatePersonForm> {
  final _createPersonFormKey = GlobalKey<FormBuilderState>();

  Person newPerson = Person(
      id: "",
      name: "",
      phoneNumber: "",
      emergencyPerson: "",
      emergencyNumber: "");

  bool _nameHasError = false;
  bool _phoneHasError = false;
  bool _emergencyPersonHasError = false;
  bool _emergencyPhoneHasError = false;

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
              key: _createPersonFormKey,
              onChanged: () {
                _createPersonFormKey.currentState!.save();
              },
              child: Column(
                children: <Widget>[
                  FormBuilderTextField(
                    name: 'name',
                    maxLines: null,
                    autovalidateMode: AutovalidateMode.always,
                    decoration: InputDecoration(
                        labelText: 'Name',
                        suffixIcon: _nameHasError
                            ? const Icon(Icons.error, color: Colors.red)
                            : const Icon(Icons.check, color: Colors.green)),
                    onChanged: (value) {
                      setState(() {
                        _nameHasError = !(_createPersonFormKey
                                .currentState?.fields['name']
                                ?.validate() ??
                            false);
                      });
                      if (!_nameHasError) {
                        newPerson.name = value!;
                      }
                    },
                    validator: FormBuilderValidators.compose([
                      FormBuilderValidators.required(),
                      FormBuilderValidators.match('^[a-zA-Z \-]+\$'),
                      FormBuilderValidators.maxLength(40),
                    ]),
                    keyboardType: TextInputType.name,
                    textInputAction: TextInputAction.next,
                  ),
                  FormBuilderTextField(
                    name: 'phone',
                    maxLines: null,
                    autovalidateMode: AutovalidateMode.always,
                    decoration: InputDecoration(
                        labelText: 'Phone Number',
                        suffixIcon: _phoneHasError
                            ? const Icon(Icons.error, color: Colors.red)
                            : const Icon(Icons.check, color: Colors.green)),
                    onChanged: (value) {
                      setState(() {
                        _phoneHasError = !(_createPersonFormKey
                                .currentState?.fields['phone']
                                ?.validate() ??
                            false);
                      });
                      if (!_phoneHasError) {
                        newPerson.phoneNumber = value!;
                      }
                    },
                    validator: FormBuilderValidators.compose([
                      FormBuilderValidators.required(),
                      FormBuilderValidators.match(
                          '^[0-9]{3}[\-\. ]?[0-9]{3}[\-\. ]?[0-9]{4}\$'),
                      FormBuilderValidators.maxLength(12),
                    ]),
                    keyboardType: TextInputType.phone,
                    textInputAction: TextInputAction.next,
                  ),
                  FormBuilderTextField(
                    name: 'emergency_person',
                    maxLines: null,
                    autovalidateMode: AutovalidateMode.always,
                    decoration: InputDecoration(
                        labelText: 'Emergency Contact',
                        suffixIcon: _emergencyPersonHasError
                            ? const Icon(Icons.error, color: Colors.red)
                            : const Icon(Icons.check, color: Colors.green)),
                    onChanged: (value) {
                      setState(() {
                        _emergencyPersonHasError = !(_createPersonFormKey
                                .currentState?.fields['emergency_person']
                                ?.validate() ??
                            false);
                      });
                      if (!_emergencyPersonHasError) {
                        newPerson.emergencyPerson = value!;
                      }
                    },
                    validator: FormBuilderValidators.compose([
                      FormBuilderValidators.required(),
                      FormBuilderValidators.match('^[a-zA-Z \n\t\-]+\$'),
                      FormBuilderValidators.maxLength(30),
                    ]),
                    keyboardType: TextInputType.name,
                    textInputAction: TextInputAction.next,
                  ),
                  FormBuilderTextField(
                    name: 'emergency_number',
                    maxLines: null,
                    autovalidateMode: AutovalidateMode.always,
                    decoration: InputDecoration(
                        labelText: 'Emergency Contact Phone Number',
                        suffixIcon: _emergencyPhoneHasError
                            ? const Icon(Icons.error, color: Colors.red)
                            : const Icon(Icons.check, color: Colors.green)),
                    onChanged: (value) {
                      setState(() {
                        _emergencyPhoneHasError = !(_createPersonFormKey
                                .currentState?.fields['emergency_number']
                                ?.validate() ??
                            false);
                      });
                      if (!_emergencyPhoneHasError) {
                        newPerson.emergencyNumber = value!;
                      }
                    },
                    validator: FormBuilderValidators.compose([
                      FormBuilderValidators.required(),
                      FormBuilderValidators.match(
                          '^[0-9]{3}[\-\. ]?[0-9]{3}[\-\. ]?[0-9]{4}\$'),
                      FormBuilderValidators.maxLength(16),
                    ]),
                    keyboardType: TextInputType.multiline,
                    textInputAction: TextInputAction.next,
                  ),
                ],
              )),
          Row(
            children: <Widget>[
              Expanded(
                child: ElevatedButton(
                  onPressed: () async {
                    if (_createPersonFormKey.currentState?.saveAndValidate() ??
                        false) {
                      await updatePersonDatabase();
                      debugPrint(
                          _createPersonFormKey.currentState?.value.toString());
                      Navigator.of(ctx).maybePop();
                    } else {
                      debugPrint(
                          _createPersonFormKey.currentState?.value.toString());
                      debugPrint('validation failed');
                    }
                  },
                  child: const Text(
                    'Add',
                    style: TextStyle(color: Color.fromARGB(255, 37, 109, 168)),
                  ),
                ),
              ),
              Expanded(
                child: ElevatedButton(
                  onPressed: () async {
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

  Future<void> updatePersonDatabase() async {
    FirebaseFirestore.instance
        .collection('people')
        .add(newPerson.toMap())
        .then((value) {
      print('Updated successfully');
      newPerson.id = value.id;
      MyApp.people.add(newPerson);
    }).catchError((error) => print('Failed to update: $error'));
  }

  //TODO: Figure out how to link a person to a barn
  Future<void> linkPersonToBarn() async {}
}
