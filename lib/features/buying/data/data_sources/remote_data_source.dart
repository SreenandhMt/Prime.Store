
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;
FirebaseAuth _auth = FirebaseAuth.instance;

class BuyingDataSource {
  Future<String> buyConfrom({required Map<String,dynamic> map,required String uid,required String id}) async{
    Map<String,dynamic> mapData = {
        "productId": map["productId"],
        "sellerId": map["sellerId"],
        "colors": map["colors"],
        "size": map["size"],
        "BuyerLocationId":uid,
        "status":"Order Confiremed",
        "uid":uid,
        "orderid":id,
        "time":Timestamp.now()
      };
      await _firebaseFirestore.collection("orders").doc("user").collection(_auth.currentUser!.uid).doc(id).set(mapData);
      await _firebaseFirestore.collection("orders").doc("shop").collection(map["sellerId"]).doc(id).set(mapData);
      return "";
  }
}