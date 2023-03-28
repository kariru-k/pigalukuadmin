import 'dart:typed_data';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker_web/image_picker_web.dart';
import 'package:progress_dialog_null_safe/progress_dialog_null_safe.dart';

import '../../services/firebase_services.dart';

class BannerUploadWidget extends StatefulWidget {
  const BannerUploadWidget({Key? key}) : super(key: key);

  @override
  State<BannerUploadWidget> createState() => _BannerUploadWidgetState();
}

class _BannerUploadWidgetState extends State<BannerUploadWidget> {

  bool visible = false;


  void showWidget(){
    setState(() {
      visible = true;
    });
  }



  @override
  Widget build(BuildContext context) {
    final fileNameTextController = TextEditingController();
    bool imageSelected = true;
    FirebaseServices services = FirebaseServices();

    ProgressDialog progressDialog = ProgressDialog(
      context,
    );


    void uploadStorage() async {
      Uint8List? imageFile = (await ImagePickerWeb.getImageAsBytes());
      String datetime = DateTime.now().toString();
      String path = "bannerimage/$datetime";
      setState(() {
        fileNameTextController.text = imageFile.toString();
        imageSelected = false;
      });
      if(imageFile != null){
        Reference reference = FirebaseStorage.instance.ref().child(path);
        await reference.putData(imageFile, SettableMetadata(contentType: "image/jpeg"));
        progressDialog.show();
        services.uploadBannerImageToDb(path).then((downloadUrl){
          progressDialog.hide();
          services.showMyDialog(
              context: context,
              title: "New Banner Image",
              message: "Saved Banner Image"
          );
        });
      }
    }



    return Container(
      color: Colors.grey,
      width: MediaQuery.of(context).size.width,
      height: 80,
      child: Padding(
        padding: const EdgeInsets.only(left: 30),
        child: Row(
          children: [
            Flexible(
              child: Visibility(
                visible: visible,
                child: Row(
                  children: [
                    Flexible(
                      child: AbsorbPointer(
                        absorbing: true,
                        child: SizedBox(
                          width: 300,
                          height: 30,
                          child: TextField(
                            controller: fileNameTextController,
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
                        absorbing: imageSelected,
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
                visible: visible ? false : true,
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
    );
  }
}
