
import 'dart:developer';


import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:main_work/bottom_navigation/bottom_navigation.dart';
import 'package:main_work/core/main_data/entities/address_entities.dart';
import 'package:main_work/features/home/domain/entities/home_category_entities.dart';
import 'package:main_work/features/home/domain/entities/home_entitie.dart';

import '../../../../../core/main_data/module/address_module.dart';
import '../../../../home/data/module/home_category_module.dart';
import '../../../../home/data/module/home_module.dart';

part 'buying_event.dart';
part 'buying_state.dart';

FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;

class BuyingBloc extends Bloc<BuyingEvent, BuyingState> {
  BuyingBloc() : super(BuyingInitial()) {
    on<GetProductInfo>((event, emit) async{
      try {
        List<Map<String,dynamic>> rating=[];
        final box = await Hive.openBox("favorits");
      final favorit = await box.get(event.productId);

      final cartbox = await Hive.openBox("cart");
      final data = await cartbox.get(event.productId);
      try {
        final ratingList = await _firebaseFirestore.collection("raring").doc(event.productId).collection("rating").get().then((value) => value.docs.map((e) => e.data()).toList());
      for (var ratingRow in ratingList) {
        if(ratingRow["review"]!=null)
        {
          rating.add(ratingRow);
        }
      }
      } catch (e) {
      }
      HomeDataEntities? productData;
        productData = await _firebaseFirestore
            .collection("products")
            .doc(event.productId)
            .get()
            .then((value) => HomeData.formjson(value.data()!));
        final shopAddress = await _firebaseFirestore.collection("shop").doc(productData!.sellerId).collection("more_data").doc("address").get().then((value) => AddressData.formjson( value.data()!),);
        final shopData = await _firebaseFirestore.collection("shop").doc(productData.sellerId).get().then((value) => value.data()!);
        List<HomeDataEntities> moreProducts = [];
        moreProducts = await _firebaseFirestore.collection("products").where("sellerId", isEqualTo: shopData["shopId"]).limit(6).get()
            .then((value) =>
                value.docs.map((e) => HomeData.formjson(e.data())).toList());
      if(rating.isEmpty)
      {
        emit(BuyingPageState(
              favoritListAdded: favorit != null,
              cartListAdded: data != null,
              data: productData,
              shopAddress: shopAddress,
              review: null,
              moreProduct: HomeCategoryData(
                  shopId: shopData["shopId"],
                  shopName: shopData["shopName"],
                  imageUrl: shopData["image"],
                  products: moreProducts)));
      }
      else{
        emit(BuyingPageState(favoritListAdded: favorit!=null,cartListAdded: data!=null,review: rating,shopAddress: shopAddress,data: productData,moreProduct: HomeCategoryData(
            shopId: shopData["shopId"],
            shopName: shopData["shopName"],
            imageUrl: shopData["image"],
            products: moreProducts)));
      }
      } catch (e) {
        log(e.toString());
      }
      
    });
    on<UpdateState>((event, emit){
      emit(state);
  }); 
  }
}
