import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:easy_barn/barn_class.dart';
import 'package:easy_barn/main.dart';
import 'package:easy_barn/person_class.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:google_fonts/google_fonts.dart';

class EditBarnForm extends StatefulWidget {
  const EditBarnForm({super.key});

  @override
  State<EditBarnForm> createState() {
    return _EditBarnForm();
  }
}

class _EditBarnForm extends State<EditBarnForm> {
  final _createBarnFormKey = GlobalKey<FormBuilderState>();

  bool _nameHasError = false;
  bool _phoneHasError = false;
  bool _addressHasError = false;
  bool _ownerHasError = false;

  Barn newBarn =
      Barn(id: "", address: "", name: "", ownerid: "", phoneNumber: "");

  List<DocumentReference> peopleDocs = [];

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
              key: _createBarnFormKey,
              onChanged: () {
                _createBarnFormKey.currentState!.save();
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
                      FormBuilderValidators.match('^[a-zA-Z0-9\., \n\t\-]+\$'),
                      FormBuilderValidators.maxLength(60),
                    ]),
                    keyboardType: TextInputType.streetAddress,
                    textInputAction: TextInputAction.next,
                  ),
                  FormBuilderDropdown(
                    name: 'owner',
                    decoration: InputDecoration(
                        labelText: 'Owner',
                        suffix: _ownerHasError
                            ? const Icon(Icons.error, color: Colors.red)
                            : const Icon(Icons.check, color: Colors.green),
                        hintText: 'Select owner of the barn'),
                    validator: FormBuilderValidators.compose(
                        [FormBuilderValidators.required()]),
                    items: getAllPeople().map(),
                    onChanged: (value) async {
                      setState(() {
                        _ownerHasError = !(_createBarnFormKey
                                .currentState?.fields['owner']
                                ?.validate() ??
                            false);
                      });
                    },
                  ),
                ],
              )),
          Row(
            children: <Widget>[
              Expanded(
                child: ElevatedButton(
                  onPressed: () async {
                    if (_createBarnFormKey.currentState?.saveAndValidate() ??
                        false) {
                      debugPrint(
                          _createBarnFormKey.currentState?.value.toString());
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
            ],
          )
        ])));
  }

  Future<void> updateBarnDatabase() async {
    DocumentReference ownerRef = await FirebaseFirestore.instance
        .collection('people')
        .doc(newBarn.ownerid);

    FirebaseFirestore.instance.collection('barns').add({
      'name': newBarn.name,
      'address': newBarn.address,
      'number': newBarn.phoneNumber,
      'owner': ownerRef
    });
  }

  Future<List<Person>> getAllPeople() async {
    QuerySnapshot qs =
        await FirebaseFirestore.instance.collection('people').get();

    List<Person> peopleTemp = [];
    for (QueryDocumentSnapshot doc in qs.docs) {
      Map<String, dynamic> item = doc.data() as Map<String, dynamic>;
      Person person = Person(
          id: doc.id,
          name: item['name'] ?? '',
          phoneNumber: item['number'] ?? '',
          emergencyPerson: item['emergencyPerson'] ?? '',
          emergencyNumber: item['emergencyNumber'] ?? '');

      peopleTemp.add(person);
    }

    return peopleTemp;
  }
}
