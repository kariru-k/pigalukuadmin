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
  final _subCatNameTextController = TextEditingController();


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

                Map<String, dynamic> data = snapshot.data!.data() as Map<String, dynamic>;;
                return Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      children: [
                        Row(
                          children: [
                            const Text("Main Category: "),
                            const SizedBox(width: 15,),
                            Text(widget.categoryName, style: const TextStyle(fontWeight: FontWeight.bold),)
                          ],
                        ),
                        const Divider(thickness: 3,),
                      ],
                    ),
                    Container(
                      child: Expanded(
                        child: ListView.builder(
                          itemBuilder:  (BuildContext context, int index){
                            return ListTile(
                              contentPadding: EdgeInsets.zero,
                              leading: CircleAvatar(
                                child: Text("${index + 1}"),
                              ),
                              title: Text(data["subCat"][index]['name']),
                            );
                          },
                          itemCount: data['subCat'] == null ? 0 : data['subCat'].length,
                        ),
                      ),
                    ),
                    Column(
                      children: [
                        const Divider(thickness: 4,),
                        //subcategory list
                        Container(
                          color: Colors.grey,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Padding(
                                padding: EdgeInsets.all(8.0),
                                child: Text(
                                  "Add New Sub Category",
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold
                                  ),
                                ),
                              ),
                              const SizedBox(height: 6,),
                              Row(
                                children: [
                                  Expanded(
                                    child: SizedBox(
                                      height: 30,
                                      child: TextField(
                                        controller: _subCatNameTextController,
                                        decoration: const InputDecoration(
                                          fillColor: Colors.white,
                                          hintText: "Sub Category Name",
                                          filled: true,
                                          border: OutlineInputBorder(),
                                          focusedBorder: OutlineInputBorder(),
                                          contentPadding: EdgeInsets.only(left: 10)
                                        ),
                                      ),
                                    ),
                                  ),
                                  ElevatedButton(
                                      onPressed: () {
                                        if(_subCatNameTextController.text.isEmpty){
                                          services.showMyDialog(
                                            context: context,
                                            title: "Add New SubCategory",
                                            message: "Please Give a subcategory name"
                                          );
                                        }
                                        else {
                                          DocumentReference doc = services.category.doc(widget.categoryName);
                                          doc.update({
                                            'subCat' : FieldValue.arrayUnion([
                                              {
                                                "name" : _subCatNameTextController.text
                                              }
                                            ])
                                          });
                                          setState(() {

                                          });
                                          _subCatNameTextController.clear();
                                        }
                                      },
                                      child: const Text(
                                        "Save",
                                        style: TextStyle(
                                          color: Colors.white
                                        ),
                                      )
                                  ),
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
