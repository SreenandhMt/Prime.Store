
import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:dio/dio.dart';
import 'package:flutter_stripe/flutter_stripe.dart';

import '../../../../core/keys/key.dart';

FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;
FirebaseAuth _auth = FirebaseAuth.instance;

class BuyingDataSource {
  Future<String> buyConfrom({required Map<String,dynamic> map,required String uid,required String id}) async{
    final data = await StripeService.instance.makePayment(map["price"]);
    if(!data)return"";
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
      return "ok";
  }

  Future<String> buyConfromCartProduct({required List<Map<dynamic,dynamic>> map,required String uid,required String id}) async{
    try {
      int cash = 0;
    for(var product in map)
    {
      cash = product["price"]+cash;
    }
    final data = await StripeService.instance.makePayment(cash);
    if(!data)return"";
       for (var product in map) {
        final idog = DateTime.now().microsecondsSinceEpoch.toString();
          Map<String,dynamic> mapData = {
        "productId": product["productId"],
        "sellerId": product["sellerId"],
        "colors": product["colors"],
        "size": product["size"],
        "BuyerLocationId":uid,
        "status":"Order Confiremed",
        "uid":uid,
        "orderid":idog,
        "time":Timestamp.now()
      };
      await _firebaseFirestore.collection("orders").doc("user").collection(_auth.currentUser!.uid).doc(idog).set(mapData);
      await _firebaseFirestore.collection("orders").doc("shop").collection(product["sellerId"]).doc(idog).set(mapData);
       }
      
      return "ok";
    } catch (e) {
      log(e.toString());
      return "";
    }
  }


}

class StripeService {
  StripeService._();

  static final StripeService instance = StripeService._();

  Future<bool> makePayment(int price) async {
    try {
      String? paymentIntentClientSecret = await _createPaymentIntent(
        price,
        "inr",
      );
      if (paymentIntentClientSecret == null) return false;
      await Stripe.instance.initPaymentSheet(
        paymentSheetParameters: SetupPaymentSheetParameters(
          paymentIntentClientSecret: paymentIntentClientSecret,
          merchantDisplayName: "Hussain Mustafa",
        ),
      );
      return await _processPayment();
    } catch (e) {
      log(e.toString());
      return false;
    }
  }

  Future<String?> _createPaymentIntent(int amount, String currency) async {
    try {
      final Dio dio = Dio();
      Map<String, dynamic> data = {
        "amount": _calculateAmount(
          amount,
        ),
        "currency": currency,
      };
      var response = await dio.post(
        "https://api.stripe.com/v1/payment_intents",
        data: data,
        options: Options(
          contentType: Headers.formUrlEncodedContentType,
          headers: {
            "Authorization": "Bearer $secretkey",
            "Content-Type": 'application/x-www-form-urlencoded'
          },
        ),
      );
      if (response.data != null) {
        return response.data["client_secret"];
      }
      return null;
    } catch (e) {
      print(e);
    }
    return null;
  }

  Future<bool> _processPayment() async {
    try {
      bool done=false;
      await Stripe.instance.presentPaymentSheet().then((value){
        done = true;
      });
      return done;
    } catch (e) {
      print(e);
      return false;
    }
  }

  String _calculateAmount(int amount) {
    final calculatedAmount = amount * 100;
    return calculatedAmount.toString();
  }
}
