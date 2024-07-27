
import 'dart:developer';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart'; 
import 'package:main_work/features/account/data/module/account_selling_module.dart';

import '../../../domain/entities/account_selling_entities.dart';

part 'sell_event.dart';
part 'sell_state.dart';

FirebaseAuth _auth = FirebaseAuth.instance;
FirebaseFirestore _firestore = FirebaseFirestore.instance;
FirebaseStorage _storage = FirebaseStorage.instance;

class SellBloc extends Bloc<SellEvent, SellState> {
  SellBloc() : super(SellInitial()) {
    on<SellEvent>((event, emit) {});
    on<GetSelledDatas>((event, emit) async{
      if(_auth.currentUser==null)return;
      final data =await _firestore.collection("products").where("sellerId",isEqualTo: _auth.currentUser!.uid).get().then((value) => value.docs.map((e) => AccountSellingData.formjson(e.data())).toList());
      emit(SelledProdects(data: data));
    });

    on<Delete>((event, emit) async{
      emit(Uploading());
      await _firestore.collection("products").doc(event.id).delete();
      final data =await _firestore.collection("products").where("sellerId",isEqualTo: _auth.currentUser!.uid).get().then((value) => value.docs.map((e) => AccountSellingData.formjson(e.data())).toList());
      emit(SelledProdects(data: data));
    });

    on<UpdateProducts>((event, emit) async{
      try {
        List<dynamic> imageUrl = event.imageList;
        if(_auth.currentUser==null)return;
      emit(Uploading());
      final uid = _auth.currentUser!.uid;
      final highlight = event.producthigh;
      Map<String, dynamic> mapData = {
        "productId": event.id,
        "productUrls": imageUrl,
        "productName": event.productName,
        "productAbout": event.productAbout,
        "highlights": highlight,
        "productType": event.productType,
        "sellerId": uid,
        "price":event.price,
        "colors": 1,
        "colorList":event.colorsList??[],
        "sizeList":event.sizeList??[],
        "size": "",
      };

      await _firestore.collection("products").doc(mapData["productId"]).update(mapData);
      final data =await _firestore.collection("products").where("sellerId",isEqualTo: uid).get().then((value) => value.docs.map((e) => AccountSellingData.formjson(e.data())).toList());
      emit(SelledProdects(data: data));
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
      log(id);
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
        "colorList":event.colorsList??[],
        "sizeList":event.sizeList??[],
        "size": "",
      };

      await _firestore.collection("products").doc(mapData["productId"]).set(mapData);
      final data =await _firestore.collection("products").where("sellerId",isEqualTo: _auth.currentUser!.uid).get().then((value) => value.docs.map((e) => AccountSellingData.formjson(e.data())).toList());
      emit(SelledProdects(data: data));
      } catch (e) {
        log("error "+e.toString());
      }
    });
  }
}
