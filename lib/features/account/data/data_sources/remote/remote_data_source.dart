import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:main_work/core/main_data/module/address_module.dart';

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
        
        final location = await  _firestore.collection("shop").doc(product["sellerId"]).collection("more_data").doc("address").get().then((value) => AddressData.formjson(value.data()!));
        final userAddress = await  _firestore.collection("address").where("uid",isEqualTo: _auth.currentUser!.uid).get().then((value) => value.docs.map((e) => AddressData.formjson(e.data())).toList());
        final temp = await  _firestore.collection("products").doc(product["productId"]).get().then((value) => AccountOrdersData.formjson(product,value.data()!,userAddress.first,location),);
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
        
        final location = await  _firestore.collection("shop").doc(product["sellerId"]).collection("more_data").doc("address").get().then((value) => AddressData.formjson(value.data()!));
        final userAddress = await  _firestore.collection("address").where("uid",isEqualTo: _auth.currentUser!.uid).get().then((value) => value.docs.map((e) => AddressData.formjson(e.data())).toList());
        final temp = await  _firestore.collection("products").doc(product["productId"]).get().then((value) => AccountOrdersData.formjson(product,value.data()!,userAddress.first,location),);
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
        
        final location = await  _firestore.collection("shop").doc(product["sellerId"]).collection("more_data").doc("address").get().then((value) => AddressData.formjson(value.data()!));
        final userAddress = await  _firestore.collection("address").where("uid",isEqualTo: _auth.currentUser!.uid).get().then((value) => value.docs.map((e) => AddressData.formjson(e.data())).toList());
        final temp = await  _firestore.collection("products").doc(product["productId"]).get().then((value) => AccountOrdersData.formjson(product,value.data()!,userAddress.first,location),);
        productList.add(temp);
      }
      return (data:productList,errorMassage:null);
    } catch (e) {
      log("$e <= GetOrderHistory error");
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