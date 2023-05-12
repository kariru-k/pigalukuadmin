import 'package:flutter/material.dart';
import 'package:flutter_admin_scaffold/admin_scaffold.dart';

import '../widgets/sidebar.dart';

class OrderScreen extends StatelessWidget {
  static const String id = "order-screen";
  const OrderScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SideBarWidget sideBar = SideBarWidget();
    return AdminScaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text('Piga Luku Admin Dashboard'),
        backgroundColor: Colors.black45,
        iconTheme: const IconThemeData(
            color: Colors.white
        ),
      ),
      sideBar: sideBar.SideBarMenus(context, OrderScreen.id),
      body: SingleChildScrollView(
        child: Container(
          alignment: Alignment.topLeft,
          padding: const EdgeInsets.all(10),
          child: const Text(
            'Orders',
            style: TextStyle(
              fontWeight: FontWeight.w700,
              fontSize: 36,
            ),
          ),
        ),
      ),

    );
  }
}