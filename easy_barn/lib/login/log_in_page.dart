import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:easy_barn/barn_class.dart';
import 'package:easy_barn/barns_list_page.dart';
import 'package:easy_barn/login/forgot_password.dart';
import 'package:easy_barn/login/registration_page.dart';
import 'package:easy_barn/main.dart';
import 'package:easy_barn/person_class.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_fonts/google_fonts.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPage();
}

class _LoginPage extends State<LoginPage> {
  final _loginFormKey = GlobalKey<FormBuilderState>();

  bool _emailHasError = false;
  bool _passwordHasError = false;

  String email = "";
  String password = "";
  String userUid = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      decoration: const BoxDecoration(
          image: DecorationImage(
              image: AssetImage('assets/images/pexels-anna-alexes-8009841.jpg'),
              fit: BoxFit.cover,
              opacity: 0.25)),
      child: FormBuilder(
        key: _loginFormKey,
        child: Padding(
          padding: EdgeInsets.all(20.0),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text('EasyBarn',
                    style: GoogleFonts.bitter(
                        textStyle: const TextStyle(
                            color: Color.fromARGB(255, 51, 91, 122),
                            fontSize: 40,
                            fontWeight: FontWeight.w600))),
                Text('Welcome Back!',
                    style: GoogleFonts.bitter(
                        textStyle: const TextStyle(
                            color: Color.fromARGB(255, 51, 91, 122),
                            fontSize: 20,
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
                      _emailHasError = !(_loginFormKey
                              .currentState?.fields['email']
                              ?.validate() ??
                          false);
                    });
                    if (!_emailHasError) {
                      email = value!;
                    }
                  },
                ),
                SizedBox(height: 20.0),
                FormBuilderTextField(
                  name: 'password',
                  obscureText: true,
                  decoration: InputDecoration(
                      hintText: 'Enter your password',
                      labelText: 'Password',
                      suffixIcon: _passwordHasError
                          ? const Icon(Icons.error, color: Colors.red)
                          : const Icon(Icons.check, color: Colors.green)),
                  validator: FormBuilderValidators.compose([
                    FormBuilderValidators.required(),
                    FormBuilderValidators.match('^[a-zA-Z0-9 \.\$#!\-]+\$'),
                    FormBuilderValidators.minLength(6),
                  ]),
                  onChanged: (value) {
                    setState(() {
                      _passwordHasError = !(_loginFormKey
                              .currentState?.fields['password']
                              ?.validate() ??
                          false);
                    });
                    if (!_passwordHasError) {
                      password = value!;
                    }
                  },
                ),
                SizedBox(height: 30.0),
                ElevatedButton(
                  onPressed: () async {
                    if (_loginFormKey.currentState!.saveAndValidate()) {
                      // Implement login functionality here
                      try {
                        final credential = await FirebaseAuth.instance
                            .signInWithEmailAndPassword(
                                email: email, // test.user@gmail.com
                                password: password); //123password!!

                        userUid = credential.user!.uid;

                        Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (context) => buildBarnPage(userUid)));
                      } on PlatformException catch (e) {
                        setState(() {});
                        _emailHasError = true;
                        _passwordHasError = true;
                      } on FirebaseAuthException catch (e) {
                        setState(() {});
                        _emailHasError = true;
                        _passwordHasError = true;
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
                  child: Text('Login'),
                ),
                SizedBox(height: 20.0),
                GestureDetector(
                  onTap: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (context) => RegistrationPage()),
                    );
                  },
                  child: const Text(
                    'Don\'t have an account? Register here',
                    style: TextStyle(
                      color: Color.fromARGB(255, 51, 91, 122),
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                SizedBox(height: 10.0),
                GestureDetector(
                  onTap: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (context) => ForgotPasswordPage()),
                    );
                  },
                  child: const Text(
                    'Forgot password? Update here',
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
    ));
  }

  Widget buildBarnPage(String uid) {
    return FutureBuilder<List<Barn>>(
        future: getBarnsFromDatabase(uid),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Container(
              decoration: const BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage(
                          'assets/images/pexels-brandon-randolph-2042161.jpg'),
                      fit: BoxFit.cover,
                      opacity: 0.5)),
              child: const Center(
                child: CircularProgressIndicator(
                  color: Color.fromARGB(255, 51, 91, 122),
                ),
              ),
            );
          } else if (!(snapshot.data == null)) {
            MyApp.barnList = snapshot.data!;
            return const BarnList();
          } else {
            return Text('Error: ${snapshot.error}');
          }
        });
  }

  Future<List<Barn>> getBarnsFromDatabase(String uid) async {
    List<Barn> barns = [];

    QuerySnapshot peopleQs = await FirebaseFirestore.instance
        .collection('people')
        .where('uid', isEqualTo: uid)
        .get();
    DocumentReference userRef = peopleQs.docs.first.reference;

    DocumentSnapshot userInfo = await userRef.get();
    Map<String, dynamic> user = userInfo.data() as Map<String, dynamic>;

    MyApp.currentUser = Person(
        id: userInfo.id,
        name: user['name'] ?? '',
        phoneNumber: user['number'] ?? '',
        emergencyPerson: user['emergencyPerson'] ?? '',
        emergencyNumber: user['emergencyNumber'] ?? '',
        uid: user['uid'] ?? '');

    QuerySnapshot barnRefQs = await FirebaseFirestore.instance
        .collection('barn_to_person')
        .where('personid', isEqualTo: userRef)
        .get();

    for (DocumentSnapshot doc in barnRefQs.docs) {
      //get refernce to the barn the user is a part of
      DocumentReference barnRef = doc.get('barnid');

      // get the barn document
      DocumentSnapshot barnDoc = await barnRef.get();

      Barn barn =
          Barn(id: "", address: "", name: "", ownerid: "", phoneNumber: "");

      barn.id = barnDoc.id;

      Map<String, dynamic> item = barnDoc.data() as Map<String, dynamic>;
      barn.name = item['name'] ?? '';
      barn.address = item['address'] ?? '';
      barn.phoneNumber = item['number'] ?? '';
      barn.ownerid = await getBarnOwner(item['owner']);

      barns.add(barn);
    }

    MyApp.barnList = barns;

    return barns;
  }

  Future<String> getBarnOwner(DocumentReference ownerRef) async {
    DocumentSnapshot ownerSnapshot = await ownerRef.get();
    if (ownerSnapshot.exists) {
      return ownerSnapshot.id;
    } else {
      return '';
    }
  }
}
