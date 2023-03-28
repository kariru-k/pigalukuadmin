import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:pigalukuadmin/services/firebase_services.dart';

class SubCategoryWidget extends StatefulWidget {
  final String categoryName;

  const SubCategoryWidget({super.key, required this.categoryName});

  @override
  State<SubCategoryWidget> createState() => _SubCategoryWidgetState();
}

class _SubCategoryWidgetState extends State<SubCategoryWidget> {


  FirebaseServices services = FirebaseServices();

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Container(
        height: MediaQuery.of(context).size.height,
        width: 300,
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: FutureBuilder<DocumentSnapshot>(
            future: services.category.doc(widget.categoryName).get(),
            builder: (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {

              if (snapshot.hasError) {
                return const Text("Something went wrong");
              }

              if (snapshot.hasData && !snapshot.data!.exists) {
                return const Text("Document does not exist");
              }

              if (snapshot.connectionState == ConnectionState.done) {
                if (!snapshot.hasData) {
                  return const Center(
                    child: Text("No Subcategories Added"),
                  );
                }

                return Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      children: [
                        Row(
                          children: [
                            const Text("Main Category"),
                            const SizedBox(width: 15,),
                            Text(widget.categoryName, style: const TextStyle(fontWeight: FontWeight.bold),)
                          ],
                        ),
                        const Divider(thickness: 3,),
                        //subcategory list
                        Container(
                          color: Colors.grey,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Divider(thickness: 4,),
                              const Text("Add New Sub Category"),
                              const SizedBox(height: 6,),
                              Row(
                                children: const [
                                  Expanded(
                                    child: SizedBox(
                                      height: 30,
                                      child: TextField(

                                      ),
                                    ),
                                  )
                                ],
                              )
                            ],
                          ),
                        )
                      ],
                    )
                  ],
                );
              }

              return const Center(
                child: CircularProgressIndicator(),
              );
            },
          ),
        ),
      ),
    );
  }
}
