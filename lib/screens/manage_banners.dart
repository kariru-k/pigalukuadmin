import 'dart:typed_data';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_admin_scaffold/admin_scaffold.dart';
import 'package:image_picker_web/image_picker_web.dart';
import 'package:pigalukuadmin/services/firebase_services.dart';
import 'package:pigalukuadmin/widgets/banner_widget.dart';
import 'package:progress_dialog_null_safe/progress_dialog_null_safe.dart';

import '../widgets/sidebar.dart';

class BannerScreen extends StatefulWidget {
  static const String id = "banner-screen";
  const BannerScreen({Key? key}) : super(key: key);

  @override
  State<BannerScreen> createState() => _BannerScreenState();
}

class _BannerScreenState extends State<BannerScreen> {
  bool _visible = false;
  final SideBarWidget _sideBar = SideBarWidget();
  final _fileNameTextController = TextEditingController();
  bool _imageSelected = true;
  FirebaseServices _services = FirebaseServices();

  void showWidget(){
    setState(() {
      _visible = true;
    });
  }


  @override
  Widget build(BuildContext context) {

    ProgressDialog progressDialog = ProgressDialog(
      context,
    );

    void uploadStorage() async {
      Uint8List? imageFile = (await ImagePickerWeb.getImageAsBytes());
      String datetime = DateTime.now().toString();
      String path = "bannerimage/$datetime";
      setState(() {
        _fileNameTextController.text = imageFile.toString();
        _imageSelected = false;
      });
      if(imageFile != null){
        Reference reference = FirebaseStorage.instance.ref().child(path);
        TaskSnapshot uploadTask = await reference.putData(imageFile, SettableMetadata(contentType: "image/jpeg"));
        progressDialog.show();
        _services.uploadBannerImageToDb(path).then((downloadUrl){
          progressDialog.hide();
          _services.showMyDialog(
              title: "New Banner Image",
              message: "Saved Banner Image",
              context: context
          );
        });
      };
    }

    return AdminScaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text('Piga Luku Admin Dashboard'),
        backgroundColor: Colors.black45,
        iconTheme: const IconThemeData(
            color: Colors.white
        ),
      ),
      sideBar: _sideBar.SideBarMenus(context, BannerScreen.id),
      body: SingleChildScrollView(
        child: Container(
          alignment: Alignment.topLeft,
          padding: const EdgeInsets.all(10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Banners',
                style: TextStyle(
                  fontWeight: FontWeight.w700,
                  fontSize: 36,
                ),
              ),
              const Text(
                  "Add / Delete Home Screen Banner Images"
              ),
              const Divider(
                thickness: 5,
              ),
              const BannerWidget(),
              const Divider(
                thickness: 5,
              ),
              Container(
                color: Colors.grey,
                width: MediaQuery.of(context).size.width,
                height: 80,
                child: Padding(
                  padding: const EdgeInsets.only(left: 30),
                  child: Row(
                    children: [
                      Flexible(
                        child: Visibility(
                          visible: _visible,
                          child: Row(
                            children: [
                              Flexible(
                                child: AbsorbPointer(
                                  absorbing: true,
                                  child: SizedBox(
                                    width: 300,
                                    height: 30,
                                    child: TextField(
                                      controller: _fileNameTextController,
                                      decoration: const InputDecoration(
                                        focusedBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                            color: Colors.black,
                                            width: 1
                                          )
                                        ),
                                        filled: true,
                                        fillColor: Colors.white,
                                        hintText: "Uploaded Image",
                                        border: OutlineInputBorder(),
                                        contentPadding: EdgeInsets.only(
                                          left: 20
                                        )
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(width: 10,),
                              Flexible(
                                child: ElevatedButton(
                                    onPressed: () {
                                      uploadStorage();
                                    },
                                    child: const Text("Upload Image")
                                ),
                              ),
                              const SizedBox(width: 10,),
                              Flexible(
                                child: AbsorbPointer(
                                  absorbing: _imageSelected,
                                  child: ElevatedButton(
                                      onPressed: () {},
                                      child: const Text("Save Image")
                                  ),
                                ),
                              ),
                              const SizedBox(width: 10,),
                            ],
                          ),
                        ),
                      ),
                      Flexible(
                        child: Visibility(
                          visible: _visible ? false : true,
                          child: ElevatedButton(
                              onPressed: () {
                                showWidget();
                              },
                              child: const Text("Add Banner")
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),

    );


  }



}
