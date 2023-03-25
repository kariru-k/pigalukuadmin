import 'package:flutter/material.dart';
import 'package:flutter_admin_scaffold/admin_scaffold.dart';
import 'package:pigalukuadmin/widgets/banner_upload_widget.dart';
import 'package:pigalukuadmin/widgets/banner_widget.dart';

import '../widgets/sidebar.dart';

class BannerScreen extends StatelessWidget {
  static const String id = "banner-screen";
  final SideBarWidget _sideBar = SideBarWidget();

  BannerScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return AdminScaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text('Piga Luku Admin Dashboard'),
        backgroundColor: Colors.black45,
        iconTheme: const IconThemeData(
            color: Colors.white
        ),
      ),
      sideBar: _sideBar.SideBarMenus(context, id),
      body: SingleChildScrollView(
        child: Container(
          alignment: Alignment.topLeft,
          padding: const EdgeInsets.all(10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: const [
              Text(
                'Banners',
                style: TextStyle(
                  fontWeight: FontWeight.w700,
                  fontSize: 36,
                ),
              ),
              Text(
                  "Add / Delete Home Screen Banner Images"
              ),
              Divider(
                thickness: 5,
              ),
              BannerWidget(),
              Divider(
                thickness: 5,
              ),
              BannerUploadWidget()
            ],
          ),
        ),
      ),

    );
  }
}
