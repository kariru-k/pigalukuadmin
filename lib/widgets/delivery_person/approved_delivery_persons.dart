import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_switch/flutter_switch.dart';

import '../../services/firebase_services.dart';

class ApprovedDeliveryPersons extends StatefulWidget {
  const ApprovedDeliveryPersons({Key? key}) : super(key: key);

  @override
  State<ApprovedDeliveryPersons> createState() => _ApprovedDeliveryPersonsState();
}

class _ApprovedDeliveryPersonsState extends State<ApprovedDeliveryPersons> {

  FirebaseServices services = FirebaseServices();


  @override
  Widget build(BuildContext context) {
    FirebaseServices services = FirebaseServices();

    return StreamBuilder(
      stream: services.deliveryPersons.where("accVerified", isEqualTo: true).snapshots(),
      builder: (context, snapshot){
        if (snapshot.hasError) {
          return const Text('Something went wrong');
        }

        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }

        if (snapshot.data!.size == 0) {
          return const Center(child: Text("No Approved Delivery Persons to show"),);
        }

        return SingleChildScrollView(
          child: DataTable(
              showBottomBorder: true,
              dataRowMaxHeight: 100,
              headingRowColor: MaterialStateProperty.all(Colors.grey[200]),
              columns: const <DataColumn>[
                DataColumn(label: Expanded(child: Text("Image"))),
                DataColumn(label: Expanded(child: Text("Name"))),
                DataColumn(label: Expanded(child: Text("Email"))),
                DataColumn(label: Expanded(child: Text("Mobile Number"))),
                DataColumn(label: Expanded(child: Text("Actions"))),
              ],
              rows: personsList(snapshot.data!, context)
          ),
        );
      },
    );
  }

  List<DataRow>personsList(QuerySnapshot snapshot, context){
    List<DataRow> newList = snapshot.docs.map((DocumentSnapshot? document){
      return DataRow(
          cells: [
            DataCell(
              Expanded(child: Image.network(document!['url'], height: 50, width: 50,))
            ),
            DataCell(
              Expanded(child: Text(document["name"]))
            ),
            DataCell(
              Expanded(child: Text(document["email"]))
            ),
            DataCell(
              Expanded(child: Text(document["phoneNumber"]))
            ),
            DataCell(
              Expanded(
                child: FlutterSwitch(
                  activeText: "Approved",
                  inactiveText: "Waiting for Approval",
                  value: document["accVerified"],
                  valueFontSize: 12.0,
                  width: 110,
                  showOnOff: true,
                  onToggle: (value) {
                    services.updateApprovalStatus(document.id, false, context);
                  },
                ),
              ),
            )
          ]
      );
    }).toList();

    return newList;
  }
}
