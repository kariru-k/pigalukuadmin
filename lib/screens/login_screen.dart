import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:progress_dialog_null_safe/progress_dialog_null_safe.dart';

import '../secrets.dart';
import '../services/firebase_services.dart';
import 'home_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});


  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  static final configurations = Configurations();



  final Future<FirebaseApp> _initialization = Firebase.initializeApp(
      options: FirebaseOptions(
          apiKey: configurations.apiKey,
          appId: configurations.appId,
          messagingSenderId: configurations.messagingSenderId,
          projectId: configurations.projectId
      )
  );


  final _formKey = GlobalKey<FormState>();

  final FirebaseServices _services = FirebaseServices();
  String? username;
  String? password;





  @override
  Widget build(BuildContext context) {

    ProgressDialog progressDialog = ProgressDialog(
      context,
    );

    Future<void>login() async{
      progressDialog.show();
      _services.getAdminCredentials().then((value) async {
        for (var element in value.docs) {
          if (element.get("username") == username){
            if (element.get("password") == password) {
              UserCredential userCredential = await FirebaseAuth.instance.signInAnonymously();
              progressDialog.hide();
              if(userCredential.user?.uid != null) {
                Navigator.pushReplacement(context, MaterialPageRoute(builder: (BuildContext context) => const HomeScreen()));
                return;
              } else {
                _showMyDialog(
                    title: "Login",
                    message: "Login failed"
                );
              }
            } else {
              progressDialog.hide();
              _showMyDialog(
                  title: "Password is incorrect",
                  message: "The password you have entered is incorrect. Please try again"
              );
            }
          } else {
            progressDialog.hide();
            _showMyDialog(
                title: "Invalid username",
                message: "The username you have entered is invalid. Please try again"
            );
          }
        }
      });
    }



    return Scaffold(
        appBar: AppBar(
          elevation: 0,
          title: const Text(
            "Piga Luku",
            style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.white
            ),
          ),
          centerTitle: true,
        ),
        body: Container(
          decoration: const BoxDecoration(
              gradient: LinearGradient(
                  colors: [
                    Colors.purple,
                    Colors.white
                  ],
                  begin: Alignment.topCenter,
                  end: Alignment(0.0, 0.0),
                  stops: [1.0, 1.0]
              )
          ),
          child: Center(
            child: SizedBox(
              width: 400,
              height: 500,
              child: Card(
                shape: Border.all(
                    color: Colors.deepPurple,
                    width: 2
                ),
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Column(
                          children: [
                            SizedBox(
                              height: 100,
                              width: 100,
                              child: Image.asset("images/pigaluku_logo.png"),
                            ),
                            const SizedBox(height: 10,),
                            const Text(
                              "Login To The Admin Panel",
                              style: TextStyle(
                                  fontWeight: FontWeight.w800,
                                  fontSize: 18,
                                  color: Colors.black
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: TextFormField(
                                validator: (value){
                                  if(value!.isEmpty){
                                    return "Please enter your username";
                                  }
                                  setState(() {
                                    username = value;
                                  });
                                  return null;
                                },
                                decoration: InputDecoration(
                                    hintText: "Username",
                                    labelText: "Username",
                                    prefixIcon: const Icon(Icons.person),
                                    focusColor: Theme.of(context).primaryColor,
                                    contentPadding: const EdgeInsets.only(left: 10.0, right: 10.0),
                                    border: const OutlineInputBorder(),
                                    focusedBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                            color: Theme.of(context).primaryColor
                                        )
                                    )
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: TextFormField(
                                validator: (value){
                                  if(value!.isEmpty){
                                    return "Please enter your password";
                                  }
                                  if (value.length < 6) {
                                    return "Your password is too short. Minimum 6 characters";
                                  }
                                  setState(() {
                                    password = value;
                                  });
                                  return null;
                                },
                                obscureText: true,
                                decoration: InputDecoration(
                                    hintText: "Password",
                                    labelText: "Password",
                                    prefixIcon: const Icon(Icons.vpn_key_sharp),
                                    focusColor: Theme.of(context).primaryColor,
                                    contentPadding: const EdgeInsets.only(left: 10.0, right: 10.0),
                                    border: const OutlineInputBorder(),
                                    focusedBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                            color: Theme.of(context).primaryColor
                                        )
                                    )
                                ),
                              ),
                            ),
                            ElevatedButton(
                                onPressed: () {
                                  if (_formKey.currentState!.validate()) {
                                    login();
                                  }
                                },
                                child: const Text("Login")
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        )
    );
  }

  Future<void> _showMyDialog({title, message}) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(title),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text(message),
                const Text("Please try again")
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('OK'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}
