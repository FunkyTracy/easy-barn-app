import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:easy_barn/barn_class.dart';
import 'package:easy_barn/barns_list_page.dart';
import 'package:easy_barn/firebase_options.dart';
import 'package:easy_barn/login/registration_page.dart';
import 'package:easy_barn/main.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPage();
}

class _LoginPage extends State<LoginPage> {
  final _loginFormKey = GlobalKey<FormBuilderState>();

  @override
  Widget build(BuildContext context) {
    initializeFirebase();

    return Scaffold(
      body: FormBuilder(
        key: _loginFormKey,
        child: Padding(
          padding: EdgeInsets.all(20.0),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  'Welcome Back!',
                  style: TextStyle(
                    fontSize: 30.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 30.0),
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
                SizedBox(height: 30.0),
                ElevatedButton(
                  onPressed: () async {
                    if (_loginFormKey.currentState!.saveAndValidate()) {
                      // Implement login functionality here
                      Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (context) => buildBarnPage()));
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
                  child: Text(
                    'Don\'t have an account? Register here',
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
    );
  }

  Future<void> initializeFirebase() async {
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
  }

  Widget buildBarnPage() {
    return FutureBuilder<List<Barn>>(
        future: getBarnsFromDatabase(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return CircularProgressIndicator();
          } else if (!(snapshot.data == null)) {
            MyApp.barnList = snapshot.data!;
            return const BarnList();
          } else {
            return Text('Error: ${snapshot.error}');
          }
        });
  }

  Future<List<Barn>> getBarnsFromDatabase() async {
    List<Barn> barns = [];

    QuerySnapshot qs =
        await FirebaseFirestore.instance.collection('barns').get();

    for (QueryDocumentSnapshot barnDoc in qs.docs) {
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
