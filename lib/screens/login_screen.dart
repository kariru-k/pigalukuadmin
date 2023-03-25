import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:progress_dialog_null_safe/progress_dialog_null_safe.dart';

import '../secrets.dart';
import '../services/firebase_services.dart';
import 'home_screen.dart';

class LoginScreen extends StatefulWidget {
  static const String id = "login-screen";
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
          storageBucket: configurations.storageBucket,
          projectId: configurations.projectId,
      )
  );
  final _formKey = GlobalKey<FormState>();
  final FirebaseServices _services = FirebaseServices();
  final _usernameTextController = TextEditingController();
  final _passwordTextController = TextEditingController();





  @override
  Widget build(BuildContext context) {

    ProgressDialog progressDialog = ProgressDialog(
      context,
    );

    _login({username, password}) async{
      progressDialog.show();
      _services.getAdminCredentials(username).then((value) async{
        if(value.exists){
          if(value["username"] == username){
            if(value["password"] == password){
              try{
                UserCredential? userCredential = await FirebaseAuth.instance.signInAnonymously();
                if (userCredential.user?.uid != null) {
                  progressDialog.hide();
                  Navigator.pushReplacementNamed(context, HomeScreen.id);
                }
              } catch (e) {
                progressDialog.hide();
                _services.showMyDialog(
                    title: "Login",
                    context: context,
                    message: e.toString(),
                );
              }
              return;
            } else {
              progressDialog.hide();
              _services.showMyDialog(
                  title: "Incorrect password",
                  message: "The password you have entered is incorrect",
                  context: context
              );
              return;
            }
          }
          else {
            progressDialog.hide();
            _services.showMyDialog(
                title: "Invalid username",
                message: "The username you have entered is incorrect",
                context: context
            );
          }
        } else {
          progressDialog.hide();
          _services.showMyDialog(
            title: "Login",
            message: "Can't log in",
            context: context
          );
        }
      });
    }


    return Scaffold(
        appBar: AppBar(
          elevation: 0,
          title: const Text(
            "Piga Luku Admin Dashboard",
            style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.white
            ),
          ),
          centerTitle: true,
        ),
        body: FutureBuilder(
          future: _initialization,
          builder: (context, snapshot) {

            if(snapshot.hasError){
              return const Center(
                child: Text("Connection failed"),
              );
            }

            if (snapshot.connectionState == ConnectionState.done) {
              return Container(
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
                                      controller: _usernameTextController,
                                      validator: (value){
                                        if(value!.isEmpty){
                                          return "Please enter your username";
                                        }
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
                                      controller: _passwordTextController,
                                      validator: (value){
                                        if(value!.isEmpty){
                                          return "Please enter your password";
                                        }
                                        if (value.length < 6) {
                                          return "Your password is too short. Minimum 6 characters";
                                        }
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
                                          _login(
                                            username: _usernameTextController.text,
                                            password: _passwordTextController.text
                                          );
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
              );
            }

            return const Center(
              child: CircularProgressIndicator(),
            );


          }
        )
    );
  }
}
