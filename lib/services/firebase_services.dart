import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:progress_dialog_null_safe/progress_dialog_null_safe.dart';

class FirebaseServices{


  FirebaseFirestore firestore = FirebaseFirestore.instance;
  CollectionReference banners = FirebaseFirestore.instance.collection("slider");
  CollectionReference vendors = FirebaseFirestore.instance.collection("vendors");
  CollectionReference deliveryPersons = FirebaseFirestore.instance.collection("deliverypersons");
  CollectionReference category = FirebaseFirestore.instance.collection("category");
  Future<DocumentSnapshot>getAdminCredentials(id){
    var result = FirebaseFirestore.instance.collection("admin").doc(id).get();
    return result;
  }


  //Banner functions
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

  //Vendor Functions
  updateVendorStatus({id, status, field}) async{
    vendors.doc(id).update({
      field : status ? false : true
    });
  }


  //Category Functions
  Future<String>uploadCategoryImageToDb(url, catName)async{
    String downloadUrl = await FirebaseStorage.instance.ref(url).getDownloadURL();
    category.doc(catName).set({
      "image" : downloadUrl,
      "name": catName
    });
    return downloadUrl;
  }

  //Dialog Functions
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

  updateApprovalStatus(id, bool status, context){

    ProgressDialog progressDialog = ProgressDialog(context);


    DocumentReference documentReference = deliveryPersons.doc(id);

    return FirebaseFirestore.instance.runTransaction((transaction) async{

      DocumentSnapshot snapshot = await transaction.get(documentReference);

      if (!snapshot.exists) {
        throw Exception("User does not exist");
      }

      progressDialog.show();

      transaction.update(documentReference, {"accVerified": status});
    })
        .then((value){
          progressDialog.hide();
          showMyDialog(
              title: "Delivery person status updated", 
              message: "Successfully updated Delivery person status",
              context: context
          );
        }
    )
        .catchError((error) {
          progressDialog.hide();
          showMyDialog(
              title: "Error updating delivery person status",
              message: "There was an error, please try again",
              context: context
          );
        });
  }




}