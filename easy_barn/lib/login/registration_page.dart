import 'package:easy_barn/login/log_in_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';

class RegistrationPage extends StatefulWidget {
  const RegistrationPage({super.key});

  @override
  State<RegistrationPage> createState() => _RegistrationPage();
}

class _RegistrationPage extends State<RegistrationPage> {
  final _registrationFormKey = GlobalKey<FormBuilderState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FormBuilder(
        key: _registrationFormKey,
        child: Padding(
          padding: EdgeInsets.all(20.0),
          child: Center(
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(
                    'Create an Account',
                    style: TextStyle(
                      fontSize: 30.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 30.0),
                  FormBuilderTextField(
                    name: 'full_name',
                    decoration: InputDecoration(
                      hintText: 'Enter your full name',
                      labelText: 'Full Name',
                      border: OutlineInputBorder(),
                    ),
                    validator: FormBuilderValidators.required(),
                  ),
                  SizedBox(height: 20.0),
                  FormBuilderTextField(
                    name: 'phone_number',
                    decoration: InputDecoration(
                      hintText: 'Enter your phone number',
                      labelText: 'Phone Number',
                      border: OutlineInputBorder(),
                    ),
                    validator: FormBuilderValidators.required(),
                  ),
                  SizedBox(height: 20.0),
                  FormBuilderTextField(
                    name: 'emergency_contact',
                    decoration: InputDecoration(
                      hintText: 'Enter your emergency contact',
                      labelText: 'Emergency Contact Name',
                      border: OutlineInputBorder(),
                    ),
                    validator: FormBuilderValidators.required(),
                  ),
                  SizedBox(height: 20.0),
                  FormBuilderTextField(
                    name: 'emergency_contact_phone',
                    decoration: InputDecoration(
                      hintText: 'Enter your emergency contact\'s phone number',
                      labelText: 'Emergency Contact\'s Phone Number',
                      border: OutlineInputBorder(),
                    ),
                    validator: FormBuilderValidators.required(),
                  ),
                  SizedBox(height: 20.0),
                  FormBuilderTextField(
                    name: 'email',
                    decoration: InputDecoration(
                      hintText: 'Enter your email',
                      labelText: 'Email',
                      border: OutlineInputBorder(),
                    ),
                    validator: FormBuilderValidators.compose([
                      FormBuilderValidators.required(),
                      FormBuilderValidators.email(),
                    ]),
                  ),
                  SizedBox(height: 20.0),
                  FormBuilderTextField(
                    name: 'password',
                    obscureText: true,
                    decoration: InputDecoration(
                      hintText: 'Enter your password',
                      labelText: 'Password',
                      border: OutlineInputBorder(),
                    ),
                    validator: FormBuilderValidators.compose([
                      FormBuilderValidators.required(),
                      FormBuilderValidators.minLength(6),
                    ]),
                  ),
                  SizedBox(height: 20.0),
                  FormBuilderTextField(
                    name: 'confirm_password',
                    obscureText: true,
                    decoration: InputDecoration(
                      hintText: 'Re-enter your password',
                      labelText: 'Confirm Password',
                      border: OutlineInputBorder(),
                    ),
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
                  ),
                  SizedBox(height: 30.0),
                  ElevatedButton(
                    onPressed: () {
                      if (_registrationFormKey.currentState!
                          .saveAndValidate()) {
                        // Implement registration functionality here
                        print(_registrationFormKey.currentState!.value);
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue,
                      foregroundColor: Colors.white,
                      padding: EdgeInsets.symmetric(horizontal: 80.0),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                    ),
                    child: Text('Register'),
                  ),
                  SizedBox(height: 20.0),
                  GestureDetector(
                    onTap: () {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(builder: (context) => LoginPage()),
                      );
                    },
                    child: Text(
                      'Already have an account? Login here',
                      style: TextStyle(
                        color: Colors.blue,
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
}
