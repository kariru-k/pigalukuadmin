import 'package:flutter/material.dart';
import 'package:flutter_admin_scaffold/admin_scaffold.dart';
import 'package:pigalukuadmin/widgets/category/category_upload_widget.dart';

import '../widgets/category/category_list_widget.dart';
import '../widgets/sidebar.dart';

class CategoryScreen extends StatelessWidget {
  static const String id = "category-screen";
  const CategoryScreen({Key? key}) : super(key: key);

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
      sideBar: sideBar.SideBarMenus(context, CategoryScreen.id),
      body: SingleChildScrollView(
        child: Container(
          alignment: Alignment.topLeft,
          padding: const EdgeInsets.all(10),
          child: Column(
            children: const [
              Text(
                'Categories',
                style: TextStyle(
                  fontWeight: FontWeight.w700,
                  fontSize: 36,
                ),
              ),
              Text("Add new Categories and Sub Categories"),
              Divider(thickness: 5,),
              CategoryCreateWidget(),
              Divider(thickness: 5,),
              CategoryListWidget()
            ],
          ),
        ),
      ),

    );


  }
}
