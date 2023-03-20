import 'package:cloud_firestore/cloud_firestore.dart';

class FirebaseServices{

  Future<DocumentSnapshot>getAdminCredentials(id){
    var result = FirebaseFirestore.instance.collection("admin").doc(id).get();
    print(result);
    return result;
  }


}