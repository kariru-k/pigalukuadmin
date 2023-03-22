import 'dart:ui';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:pigalukuadmin/services/firebase_services.dart';

class VendorDataTable extends StatelessWidget {
  const VendorDataTable({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    FirebaseServices _services = FirebaseServices();


    return StreamBuilder(
      stream: _services.vendors.orderBy("shopName", descending: true).snapshots(),
      builder: (context, snapshot){
        if(snapshot.hasError){
          return const Text("Something went wrong");
        }

        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
        
        return ScrollConfiguration(
          behavior: ScrollConfiguration.of(context).copyWith(
              dragDevices: {
                PointerDeviceKind.touch,
                PointerDeviceKind.mouse
              }
          ),
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: DataTable(
              horizontalMargin: 0,
              columns: const <DataColumn> [
                DataColumn(label: Text("Active / Inactive")),
                DataColumn(label: Text("Top picked")),
                DataColumn(label: Text("Shop Name")),
                DataColumn(label: Text("Rating")),
                DataColumn(label: Text("Total Sales")),
                DataColumn(label: Text("Mobile")),
                DataColumn(label: Text("Email")),
                DataColumn(label: Text("View details")),
              ],
              rows: _vendorDetailsRows(snapshot.data) as List<DataRow>,
              showBottomBorder: true,
              dataRowHeight: 80,
              headingRowColor: MaterialStateProperty.all(Colors.grey[200]),

            ),
          ),
        );
      },
    );
  }
  List<DataRow>? _vendorDetailsRows(QuerySnapshot? snapshot){
    List<DataRow>? newList = snapshot?.docs.map((DocumentSnapshot document) {
      return DataRow(
          cells: [
            DataCell(
                IconButton(
                    onPressed: () {},
                    icon: document['accVerified']
                        ? const Icon(Icons.check_circle, color: Colors.green,)
                        : const Icon(Icons.check_circle, color: Colors.red,)
                )
            ),
            DataCell(
                IconButton(
                    onPressed: () {},
                    icon: document['isTopPicked']
                        ?
                    const Icon(
                      Icons.check_circle,
                      color: Colors.green,
                    ) :
                    const Icon(
                      null
                    )
                )
            ),
            DataCell(
              Text(document["shopName"])
            ),
            DataCell(
              Row(
                children: const [
                  Icon(Icons.star),
                  Text("5.0")
                ],
              )
            ),
            const DataCell(Text("20000")),
            DataCell(Text(document["storePhoneNumber"])),
            DataCell(Text(document["email"])),
            DataCell(
              IconButton(
                onPressed: () {},
                icon: const Icon(Icons.remove_red_eye_sharp),
              )
            )
          ]);
    }).toList();

    return newList;
  }


}
