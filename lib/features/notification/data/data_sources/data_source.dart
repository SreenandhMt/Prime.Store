import 'package:cloud_firestore/cloud_firestore.dart';

FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;

class NotificationDataSource {
  Future<void> updateNotification(
      {required String status,
      required String id,
      required Map<String, dynamic> data}) async {
    final map = {
      "productId": data["productId"],
      "sellerId": data["sellerId"],
      "colors": data["colors"],
      "size": data["size"],
      "BuyerLocationId": data["BuyerLocationId"],
      "status": status,
      "uid": data["uid"],
      "orderid": data["orderid"],
      "time": data["time"]
    };
    await _firebaseFirestore
        .collection("orders")
        .doc("shop")
        .collection(data["sellerId"])
        .doc(data["orderid"])
        .update(map);
    await _firebaseFirestore
        .collection("orders")
        .doc("user")
        .collection(data["uid"])
        .doc(data["orderid"])
        .update(map);
  }
}
