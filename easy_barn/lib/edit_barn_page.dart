import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:easy_barn/barn_class.dart';
import 'package:easy_barn/main.dart';
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
  final _barnFormKey = GlobalKey<FormBuilderState>();

  bool _nameHasError = false;
  bool _phoneHasError = false;
  bool _addressHasError = false;
  bool _ownerHasError = false;

  Barn placeholderBarn = Barn(
      id: MyApp.selectedBarn.id,
      address: MyApp.selectedBarn.address,
      name: MyApp.selectedBarn.name,
      ownerid: MyApp.selectedBarn.ownerid,
      phoneNumber: MyApp.selectedBarn.phoneNumber);

  String newOwnerId = "";

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
              key: _barnFormKey,
              onChanged: () {
                _barnFormKey.currentState!.save();
              },
              initialValue: {
                'name': MyApp.selectedBarn.name,
                'phone': MyApp.selectedBarn.phoneNumber,
                'address': MyApp.selectedBarn.address,
                'owner': MyApp.people.firstWhere(
                    (person) => person.id == MyApp.selectedBarn.ownerid),
              },
              child: Column(children: <Widget>[
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
                      _nameHasError = !(_barnFormKey
                              .currentState?.fields['name']
                              ?.validate() ??
                          false);
                    });
                    if (!_nameHasError) {
                      MyApp.selectedBarn.name = value!;
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
                      _phoneHasError = !(_barnFormKey
                              .currentState?.fields['phone']
                              ?.validate() ??
                          false);
                    });
                    if (!_phoneHasError) {
                      MyApp.selectedBarn.phoneNumber = value!;
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
                      _addressHasError = !(_barnFormKey
                              .currentState?.fields['address']
                              ?.validate() ??
                          false);
                    });
                    if (!_addressHasError) {
                      MyApp.selectedBarn.address = value!;
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
                        hintText: 'Select owner of the animal'),
                    validator: FormBuilderValidators.compose(
                        [FormBuilderValidators.required()]),
                    items: MyApp.people
                        .map((person) => DropdownMenuItem(
                              child: Text(person.name),
                              value: person,
                              alignment: AlignmentDirectional.center,
                              onTap: () {
                                newOwnerId = person.id;
                              },
                            ))
                        .toList(),
                    onChanged: (value) async {
                      setState(() {
                        _ownerHasError = !(_barnFormKey
                                .currentState?.fields['owner']
                                ?.validate() ??
                            false);
                      });
                    }),
                Row(
                  children: <Widget>[
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () async {
                          if (_barnFormKey.currentState?.saveAndValidate() ??
                              false) {
                            await updateBarnDatabase();
                            debugPrint(
                                _barnFormKey.currentState?.value.toString());
                            Navigator.of(ctx).maybePop();
                          } else {
                            debugPrint(
                                _barnFormKey.currentState?.value.toString());
                            debugPrint('validation failed');
                          }
                        },
                        child: const Text(
                          'Save',
                          style: TextStyle(
                              color: Color.fromARGB(255, 37, 109, 168)),
                        ),
                      ),
                    ),
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () async {
                          MyApp.selectedBarn = placeholderBarn;
                          Navigator.of(ctx).maybePop();
                        },
                        child: const Text(
                          'Cancel',
                          style: TextStyle(
                              color: Color.fromARGB(255, 37, 109, 168)),
                        ),
                      ),
                    ),
                  ],
                )
              ]))
        ])));
  }

  Future<void> updateBarnDatabase() async {
    MyApp.selectedBarn.ownerid = newOwnerId;

    Barn temp = MyApp.barnList
        .firstWhere((element) => element.id == MyApp.selectedBarn.id);
    int index = MyApp.barnList.indexOf(temp);
    MyApp.barnList[index] = MyApp.selectedBarn;

    DocumentReference ownerRef = FirebaseFirestore.instance
        .collection('people')
        .doc(MyApp.selectedBarn.ownerid);

    FirebaseFirestore.instance
        .collection('barns')
        .doc(MyApp.selectedBarn.id)
        .update({
          'address': MyApp.selectedBarn.address,
          'name': MyApp.selectedBarn.name,
          'number': MyApp.selectedBarn.phoneNumber,
          'owner': ownerRef
        })
        .then((value) => print('Updated successfully'))
        .catchError((error) => print('Failed to update: $error'));
  }
}
