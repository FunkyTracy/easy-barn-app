import 'package:easy_barn/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';

class EditPersonForm extends StatefulWidget {
  const EditPersonForm({super.key});

  @override
  State<EditPersonForm> createState() {
    return _EditPersonForm();
  }
}

class _EditPersonForm extends State<EditPersonForm> {
  final _personFormKey = GlobalKey<FormBuilderState>();

  bool _nameHasError = false;
  bool _phoneHasError = false;
  bool _emergencyPersonHasError = false;
  bool _emergencyPhoneHasError = false;

  @override
  Widget build(BuildContext ctx) {
    return Scaffold(
        body: SingleChildScrollView(
            child: Column(children: <Widget>[
      FormBuilder(
          key: _personFormKey,
          onChanged: () {
            _personFormKey.currentState!.save();
          },
          initialValue: {
            'name': MyApp.selectedPerson.Name,
            'phone': MyApp.selectedPerson.PhoneNumber,
            'emergency_person': MyApp.selectedPerson.EmergencyPerson,
            'emergency_number': MyApp.selectedPerson.EmergencyNumber,
          },
          child: Column(
            children: <Widget>[
              const SizedBox(height: 15),
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
                    _nameHasError = !(_personFormKey
                            .currentState?.fields['name']
                            ?.validate() ??
                        false);
                  });
                  if (!_nameHasError) {
                    MyApp.selectedPerson.Name = value!;
                  }
                },
                validator: FormBuilderValidators.compose([
                  FormBuilderValidators.required(),
                  FormBuilderValidators.match('^[a-zA-Z \-]+'),
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
                    _phoneHasError = !(_personFormKey
                            .currentState?.fields['phone']
                            ?.validate() ??
                        false);
                  });
                  if (!_phoneHasError) {
                    MyApp.selectedPerson.PhoneNumber = value!;
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
                    _emergencyPersonHasError = !(_personFormKey
                            .currentState?.fields['emergency_person']
                            ?.validate() ??
                        false);
                  });
                  if (!_emergencyPersonHasError) {
                    MyApp.selectedPerson.EmergencyPerson = value!;
                  }
                },
                validator: FormBuilderValidators.compose([
                  FormBuilderValidators.required(),
                  FormBuilderValidators.match('^[a-zA-Z \n\t\-]+'),
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
                    _emergencyPhoneHasError = !(_personFormKey
                            .currentState?.fields['emergency_number']
                            ?.validate() ??
                        false);
                  });
                  if (!_emergencyPhoneHasError) {
                    MyApp.selectedPerson.EmergencyNumber = value!;
                  }
                },
                validator: FormBuilderValidators.compose([
                  FormBuilderValidators.required(),
                  FormBuilderValidators.match(
                      '^[0-9]{3}[\-\. ]?[0-9]{3}[\-\. ]?[0-9]{4}\4'),
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
              onPressed: () {
                if (_personFormKey.currentState?.saveAndValidate() ?? false) {
                  debugPrint(_personFormKey.currentState?.value.toString());
                  Navigator.of(ctx).maybePop();
                } else {
                  debugPrint(_personFormKey.currentState?.value.toString());
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
}
