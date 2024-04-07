// ignore_for_file: unnecessary_string_escapes, use_build_context_synchronously, avoid_print

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:easy_barn/login/log_in_page.dart';
import 'package:easy_barn/person_pages/person_class.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:google_fonts/google_fonts.dart';

class RegistrationPage extends StatefulWidget {
  const RegistrationPage({super.key});

  @override
  State<RegistrationPage> createState() => _RegistrationPage();
}

class _RegistrationPage extends State<RegistrationPage> {
  final _registrationFormKey = GlobalKey<FormBuilderState>();

  Person newUser = Person(
      id: "",
      name: "",
      phoneNumber: "",
      emergencyPerson: "",
      emergencyNumber: "",
      uid: "");

  String email = "";
  String password = "";

  bool _fullNameHasError = false;
  bool _phoneNumberHasError = false;
  bool _emergencyPersonHasError = false;
  bool _emergencyPhoneHasError = false;
  bool _emailHasError = false;
  final bool _passwordHasError = false;
  bool _passwordConfirmationHasError = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FormBuilder(
        key: _registrationFormKey,
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Center(
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(
                    'Create an Account',
                    style: GoogleFonts.bitter(
                        textStyle: const TextStyle(
                            color: Color.fromARGB(255, 51, 91, 122),
                            fontSize: 35,
                            fontWeight: FontWeight.w600)),
                  ),
                  const SizedBox(height: 30.0),
                  FormBuilderTextField(
                    name: 'full_name',
                    decoration: InputDecoration(
                      hintText: 'Enter your full name',
                      labelText: 'Full Name',
                      border: const OutlineInputBorder(),
                      suffixIcon: _fullNameHasError
                          ? const Icon(Icons.error, color: Colors.red)
                          : const Icon(Icons.check, color: Colors.green),
                    ),
                    validator: FormBuilderValidators.compose([
                      FormBuilderValidators.required(),
                      FormBuilderValidators.match('^[a-zA-Z \-]+\$'),
                      FormBuilderValidators.maxLength(40),
                    ]),
                    onChanged: (value) {
                      setState(() {
                        _fullNameHasError = !(_registrationFormKey
                                .currentState?.fields['full_name']
                                ?.validate() ??
                            false);
                      });
                      if (!_fullNameHasError) {
                        newUser.name = value!;
                      }
                    },
                  ),
                  const SizedBox(height: 20.0),
                  FormBuilderTextField(
                    name: 'phone_number',
                    decoration: InputDecoration(
                        hintText: 'Enter your phone number',
                        labelText: 'Phone Number',
                        border: const OutlineInputBorder(),
                        suffixIcon: _phoneNumberHasError
                            ? const Icon(Icons.error, color: Colors.red)
                            : const Icon(Icons.check, color: Colors.green)),
                    validator: FormBuilderValidators.compose([
                      FormBuilderValidators.required(),
                      FormBuilderValidators.match(
                          '^[0-9]{3}[\-\. ]?[0-9]{3}[\-\. ]?[0-9]{4}\$'),
                      FormBuilderValidators.maxLength(12),
                    ]),
                    onChanged: (value) {
                      setState(() {
                        _phoneNumberHasError = !(_registrationFormKey
                                .currentState?.fields['phone_number']
                                ?.validate() ??
                            false);
                      });
                      if (!_phoneNumberHasError) {
                        newUser.phoneNumber = value!;
                      }
                    },
                  ),
                  const SizedBox(height: 20.0),
                  FormBuilderTextField(
                    name: 'emergency_contact',
                    decoration: InputDecoration(
                        hintText: 'Enter your emergency contact',
                        labelText: 'Emergency Contact Name',
                        border: const OutlineInputBorder(),
                        suffixIcon: _emergencyPersonHasError
                            ? const Icon(Icons.error, color: Colors.red)
                            : const Icon(Icons.check, color: Colors.green)),
                    validator: FormBuilderValidators.compose([
                      FormBuilderValidators.required(),
                      FormBuilderValidators.match('^[a-zA-Z \n\t\-]+\$'),
                      FormBuilderValidators.maxLength(30),
                    ]),
                    onChanged: (value) {
                      setState(() {
                        _emergencyPersonHasError = !(_registrationFormKey
                                .currentState?.fields['emergency_contact']
                                ?.validate() ??
                            false);
                      });
                      if (!_emergencyPersonHasError) {
                        newUser.emergencyPerson = value!;
                      }
                    },
                  ),
                  const SizedBox(height: 20.0),
                  FormBuilderTextField(
                    name: 'emergency_contact_phone',
                    decoration: InputDecoration(
                        hintText:
                            'Enter your emergency contact\'s phone number',
                        labelText: 'Emergency Contact\'s Phone Number',
                        border: const OutlineInputBorder(),
                        suffixIcon: _emergencyPhoneHasError
                            ? const Icon(Icons.error, color: Colors.red)
                            : const Icon(Icons.check, color: Colors.green)),
                    validator: FormBuilderValidators.compose([
                      FormBuilderValidators.required(),
                      FormBuilderValidators.match(
                          '^[0-9]{3}[\-\. ]?[0-9]{3}[\-\. ]?[0-9]{4}\$'),
                      FormBuilderValidators.maxLength(12),
                    ]),
                    onChanged: (value) {
                      setState(() {
                        _emergencyPhoneHasError = !(_registrationFormKey
                                .currentState?.fields['emergency_contact_phone']
                                ?.validate() ??
                            false);
                      });
                      if (!_emergencyPhoneHasError) {
                        newUser.emergencyNumber = value!;
                      }
                    },
                  ),
                  const SizedBox(height: 20.0),
                  FormBuilderTextField(
                    name: 'email',
                    decoration: InputDecoration(
                        hintText: 'Enter your email',
                        labelText: 'Email',
                        border: const OutlineInputBorder(),
                        suffixIcon: _emailHasError
                            ? const Icon(Icons.error, color: Colors.red)
                            : const Icon(Icons.check, color: Colors.green)),
                    validator: FormBuilderValidators.compose([
                      FormBuilderValidators.required(),
                      FormBuilderValidators.email(),
                    ]),
                    onChanged: (value) {
                      setState(() {
                        _emailHasError = !(_registrationFormKey
                                .currentState?.fields['email']
                                ?.validate() ??
                            false);
                      });
                      if (!_emailHasError) {
                        email = value!;
                      }
                    },
                  ),
                  const SizedBox(height: 20.0),
                  FormBuilderTextField(
                    name: 'password',
                    obscureText: true,
                    decoration: InputDecoration(
                        hintText: 'Enter your password',
                        labelText: 'Password',
                        border: const OutlineInputBorder(),
                        suffixIcon: _passwordHasError
                            ? const Icon(Icons.error, color: Colors.red)
                            : const Icon(Icons.check, color: Colors.green)),
                    validator: FormBuilderValidators.compose([
                      FormBuilderValidators.required(),
                      FormBuilderValidators.match('^[a-zA-Z0-9 \.\$#!\-]+\$'),
                      FormBuilderValidators.minLength(6),
                    ]),
                  ),
                  const SizedBox(height: 20.0),
                  FormBuilderTextField(
                    name: 'confirm_password',
                    obscureText: true,
                    decoration: InputDecoration(
                        hintText: 'Re-enter your password',
                        labelText: 'Confirm Password',
                        border: const OutlineInputBorder(),
                        suffixIcon: _passwordConfirmationHasError
                            ? const Icon(Icons.error, color: Colors.red)
                            : const Icon(Icons.check, color: Colors.green)),
                    validator: FormBuilderValidators.compose([
                      FormBuilderValidators.required(),
                      (val) {
                        if (val !=
                            _registrationFormKey
                                .currentState!.fields['password']!.value!) {
                          return 'Passwords do not match';
                        }
                        return null;
                      },
                    ]),
                    onChanged: (value) {
                      setState(() {
                        _passwordConfirmationHasError = !(_registrationFormKey
                                .currentState?.fields['confirm_password']
                                ?.validate() ??
                            false);
                      });
                      if (!_passwordConfirmationHasError) {
                        password = value!;
                      }
                    },
                  ),
                  const SizedBox(height: 30.0),
                  ElevatedButton(
                    onPressed: () async {
                      if (_registrationFormKey.currentState!
                          .saveAndValidate()) {
                        // Implement registration functionality here
                        await registerUser();

                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const LoginPage()),
                        );
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color.fromARGB(255, 51, 91, 122),
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(horizontal: 80.0),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                    ),
                    child: const Text('Register'),
                  ),
                  const SizedBox(height: 20.0),
                  GestureDetector(
                    onTap: () {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const LoginPage()),
                      );
                    },
                    child: const Text(
                      'Already have an account? Login here',
                      style: TextStyle(
                        color: Color.fromARGB(255, 51, 91, 122),
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future<void> registerUser() async {
    try {
      UserCredential userCredential =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      // User registration successful
      newUser.uid = userCredential.user!.uid;

      DocumentReference doc = await FirebaseFirestore.instance
          .collection('people')
          .add(newUser.toMap());

      newUser.id = doc.id;
    } catch (e) {
      // User registration failed
      print('Failed to register user: $e');
      // Handle error
    }
  }
}
