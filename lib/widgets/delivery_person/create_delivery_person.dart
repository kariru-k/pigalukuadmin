import 'package:flutter/material.dart';

import '../../services/firebase_services.dart';

class CreateNewDeliveryPersonWidget extends StatefulWidget {
  const CreateNewDeliveryPersonWidget({Key? key}) : super(key: key);

  @override
  State<CreateNewDeliveryPersonWidget> createState() => _CreateNewDeliveryPersonWidgetState();
}

class _CreateNewDeliveryPersonWidgetState extends State<CreateNewDeliveryPersonWidget> {
  var emailText = TextEditingController();
  var nameText = TextEditingController();
  var passwordText = TextEditingController();
  var phoneNumberText = TextEditingController();
  FirebaseServices services = FirebaseServices();

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: SizedBox(
            child: Padding(
              padding: const EdgeInsets.only(left: 30),
              child: Column(
                children: [
                  TextFormField(
                    controller: nameText,
                    decoration: InputDecoration(
                      enabledBorder: const OutlineInputBorder(),
                      focusColor: Theme.of(context).primaryColor,
                      errorBorder: const OutlineInputBorder(
                        borderSide: BorderSide(
                            style: BorderStyle.solid,
                            width: 2,
                            color: Colors.redAccent
                        ),
                      ),
                      focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5.0),
                          borderSide: BorderSide(
                              style: BorderStyle.solid,
                              width: 2,
                              color: Theme.of(context).primaryColor
                          )
                      ),
                      contentPadding: EdgeInsets.zero,
                      filled: true,
                      fillColor: Colors.white,
                      hintText: "Email ID",
                      prefixIcon: const Icon(Icons.email_sharp),
                    ),
                  ),
                  const SizedBox(height: 20,),
                  TextFormField(
                    controller: emailText,
                    decoration: InputDecoration(
                      enabledBorder: const OutlineInputBorder(),
                      focusColor: Theme.of(context).primaryColor,
                      errorBorder: const OutlineInputBorder(
                        borderSide: BorderSide(
                            style: BorderStyle.solid,
                            width: 2,
                            color: Colors.redAccent
                        ),
                      ),
                      focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5.0),
                          borderSide: BorderSide(
                              style: BorderStyle.solid,
                              width: 2,
                              color: Theme.of(context).primaryColor
                          )
                      ),
                      contentPadding: EdgeInsets.zero,
                      filled: true,
                      fillColor: Colors.white,
                      hintText: "Email ID",
                      prefixIcon: const Icon(Icons.email_sharp),
                    ),
                  ),
                  const SizedBox(height: 20,),
                  TextFormField(
                    controller: phoneNumberText,
                    decoration: InputDecoration(
                      enabledBorder: const OutlineInputBorder(),
                      focusColor: Theme.of(context).primaryColor,
                      errorBorder: const OutlineInputBorder(
                        borderSide: BorderSide(
                            style: BorderStyle.solid,
                            width: 2,
                            color: Colors.redAccent
                        ),
                      ),
                      focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5.0),
                          borderSide: BorderSide(
                              style: BorderStyle.solid,
                              width: 2,
                              color: Theme.of(context).primaryColor
                          )
                      ),
                      contentPadding: EdgeInsets.zero,
                      filled: true,
                      fillColor: Colors.white,
                      hintText: "Phone Number",
                      prefixIcon: const Icon(Icons.phone),
                      prefixText: "+254",
                    ),
                    maxLength: 9,
                  ),
                  const SizedBox(height: 20,),
                  TextFormField(
                    controller: passwordText,
                    decoration: InputDecoration(
                      enabledBorder: const OutlineInputBorder(),
                      focusColor: Theme.of(context).primaryColor,
                      errorBorder: const OutlineInputBorder(
                        borderSide: BorderSide(
                            style: BorderStyle.solid,
                            width: 2,
                            color: Colors.redAccent
                        ),
                      ),
                      focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5.0),
                          borderSide: BorderSide(
                              style: BorderStyle.solid,
                              width: 2,
                              color: Theme.of(context).primaryColor
                          )
                      ),
                      contentPadding: EdgeInsets.zero,
                      filled: true,
                      fillColor: Colors.white,
                      hintText: "Password",
                      prefixIcon: const Icon(Icons.vpn_key_outlined),
                    ),
                  ),
                  const SizedBox(height: 20,),
                  ElevatedButton(
                      onPressed: (){
                        if (emailText.text.isEmpty) {
                          services.showMyDialog(
                              context: context,
                              title: "Email Not Entered",
                              message: "Please Enter an email address"
                          );
                        }
                        if (passwordText.text.isEmpty) {
                          services.showMyDialog(
                              context: context,
                              title: "Password Not Entered",
                              message: "Please Enter A password"
                          );
                        }
                        if (passwordText.text.length < 6) {
                          services.showMyDialog(
                              context: context,
                              title: "Password Not Long Enough",
                              message: "Please Enter A password that is greater than 6 characters"
                          );
                        }
                      },
                      child: const Text("Save")
                  )
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
