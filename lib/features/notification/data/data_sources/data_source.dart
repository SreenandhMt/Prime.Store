import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:main_work/features/account/domain/entities/account_orders_entities.dart';

FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;

class NotificationDataSource {
  Future<void> updateNotification(
      {required int status,
      required String id,
      required AccountOrdersDataEntities data}) async {
        final map = data.orderMap!; 
    final updateData = {
          "productId": map["productId"],
        "sellerId": map["sellerId"],
        "uid":map["uid"],
        "orderid":map["orderid"],
        "selected_color": map["selected_color"],
        "selected_size": map["selected_size"],
        "addressid":map["addressid"],
        "status":status,
        "orderTime":map["orderTime"],
        "count":map["count"],
        "time":map["time"]
    };
    await _firebaseFirestore
        .collection("orders")
        .doc("shop")
        .collection(map["sellerId"])
        .doc(map["orderid"])
        .update(updateData);
    await _firebaseFirestore
        .collection("orders")
        .doc("user")
        .collection(map["uid"])
        .doc(map["orderid"])
        .update(updateData);
  }
}
