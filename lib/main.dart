import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Piga Luku Admin Dashboard',
      theme: ThemeData(
        primarySwatch: Colors.purple
      ),
      home: const MyHomePage(title: 'Piga Luku Admin Dashboard'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  final _formKey = GlobalKey<FormState>();


  @override
  Widget build(BuildContext context) {



    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: Text(
          widget.title,
          style: const TextStyle(
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
          child: Container(
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
                            child: Image.asset("images/pigaluku_logo.png"),
                            height: 100,
                            width: 100,
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
                                  print("Validated form!!");
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
}
