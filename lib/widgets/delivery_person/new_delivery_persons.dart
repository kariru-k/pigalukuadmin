import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_switch/flutter_switch.dart';

import '../../services/firebase_services.dart';

class NewDeliveryPersons extends StatefulWidget {
  const NewDeliveryPersons({Key? key}) : super(key: key);

  @override
  State<NewDeliveryPersons> createState() => _NewDeliveryPersonsState();
}

class _NewDeliveryPersonsState extends State<NewDeliveryPersons> {

  bool status = false;
  FirebaseServices services = FirebaseServices();

  @override
  Widget build(BuildContext context) {
    FirebaseServices services = FirebaseServices();


    return StreamBuilder(
      stream: services.deliveryPersons.where("accVerified", isEqualTo: false).snapshots(),
      builder: (context, snapshot){
        if (snapshot.hasError) {
          return const Text('Something went wrong');
        }

        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }
        
        if (snapshot.data!.size == 0) {
          return const Center(child: Text("No new Delivery Persons to show"),);
        }  

        return SingleChildScrollView(
          child: DataTable(
              showBottomBorder: true,
              dataRowHeight: 60,
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
                    services.updateApprovalStatus(document.id, true, context);
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
