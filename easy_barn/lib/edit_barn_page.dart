import 'package:easy_barn/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';

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

  @override
  Widget build(BuildContext ctx) {
    return Scaffold(
        body: SingleChildScrollView(
            child: Column(children: <Widget>[
      FormBuilder(
          key: _barnFormKey,
          onChanged: () {
            _barnFormKey.currentState!.save();
          },
          initialValue: {
            'name': MyApp.selectedBarn.Name,
            'phone': MyApp.selectedBarn.PhoneNumber,
            'address': MyApp.selectedBarn.Address,
            'owner': MyApp.selectedBarn.Owner,
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
                    _nameHasError = !(_barnFormKey.currentState?.fields['name']
                            ?.validate() ??
                        false);
                  });
                  if (!_nameHasError) {
                    MyApp.selectedBarn.Name = value!;
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
                    MyApp.selectedBarn.PhoneNumber = value!;
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
                    MyApp.selectedBarn.Address = value!;
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
              FormBuilderTextField(
                name: 'owner',
                maxLines: null,
                autovalidateMode: AutovalidateMode.always,
                decoration: InputDecoration(
                    labelText: 'Barn Owner',
                    suffixIcon: _ownerHasError
                        ? const Icon(Icons.error, color: Colors.red)
                        : const Icon(Icons.check, color: Colors.green)),
                onChanged: (value) {
                  setState(() {
                    _ownerHasError = !(_barnFormKey
                            .currentState?.fields['owner']
                            ?.validate() ??
                        false);
                  });
                  if (!_ownerHasError) {
                    MyApp.selectedBarn.Owner = value!;
                  }
                },
                validator: FormBuilderValidators.compose([
                  FormBuilderValidators.required(),
                  FormBuilderValidators.match('^[a-zA-Z \-]+\$'),
                  FormBuilderValidators.maxLength(30),
                ]),
                keyboardType: TextInputType.name,
                textInputAction: TextInputAction.next,
              ),
            ],
          )),
      Row(
        children: <Widget>[
          Expanded(
            child: ElevatedButton(
              onPressed: () {
                if (_barnFormKey.currentState?.saveAndValidate() ?? false) {
                  debugPrint(_barnFormKey.currentState?.value.toString());
                  Navigator.of(ctx).maybePop();
                } else {
                  debugPrint(_barnFormKey.currentState?.value.toString());
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
