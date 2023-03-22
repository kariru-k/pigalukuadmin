import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';

class FirebaseServices{


  FirebaseFirestore firestore = FirebaseFirestore.instance;
  CollectionReference banners = FirebaseFirestore.instance.collection("slider");
  CollectionReference vendors = FirebaseFirestore.instance.collection("vendors");

  Future<DocumentSnapshot>getAdminCredentials(id){
    var result = FirebaseFirestore.instance.collection("admin").doc(id).get();
    print(result);
    return result;
  }

  Future<String>uploadBannerImageToDb(url)async{
    String downloadUrl = await FirebaseStorage.instance.ref(url).getDownloadURL();
    firestore.collection("slider").add({
      "image" : downloadUrl
    });
    return downloadUrl;
  }

  deleteBannerImagefromDb(id) async{
    firestore.collection("slider").doc(id).delete();
  }

  Future<void> confirmDeleteDialog({title, message, context, id}) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(title),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text(message),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('CANCEL'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: const Text('DELETE'),
              onPressed: () {
                deleteBannerImagefromDb(id);
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  Future<void> showMyDialog({title, message, context}) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(title),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text(message),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('OK'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  updateVendorStatus({id, status, field}) async{
    vendors.doc(id).update({
      field : status ? false : true
    });
  }


}