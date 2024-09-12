import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'package:main_work/features/account/presentaion/widgets/address_adding.dart';
import 'package:main_work/features/home/domain/entities/home_entitie.dart';

import '../../features/buying/presentaion/page/order_confrom.dart';
import '../../features/cart/domain/entities/cart_entities.dart';

FirebaseAuth _auth = FirebaseAuth.instance;
FirebaseFirestore _firestore = FirebaseFirestore.instance;
bool isLocationAddad=false;

class LocationRequest extends StatelessWidget {
  const LocationRequest({
    Key? key,
    this.home,
    this.cart,
    this.selectedColor,
    this.selectedSize,
    this.itemCount,
    this.cartSelectedColor,
    this.cartSelectedSize,
    this.cartItemCount,
  }) : super(key: key);
  final HomeDataEntities? home;
  final List<CartEntities>? cart;
  final String? selectedColor;
  final String? selectedSize;
  final String? itemCount;
  final List<String>? cartSelectedColor;
  final List<String>? cartSelectedSize;
  final List<String>? cartItemCount;

  @override
  Widget build(BuildContext context) {
    // final size = MediaQuery.of(context).size;
    return FutureBuilder(
      future: check(context),
      builder: (context, snapshot){
        
        if(snapshot.data==null)
        {
          return const SizedBox(width: double.infinity,height: 300,child: Center(child: CircularProgressIndicator()));
        }else if(snapshot.data==true)
        {
          if(cart!=null)
          {
            return OrderConform(cart: cart,);
          }else if (home != null) {
              return OrderConform(
                data: home!,
                selectedColor: selectedColor,
                selectedSize: selectedSize,
              );
            }
          // Navigator.pop(context);
        }
        WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
          showDialog(context: context, builder: (context) => Dialog(shape: Border.all(),child: const AddressAddingPage(),),);
        },);
        return const SizedBox(
          height: 300,
        );
      }
    );
  }
  Future<bool> check(context)async{
    try {
      // final uid = _auth.currentUser!.uid;
    final st = await _firestore
            .collection("address")
            .where("uid",isEqualTo: _auth.currentUser!.uid)
            .get()
            .then((value) => value.docs.map((e) => e.data(),).toList());
    if(st.isEmpty)
    {
      isLocationAddad=false;
      return false;
    }else{
      isLocationAddad=true;
      return true;
    }
    } catch (e) {
      isLocationAddad=false;
      log(e.toString());
      return false;
    }
  }
}

