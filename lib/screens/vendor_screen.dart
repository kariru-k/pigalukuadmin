import 'package:flutter/material.dart';
import 'package:flutter_admin_scaffold/admin_scaffold.dart';
import 'package:pigalukuadmin/widgets/vendors/vendor_datatable_widget.dart';
import '../widgets/sidebar.dart';

class VendorScreen extends StatefulWidget {
  static const String id = "vendor-screen";
  const VendorScreen({Key? key}) : super(key: key);

  @override
  State<VendorScreen> createState() => _VendorScreenState();
}

class _VendorScreenState extends State<VendorScreen> {
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
      sideBar: sideBar.SideBarMenus(context, VendorScreen.id),
      body: SingleChildScrollView(
        child: Container(
          alignment: Alignment.topLeft,
          padding: const EdgeInsets.all(10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: const [
              Text(
                "Manage vendors",
                style: TextStyle(
                  fontWeight: FontWeight.w700,
                  fontSize: 36
                ),
              ),
              Text("Manage all the vendors activities"),
              Divider(thickness: 5,),
              VendorDataTable(),
              Divider(thickness: 5,),
            ],
          ),
        ),
      ),

    );
  }
}
