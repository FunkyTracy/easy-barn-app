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

  bool _nameHasError = false;
  bool _ownerNameHasError = false;
  bool _descriptionHasError = false;
  bool _stallLocationHasError = false;
  bool _feedingHasError = false;
  bool _medicationHasError = false;
  bool _vetHasError = false;
  bool _farrierHasError = false;

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
            'owner': MyApp.selectedAnimal.Owner,
            'description': MyApp.selectedAnimal.Description,
            'stall_location': MyApp.selectedAnimal.Stall,
            'feeding': MyApp.selectedAnimal.FeedingInstructions,
            'meds': MyApp.selectedAnimal.Medications,
            'vet': MyApp.selectedAnimal.Vet,
            'farrier': MyApp.selectedAnimal.Farrier
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
              ),
              FormBuilderTextField(
                name: 'owner',
                autovalidateMode: AutovalidateMode.always,
                decoration: InputDecoration(
                    labelText: 'Owner Name',
                    suffixIcon: _ownerNameHasError
                        ? const Icon(Icons.error, color: Colors.red)
                        : const Icon(Icons.check, color: Colors.green)),
                onChanged: (value) {
                  setState(() {
                    _ownerNameHasError = !(_animalFormKey
                            .currentState?.fields['owner']
                            ?.validate() ??
                        false);
                  });
                  if (!_ownerNameHasError) {
                    MyApp.selectedAnimal.Owner = value!;
                  }
                },
                validator: FormBuilderValidators.compose([
                  FormBuilderValidators.required(),
                  FormBuilderValidators.match('^[a-zA-Z -]+\$'),
                  FormBuilderValidators.maxLength(40),
                ]),
                keyboardType: TextInputType.name,
                textInputAction: TextInputAction.next,
              ),
              FormBuilderTextField(
                name: 'description',
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
                    MyApp.selectedAnimal.Description = value!;
                  }
                },
                validator: FormBuilderValidators.compose([
                  FormBuilderValidators.required(),
                  FormBuilderValidators.match('^[a-zA-Z0-9 \n\t-(),\.]+\$'),
                  FormBuilderValidators.maxLength(100),
                ]),
                keyboardType: TextInputType.multiline,
                textInputAction: TextInputAction.next,
              ),
              FormBuilderTextField(
                name: 'stall_location',
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
                    MyApp.selectedAnimal.Stall = value!;
                  }
                },
                validator: FormBuilderValidators.compose([
                  FormBuilderValidators.required(),
                  FormBuilderValidators.match('^[a-zA-Z0-9 \n\t-(),\.]+\$'),
                  FormBuilderValidators.maxLength(100),
                ]),
                keyboardType: TextInputType.multiline,
                textInputAction: TextInputAction.next,
              ),
              FormBuilderTextField(
                name: 'feeding',
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
                    MyApp.selectedAnimal.FeedingInstructions = value!;
                  }
                },
                validator: FormBuilderValidators.compose([
                  FormBuilderValidators.required(),
                  FormBuilderValidators.match('^[a-zA-Z0-9 \n\t-(),\.]+\$'),
                  FormBuilderValidators.maxLength(100),
                ]),
                keyboardType: TextInputType.multiline,
                textInputAction: TextInputAction.next,
              ),
              FormBuilderTextField(
                name: 'meds',
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
                    MyApp.selectedAnimal.Medications = value!;
                  }
                },
                validator: FormBuilderValidators.compose([
                  FormBuilderValidators.required(),
                  FormBuilderValidators.match('^[a-zA-Z0-9 \n\t-(),\.]+\$'),
                  FormBuilderValidators.maxLength(100),
                ]),
                keyboardType: TextInputType.multiline,
                textInputAction: TextInputAction.next,
              ),
              FormBuilderTextField(
                name: 'vet',
                autovalidateMode: AutovalidateMode.always,
                decoration: InputDecoration(
                    labelText: 'Veterinarian',
                    suffixIcon: _vetHasError
                        ? const Icon(Icons.error, color: Colors.red)
                        : const Icon(Icons.check, color: Colors.green)),
                onChanged: (value) {
                  setState(() {
                    _vetHasError = !(_animalFormKey.currentState?.fields['vet']
                            ?.validate() ??
                        false);
                  });
                  if (!_vetHasError) {
                    MyApp.selectedAnimal.Vet = value!;
                  }
                },
                validator: FormBuilderValidators.compose([
                  FormBuilderValidators.required(),
                  FormBuilderValidators.match('^[a-zA-Z0-9 \n\t-(),\.]+\$'),
                  FormBuilderValidators.maxLength(50),
                ]),
                keyboardType: TextInputType.multiline,
                textInputAction: TextInputAction.next,
              ),
              FormBuilderTextField(
                name: 'farrier',
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
                    MyApp.selectedAnimal.Farrier = value!;
                  }
                },
                validator: FormBuilderValidators.compose([
                  FormBuilderValidators.required(),
                  FormBuilderValidators.match('^[a-zA-Z0-9 \n\t-(),\.]+\$'),
                  FormBuilderValidators.maxLength(50),
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
                style: TextStyle(color: Color.fromARGB(255, 37, 109, 168)),
              ),
            ),
          ),
        ],
      )
    ])));
  }
}
