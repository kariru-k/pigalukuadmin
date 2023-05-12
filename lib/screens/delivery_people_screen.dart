import 'package:flutter/material.dart';
import 'package:flutter_admin_scaffold/admin_scaffold.dart';
import 'package:pigalukuadmin/widgets/delivery_person/new_delivery_persons.dart';

import '../widgets/delivery_person/approved_delivery_persons.dart';
import '../widgets/sidebar.dart';

class DeliveryPeopleScreen extends StatelessWidget {
  static const String id = "delivery-people-screen";
  const DeliveryPeopleScreen({Key? key}) : super(key: key);



  @override
  Widget build(BuildContext context) {
    SideBarWidget sideBar = SideBarWidget();


    return DefaultTabController(
      length: 2,
      child: AdminScaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: const Text('Piga Luku Admin Dashboard'),
          backgroundColor: Colors.black45,
          iconTheme: const IconThemeData(
              color: Colors.white
          ),
        ),
        sideBar: sideBar.SideBarMenus(context, id),
        body: Container(
          alignment: Alignment.topLeft,
          padding: const EdgeInsets.all(10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Delivery People',
                style: TextStyle(
                  fontWeight: FontWeight.w700,
                  fontSize: 36,
                ),
              ),
              const Text("Approve and Manage Delivery Boys"),
              TabBar(
                indicatorColor: Theme.of(context).primaryColor,
                labelColor: Theme.of(context).primaryColor,
                unselectedLabelColor: Colors.black54,
                tabs: const [
                  Tab(text: 'NEW',),
                  Tab(text: 'APPROVED',)
                ],
              ),
              const Expanded(
                child: TabBarView(
                  children: [
                    NewDeliveryPersons(),
                    ApprovedDeliveryPersons()
                  ],
                ),
              )
            ],
          ),
        ),

      ),
    );
  }
}