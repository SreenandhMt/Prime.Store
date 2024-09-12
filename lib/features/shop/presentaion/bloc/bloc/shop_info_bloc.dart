import 'dart:developer';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:main_work/core/main_data/entities/address_entities.dart';
import 'package:main_work/core/main_data/module/address_module.dart';
import 'package:main_work/features/account/data/module/account_orders_module.dart';
import 'package:main_work/features/account/domain/entities/account_orders_entities.dart';

import '../../../../home/data/module/home_module.dart';
import '../../../../home/domain/entities/home_entitie.dart';

part 'shop_info_event.dart';
part 'shop_info_state.dart';

FirebaseAuth _auth = FirebaseAuth.instance;
FirebaseFirestore _firestore = FirebaseFirestore.instance;
FirebaseStorage _storage = FirebaseStorage.instance;

class ShopInfoBloc extends Bloc<ShopInfoEvent, ShopInfoState> {
  ShopInfoBloc() : super(ShopInfoInitial()) {
    on<GetSelledDatas>((event, emit) async{
      try {
        if(_auth.currentUser==null)
        {
          emit(NoData());
          return;
        }
      final data =await _firestore.collection("products").where("sellerId", isEqualTo: _auth.currentUser!.uid).get().then((value) => value.docs.map((e) => HomeData.formjson(e.data())).toList());
      final shopAddress = await _firestore.collection("shop").doc(_auth.currentUser!.uid).collection("more_data").doc("address").get().then((value) => AddressData.formjson( value.data()!),);
      final shopData = await _firestore.collection("shop").doc(_auth.currentUser!.uid).get().then((value) => value.data()!,);
      final orders = await _firestore.collection("orders").doc("shop").collection(_auth.currentUser!.uid).get().then((value) => value.docs.map((e) => e.data()).toList());
      // List<Map<String,dynamic>> productList=[];
      List<AccountOrdersDataEntities> location =[];
      for (var product in orders) {
        final shopLocation = await  _firestore.collection("shop").doc(product["sellerId"]).collection("more_data").doc("address").get().then((value) => AddressData.formjson(value.data()!));
        final temp = await  _firestore.collection("products").doc(product["productId"]).get().then((value) => value.data()!);
        final loc = await _firestore.collection("address").doc(product["addressid"]).get().then((value) => AccountOrdersData.formjson(product,temp,AddressData.formjson(value.data()!),shopLocation));
        location.add(loc);
      }
      emit(SelledProdects(data: data,shopAddress: shopAddress,shopData: shopData,ordersData:location ));
      } catch (e) {
        log("error $e");
      }
    });

    on<Delete>((event, emit) async{
      emit(Uploading());
      await _firestore.collection("products").doc(event.id).delete();
      GetSelledDatas();
      // final data =await _firestore.collection("products").get().then((value) => value.docs.map((e) => HomeData.formjson(e.data())).toList());
      // final _shopAddress = await _firestore.collection("shop").doc(_auth.currentUser!.uid).collection("more_data").doc("address").get().then((value) => AddressData.formjson( value.data()!),);
      // final _shopData = await _firestore.collection("shop").doc(_auth.currentUser!.uid).get().then((value) => value.data()!,);
      // emit(SelledProdects(data: data,shopAddress: _shopAddress,shopData: _shopData));
    });

    on<UpdateProducts>((event, emit) async{
      try {
        List<dynamic> imageUrl = event.imageList;
        if(_auth.currentUser==null)return;
      emit(Uploading());
      // final uid = _auth.currentUser!.uid;
      Map<String, dynamic> mapData = {
        "productId": event.id,
        "productUrls": imageUrl,
        "productName": event.productName,
        "productAbout": event.productAbout,
        "productType": event.productType,
        "sellerId": event.sellerId,
        "price":event.price,
        "colorList":event.colorsList??[],
        "sizeList":event.sizeList??[],
      };

      await _firestore.collection("products").doc(mapData["productId"]).update(mapData);
      GetSelledDatas();
      // final data =await _firestore.collection("products").get().then((value) => value.docs.map((e) => HomeData.formjson(e.data())).toList());
      // final _shopAddress = await _firestore.collection("shop").doc(_auth.currentUser!.uid).collection("more_data").doc("address").get().then((value) => AddressData.formjson( value.data()!),);
      // final _shopData = await _firestore.collection("shop").doc(_auth.currentUser!.uid).get().then((value) => value.data()!,);
      // emit(SelledProdects(data: data,shopAddress: _shopAddress,shopData: _shopData));
      } catch (e) {
        log(e.toString());
      }
    });

    on<Sell>((event, emit) async{
      try {
        List<String> imageUrl = [];
        if(_auth.currentUser==null)return;
      emit(Uploading());
      for (var image in event.imageList) {
        final ref = await _storage.ref().child("images/${image!.name}").putFile(File(image.path));
        final url = await ref.ref.getDownloadURL();
        imageUrl.add(url);
      }
      final uid = _auth.currentUser!.uid;
      final highlight = event.producthigh.split("_");
      final id = DateTime.now().microsecondsSinceEpoch.toString();
      // log(id);
      Map<String, dynamic> mapData = {
        "productId": id,
        "productUrls": imageUrl,
        "productName": event.productName,
        "productAbout": event.productAbout,
        "highlights": highlight,
        "productType": event.productType,
        "sellerId": uid,
        "price":event.price,
        "colors": 1,
        "colorList":event.colorsList,
        "sizeList":event.sizeList,
        "size": "",
      };

      await _firestore.collection("products").doc(mapData["productId"]).set(mapData);
      GetSelledDatas();
      // final data =await _firestore.collection("products").where("sellerId",isEqualTo: _auth.currentUser!.uid).get().then((value) => value.docs.map((e) => HomeData.formjson(e.data())).toList());
      // final _shopAddress = await _firestore.collection("shop").doc(_auth.currentUser!.uid).collection("more_data").doc("address").get().then((value) => AddressData.formjson( value.data()!),);
      // final _shopData = await _firestore.collection("shop").doc(_auth.currentUser!.uid).get().then((value) => value.data()!,);
      // emit(SelledProdects(data: data,shopAddress: _shopAddress,shopData: _shopData));
      } catch (e) {
        log("error ${e.toString()}");
      }
    });
  }
}
