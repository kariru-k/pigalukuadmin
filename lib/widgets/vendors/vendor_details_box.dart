import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pigalukuadmin/services/firebase_services.dart';

class VendorDetailsBox extends StatefulWidget {
  const VendorDetailsBox({Key? key, required this.uid}) : super(key: key);

  final String uid;


  @override
  State<VendorDetailsBox> createState() => _VendorDetailsBoxState();
}

class _VendorDetailsBoxState extends State<VendorDetailsBox> {
  final FirebaseServices _services = FirebaseServices();


  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _services.vendors.doc(widget.uid).get(),
      builder: (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
        if(snapshot.hasError){
          return const Center(
            child: Text("Something went wrong"),
          );
        }

        if(snapshot.connectionState == ConnectionState.waiting){
          return const Center(
            child: CircularProgressIndicator(),
          );
        }

        return Dialog(
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: Stack(
              children: [
                SizedBox(
                  height: MediaQuery.of(context).size.height,
                  width: MediaQuery.of(context).size.width * .7,
                  child: ListView(
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Expanded(
                            child: SizedBox(
                              height: 100,
                              width: 100,
                              child: ClipRRect(
                                  borderRadius: BorderRadius.circular(5),
                                  child: Image.network(
                                      snapshot.data!['url'],
                                      fit: BoxFit.cover)),
                            ),
                          ),
                          const SizedBox(
                            width: 20,
                          ),
                          Expanded(
                            child: Column(
                              children: [
                                Expanded(
                                  flex: 0,
                                  child: Text(
                                    snapshot.data!['shopName'],
                                    style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 25
                                    ),
                                  ),
                                ),
                                Expanded(
                                    flex: 0,
                                    child: Text(snapshot.data!['description']))
                              ],
                            ),
                          )
                        ],
                      ),
                      const Divider(thickness: 4,),
                      Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(5),
                            child: Expanded(
                              flex: 0,
                              child: Row(
                                children: [
                                  const Expanded(
                                    flex: 0,
                                    child: Text(
                                      "Contact Number",
                                    ),
                                  ),
                                  const Expanded(
                                    flex: 0,
                                    child: Padding(
                                      padding: EdgeInsets.only(left: 10, right: 10),
                                      child: Text(":"),
                                    ),
                                  ),
                                  Expanded(
                                    flex: 0,
                                    child: Text("0" + snapshot.data!["storePhoneNumber"]),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(5),
                            child: Expanded(
                              flex: 0,
                              child: Row(
                                children: [
                                  const Expanded(
                                    flex: 0,
                                    child: Text(
                                      "Email Address",
                                    ),
                                  ),
                                  const Expanded(
                                    flex: 0,
                                    child: Padding(
                                      padding: EdgeInsets.only(left: 10, right: 10),
                                      child: Text(":"),
                                    ),
                                  ),
                                  Expanded(
                                    flex: 0,
                                    child: Text(snapshot.data!["email"]),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(5),
                            child: Expanded(
                              flex: 0,
                              child: Row(
                                children: [
                                  const Expanded(
                                    flex: 0,
                                    child: Text(
                                      "Address",
                                      softWrap: true,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                  const Expanded(
                                    flex: 0,
                                    child: Padding(
                                      padding: EdgeInsets.only(left: 10, right: 10),
                                      child: Text(":"),
                                    ),
                                  ),
                                  Expanded(
                                    flex: 0,
                                    child: Text(snapshot.data!["address"]),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(5),
                            child: Expanded(
                              flex: 0,
                              child: Row(
                                children: [
                                  const Expanded(
                                    flex: 0,
                                    child: Text(
                                      "Owner Name",
                                    ),
                                  ),
                                  const Expanded(
                                    flex: 0,
                                    child: Padding(
                                      padding: EdgeInsets.only(left: 10, right: 10),
                                      child: Text(":"),
                                    ),
                                  ),
                                  Expanded(
                                    flex: 0,
                                    child: Text(snapshot.data!["ownerName"]),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(5),
                            child: Expanded(
                              flex: 0,
                              child: Row(
                                children: [
                                  const Expanded(
                                    flex: 0,
                                    child: Text(
                                      "Owner Number",
                                    ),
                                  ),
                                  const Expanded(
                                    flex: 0,
                                    child: Padding(
                                      padding: EdgeInsets.only(left: 10, right: 10),
                                      child: Text(":"),
                                    ),
                                  ),
                                  Expanded(
                                    flex: 0,
                                    child: Text("0" + snapshot.data!["ownerNumber"]),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          const Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Divider(thickness: 2,),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(5),
                            child: Expanded(
                              flex: 0,
                              child: Row(
                                children: [
                                  const Expanded(
                                    flex: 0,
                                    child: Text(
                                      "Rating",
                                    ),
                                  ),
                                  const Expanded(
                                    flex: 0,
                                    child: Padding(
                                      padding: EdgeInsets.only(left: 10, right: 10),
                                      child: Text(":"),
                                    ),
                                  ),
                                  Expanded(
                                    flex: 0,
                                    child: Container(
                                      child: Text(snapshot.data!["rating"].toString()),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(5),
                            child: Expanded(
                              flex: 0,
                              child: Row(
                                children: [
                                  const Expanded(
                                    flex: 0,
                                    child: Text(
                                      "Top Picked Store",
                                    ),
                                  ),
                                  Expanded(
                                    flex: 0,
                                    child: Container(
                                      child: const Padding(
                                        padding: EdgeInsets.only(left: 10, right: 10),
                                        child: Text(":"),
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    flex: 0,
                                    child: Container(
                                      child: snapshot.data!["isTopPicked"] ? Chip(
                                        backgroundColor: Colors.green,
                                        label: Row(
                                          children: const [
                                            Icon(Icons.check, color: Colors.white,),
                                            Text("Top Picked", style: TextStyle(
                                              color: Colors.white
                                            ),)
                                          ],
                                        ),
                                      ) : const SizedBox()
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Wrap(
                            children: [
                              SizedBox(
                                height: 120,
                                width: 120,
                                child: Card(
                                  color: Colors.orangeAccent.withOpacity(.9),
                                  elevation: 4,
                                  child: Padding(
                                    padding: const EdgeInsets.all(10.0),
                                    child: Center(
                                      child: Column(
                                        mainAxisSize: MainAxisSize.min,
                                        children: const [
                                          Icon(
                                            CupertinoIcons.money_dollar_circle,
                                            size: 50,
                                            color: Colors.black54,
                                          ),
                                          Text("Total Revenue"),
                                          Text("20000")
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: 120,
                                width: 120,
                                child: Card(
                                  color: Colors.orangeAccent.withOpacity(.9),
                                  elevation: 4,
                                  child: Padding(
                                    padding: const EdgeInsets.all(10.0),
                                    child: Center(
                                      child: Column(
                                        mainAxisSize: MainAxisSize.min,
                                        children: const [
                                          Icon(
                                            CupertinoIcons.cart,
                                            size: 50,
                                            color: Colors.black54,
                                          ),
                                          Text("Active Orders"),
                                          Text("6")
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: 120,
                                width: 120,
                                child: Card(
                                  color: Colors.orangeAccent.withOpacity(.9),
                                  elevation: 4,
                                  child: Padding(
                                    padding: const EdgeInsets.all(10.0),
                                    child: Center(
                                      child: Column(
                                        mainAxisSize: MainAxisSize.min,
                                        children: const [
                                          Icon(
                                            Icons.shopping_bag,
                                            size: 50,
                                            color: Colors.black54,
                                          ),
                                          Text("Orders"),
                                          Text("130")
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: 120,
                                width: 120,
                                child: Card(
                                  color: Colors.orangeAccent.withOpacity(.9),
                                  elevation: 4,
                                  child: Padding(
                                    padding: const EdgeInsets.all(10.0),
                                    child: Center(
                                      child: Column(
                                        mainAxisSize: MainAxisSize.min,
                                        children: const [
                                          Icon(
                                            Icons.grain_outlined,
                                            size: 50,
                                            color: Colors.black54,
                                          ),
                                          Text("Products"),
                                          Text("160")
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: 120,
                                width: 120,
                                child: Card(
                                  color: Colors.orangeAccent.withOpacity(.9),
                                  elevation: 4,
                                  child: Padding(
                                    padding: const EdgeInsets.all(10.0),
                                    child: Center(
                                      child: Column(
                                        mainAxisSize: MainAxisSize.min,
                                        children: const [
                                          Icon(
                                            Icons.list_alt_outlined,
                                            size: 50,
                                            color: Colors.black54,
                                          ),
                                          Text("Statement"),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          )
                        ],
                      ),
                    ],
                  ),
                ),
                Positioned(
                  top: 10,
                  right: 10,
                  child: snapshot.data!['accVerified'] ? Chip(
                    backgroundColor: Colors.green,
                    label: Row(
                      children: const [
                        Icon(Icons.check, color: Colors.white,),
                        SizedBox(width: 2,),
                        Text("Active", style: TextStyle(color: Colors.white),)
                      ],
                    ),
                  ) : Chip(
                    backgroundColor: Colors.red,
                    label: Row(
                      children: const [
                        Icon(Icons.remove_circle, color: Colors.white,),
                        SizedBox(width: 2,),
                        Text("Inactive", style: TextStyle(color: Colors.white),)
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        );
      });
  }
}
