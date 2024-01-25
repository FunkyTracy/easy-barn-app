import 'package:easy_barn/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';

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

  //controllers for the form fields
  final nameController = TextEditingController(text: MyApp.selectedAnimal.Name);

  bool _nameHasError = false;

  @override
  void dispose() {
    nameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext ctx) {
    return Scaffold(
        body: SingleChildScrollView(
            child: Column(children: <Widget>[
      FormBuilder(
          key: _animalFormKey,
          onChanged: () {
            _animalFormKey.currentState!.save();
          },
          initialValue: {
            'name': MyApp.selectedAnimal.Name,
          },
          child: Column(
            children: <Widget>[
              const SizedBox(height: 15),
              FormBuilderTextField(
                name: 'name',
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
                    MyApp.selectedAnimal.Name = value!;
                  }
                },
                validator: FormBuilderValidators.compose([
                  FormBuilderValidators.required(),
                  FormBuilderValidators.match('^[a-zA-Z -]+\$'),
                  FormBuilderValidators.maxLength(40),
                ]),
                keyboardType: TextInputType.name,
                textInputAction: TextInputAction.next,
              )
            ],
          )),
      Row(
        children: <Widget>[
          Expanded(
            child: ElevatedButton(
              onPressed: () {
                if (_animalFormKey.currentState?.saveAndValidate() ?? false) {
                  debugPrint(_animalFormKey.currentState?.value.toString());
                  Navigator.of(ctx).maybePop();
                } else {
                  debugPrint(_animalFormKey.currentState?.value.toString());
                  debugPrint('validation failed');
                }
              },
              child: const Text(
                'Save',
                style: TextStyle(color: Colors.white),
              ),
            ),
          ),
        ],
      )
    ])));
  }
}
