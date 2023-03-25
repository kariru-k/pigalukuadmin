import 'dart:ui';

import 'package:chips_choice/chips_choice.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pigalukuadmin/services/firebase_services.dart';
import 'package:pigalukuadmin/widgets/vendor_details_box.dart';

class VendorDataTable extends StatefulWidget {
  const VendorDataTable({Key? key}) : super(key: key);

  @override
  State<VendorDataTable> createState() => _VendorDataTableState();
}

class _VendorDataTableState extends State<VendorDataTable> {
  final FirebaseServices _services = FirebaseServices();

  int tag = 0;
  List<String> options = [
    'All Vendors', 'Active Vendors', 'Inactive Vendors',
    'Top Picked', 'Top Rated'
  ];

  bool? topPicked;
  bool? active;
  bool? topRated;



  @override
  Widget build(BuildContext context) {

    filter(val){
      if(val == 0){
        setState(() {
          active = null;
          topPicked = null;
          topRated = null;
        });
      }
      if(val == 1){
        setState(() {
          active = true;
        });
      }
      if(val == 2){
        setState(() {
          active = false;
        });
      }
      if(val == 3){
        setState(() {
          topPicked = true;
        });
      }
      if(val == 4){
        setState(() {
          topRated = true;
        });
      }
    }

    onchanged(val){
      setState(() {
        tag = val;
      });
      filter(val);
    }


    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ScrollConfiguration(
          behavior: ScrollConfiguration.of(context).copyWith(
              dragDevices: {
                PointerDeviceKind.touch,
                PointerDeviceKind.mouse
              },
              ),
          child: ChipsChoice<int>.single(
              value: tag,
              onChanged: onchanged,
              choiceItems: C2Choice.listFrom<int, String>(
                source: options,
                value: (i, v) => i,
                label: (i, v) => v,
                tooltip: (i, v) => v,
          )),
        ),
        const Divider(thickness: 5,),
        StreamBuilder(
          stream: _services
              .vendors
              .where("isTopPicked", isEqualTo: topPicked)
              .where("accVerified", isEqualTo: active)
              .snapshots(),
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
                  rows: _vendorDetailsRows(snapshot.data, _services) as List<DataRow>,
                  showBottomBorder: true,
                  dataRowHeight: 80,
                  headingRowColor: MaterialStateProperty.all(Colors.grey[200]),

                ),
              ),
            );
          },
        ),
      ],
    );
  }

  List<DataRow>? _vendorDetailsRows(QuerySnapshot? snapshot,FirebaseServices services){
    List<DataRow>? newList = snapshot?.docs.map((DocumentSnapshot document) {
      return DataRow(
          cells: [
            DataCell(
                IconButton(
                    onPressed: () {
                      services.updateVendorStatus(
                        id: document['uid'],
                        field: "accVerified",
                        status: document["accVerified"]
                      );
                    },
                    icon: document['accVerified']
                        ? const Icon(Icons.check_circle, color: Colors.green,)
                        : const Icon(CupertinoIcons.xmark_octagon, color: Colors.red,)
                )
            ),
            DataCell(
                IconButton(
                    onPressed: () {
                      services.updateVendorStatus(
                          id: document['uid'],
                          field: "isTopPicked",
                          status: document["isTopPicked"]
                      );
                    },
                    icon: document['isTopPicked']
                        ?
                    const Icon(
                      Icons.check_circle,
                      color: Colors.green,
                    ) :
                    const Icon(
                      CupertinoIcons.xmark_octagon,
                      color: Colors.red,
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
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (BuildContext context){
                      return VendorDetailsBox(
                        uid: document["uid"],
                      );
                    }
                  );
                },
                icon: const Icon(Icons.info_outline),
              )
            )
          ]);
    }).toList();

    return newList;
  }
}
