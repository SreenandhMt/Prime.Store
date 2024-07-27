import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../../../domain/entities/account_orders_entities.dart';
import '../../module/account_orders_module.dart';

FirebaseFirestore _firestore = FirebaseFirestore.instance;
FirebaseAuth _auth = FirebaseAuth.instance;

class AccountRemoteDataSource {

  //order functions
  Future<({List<AccountOrdersDataEntities>? data , String? errorMassage})> cancelMyOrder({required String id, required String productId}) async{
    try {
      List<AccountOrdersDataEntities>? productList=[];
      var data = await  _firestore.collection("orders").doc("user").collection(id).get().then((value) => value.docs.map((e) => e.data()).toList());
      for (var product in data) {
        final temp = await  _firestore.collection("products").doc(product["productId"]).get().then((value) => AccountOrdersData.formjson(product,value.data()!),);
        productList.add(temp);
      }
      return (data:productList,errorMassage:null);
    } catch (e) {
      return (data:null,errorMassage:e.toString());
    }
  }

  Future<({List<AccountOrdersDataEntities>? data , String? errorMassage})> deleteOrderHistory({required String id, required String productId})async {
    try {
      List<AccountOrdersDataEntities>? productList=[];
      var data = await  _firestore.collection("orders").doc("user").collection(id).get().then((value) => value.docs.map((e) => e.data()).toList());
      for (var product in data) {
        final temp = await  _firestore.collection("products").doc(product["productId"]).get().then((value) => AccountOrdersData.formjson(product,value.data()!),);
        productList.add(temp);
      }
      return (data:productList,errorMassage:null);
    } catch (e) {
      return (data:null,errorMassage:e.toString());
    }
  }

  Future<({List<AccountOrdersDataEntities>? data , String? errorMassage})> getMyOrderHistory({required String id}) async{
    try {
      List<AccountOrdersDataEntities>? productList=[];
      var data = await  _firestore.collection("orders").doc("user").collection(id).get().then((value) => value.docs.map((e) => e.data()).toList());
      for (var product in data) {
        final temp = await  _firestore.collection("products").doc(product["productId"]).get().then((value) => AccountOrdersData.formjson(product,value.data()!),);
        productList.add(temp);
      }
      return (data:productList,errorMassage:null);
    } catch (e) {
      return (data:null,errorMassage:e.toString());
    }
  }

  // Future<({List<AccountOrdersDataEntities>? data , String? errorMassage})> getMyOrderReturn({required String id, required String productId}) async{
  //   try {
  //     var data = await  _firestore.collection("orders").doc("user").collection(id).get().then((value) => value.docs.map((e) => AccountOrdersData.formjson(e.data())).toList());
  //     return (data:data,errorMassage:null);
  //   } catch (e) {
  //     return (data:null,errorMassage:e.toString());
  //   }
  // }
}