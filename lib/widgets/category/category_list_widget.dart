import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:pigalukuadmin/services/firebase_services.dart';
import 'package:pigalukuadmin/widgets/category/category_card_widget.dart';

class CategoryListWidget extends StatelessWidget {
  const CategoryListWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    FirebaseServices services = FirebaseServices();

    return Container(
      width: MediaQuery.of(context).size.width,
      child: StreamBuilder(
        stream: services.category.snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot){
          if (snapshot.hasError) {
            return const Text('Something went wrong');
          }

          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          return Wrap(
            direction: Axis.horizontal,
            children: snapshot.data!.docs.map((DocumentSnapshot document){
              return CategoryCard(document: document,);
            }).toList(),
          );

        },
      ),
    );
  }
}
