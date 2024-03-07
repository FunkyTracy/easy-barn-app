import 'package:easy_barn/login/log_in_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:google_fonts/google_fonts.dart';

class ForgotPasswordPage extends StatefulWidget {
  const ForgotPasswordPage({super.key});

  @override
  State<ForgotPasswordPage> createState() => _ForgotPasswordPage();
}

class _ForgotPasswordPage extends State<ForgotPasswordPage> {
  final _forgotFormKey = GlobalKey<FormBuilderState>();

  bool _emailHasError = false;
  String email = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: FormBuilder(
            key: _forgotFormKey,
            child: Padding(
                padding: EdgeInsets.all(20.0),
                child: Center(
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                      Text('Forgot Password',
                          style: GoogleFonts.bitter(
                              textStyle: const TextStyle(
                                  color: Color.fromARGB(255, 51, 91, 122),
                                  fontSize: 28,
                                  fontWeight: FontWeight.w600))),
                      const SizedBox(height: 30.0),
                      FormBuilderTextField(
                        name: 'email',
                        decoration: InputDecoration(
                            hintText: 'Enter your email',
                            labelText: 'Email',
                            suffixIcon: _emailHasError
                                ? const Icon(Icons.error, color: Colors.red)
                                : const Icon(Icons.check, color: Colors.green)),
                        validator: FormBuilderValidators.compose([
                          FormBuilderValidators.required(),
                          FormBuilderValidators.email(),
                        ]),
                        onChanged: (value) {
                          setState(() {
                            _emailHasError = !(_forgotFormKey
                                    .currentState?.fields['email']
                                    ?.validate() ??
                                false);
                          });
                          if (!_emailHasError) {
                            email = value!;
                          }
                        },
                      ),
                      SizedBox(height: 30.0),
                      ElevatedButton(
                          onPressed: () async {
                            if (_forgotFormKey.currentState!
                                .saveAndValidate()) {
                              try {
                                final status = await FirebaseAuth.instance
                                    .sendPasswordResetEmail(email: email);
                                Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => LoginPage()),
                                );
                              } on PlatformException catch (e) {
                                Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => LoginPage()),
                                );
                              } on FirebaseAuthException catch (e) {
                                Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => LoginPage()),
                                );
                              }
                            }
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Color.fromARGB(255, 51, 91, 122),
                            foregroundColor: Colors.white,
                            padding: EdgeInsets.symmetric(horizontal: 80.0),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20.0),
                            ),
                          ),
                          child: Text('Send Update Password Link'))
                    ])))));
  }
}
