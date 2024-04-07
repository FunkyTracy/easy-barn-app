// ignore_for_file: unnecessary_string_escapes, use_build_context_synchronously

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:easy_barn/barn_pages/barn_class.dart';
import 'package:easy_barn/main.dart';
import 'package:easy_barn/person_pages/person_class.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:google_fonts/google_fonts.dart';

class CreateBarnForm extends StatefulWidget {
  const CreateBarnForm({super.key});

  @override
  State<CreateBarnForm> createState() {
    return _CreateBarnForm();
  }
}

class _CreateBarnForm extends State<CreateBarnForm> {
  final _createBarnFormKey = GlobalKey<FormBuilderState>();

  bool _nameHasError = false;
  bool _phoneHasError = false;
  bool _addressHasError = false;

  List<Person> allPeople = [];

  Barn newBarn = Barn(
      id: "",
      address: "",
      name: "",
      ownerid: MyApp.currentUser.id,
      phoneNumber: "");

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
              key: _createBarnFormKey,
              onChanged: () {
                _createBarnFormKey.currentState!.save();
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
                            labelText: 'Name',
                            suffixIcon: _nameHasError
                                ? const Icon(Icons.error, color: Colors.red)
                                : const Icon(Icons.check, color: Colors.green)),
                        onChanged: (value) {
                          setState(() {
                            _nameHasError = !(_createBarnFormKey
                                    .currentState?.fields['name']
                                    ?.validate() ??
                                false);
                          });
                          if (!_nameHasError) {
                            newBarn.name = value!;
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
                      const SizedBox(height: 20.0),
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
                            _phoneHasError = !(_createBarnFormKey
                                    .currentState?.fields['phone']
                                    ?.validate() ??
                                false);
                          });
                          if (!_phoneHasError) {
                            newBarn.phoneNumber = value!;
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
                      const SizedBox(height: 20.0),
                      FormBuilderTextField(
                        name: 'address',
                        maxLines: null,
                        autovalidateMode: AutovalidateMode.always,
                        decoration: InputDecoration(
                            labelText: 'Address',
                            suffixIcon: _addressHasError
                                ? const Icon(Icons.error, color: Colors.red)
                                : const Icon(Icons.check, color: Colors.green)),
                        onChanged: (value) {
                          setState(() {
                            _addressHasError = !(_createBarnFormKey
                                    .currentState?.fields['address']
                                    ?.validate() ??
                                false);
                          });
                          if (!_addressHasError) {
                            newBarn.address = value!;
                          }
                        },
                        validator: FormBuilderValidators.compose([
                          FormBuilderValidators.required(),
                          FormBuilderValidators.match(
                              '^[a-zA-Z0-9\., \n\t\-]+\$'),
                          FormBuilderValidators.maxLength(60),
                        ]),
                        keyboardType: TextInputType.streetAddress,
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
                    if (_createBarnFormKey.currentState?.saveAndValidate() ??
                        false) {
                      debugPrint(
                          _createBarnFormKey.currentState?.value.toString());
                      await addBarnToDatabase();
                      await linkPersonToBarn();
                      Navigator.of(ctx).maybePop();
                    } else {
                      debugPrint(
                          _createBarnFormKey.currentState?.value.toString());
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

  Future<void> addBarnToDatabase() async {
    DocumentReference ownerRef =
        FirebaseFirestore.instance.collection('people').doc(newBarn.ownerid);

    DocumentReference barnRef =
        await FirebaseFirestore.instance.collection('barns').add({
      'name': newBarn.name,
      'address': newBarn.address,
      'number': newBarn.phoneNumber,
      'owner': ownerRef
    });

    newBarn.id = barnRef.id;
    MyApp.barnList.add(newBarn);
  }

  Future<void> linkPersonToBarn() async {
    DocumentReference barnRef =
        FirebaseFirestore.instance.collection('barns').doc(newBarn.id);
    DocumentReference personRef =
        FirebaseFirestore.instance.collection('people').doc(newBarn.ownerid);

    FirebaseFirestore.instance
        .collection('barn_to_person')
        .add({'barnid': barnRef, 'personid': personRef});
  }
}
