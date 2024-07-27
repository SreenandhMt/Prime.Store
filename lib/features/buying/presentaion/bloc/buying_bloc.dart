
import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:main_work/features/buying/domain/usecase/usecase.dart';
import 'package:main_work/features/home/domain/entities/home_entitie.dart';

part 'buying_event.dart';
part 'buying_state.dart';

FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;
FirebaseAuth _auth = FirebaseAuth.instance;

class BuyingBloc extends Bloc<BuyingEvent, BuyingState> {
  final BuyingUsecase _usecase;
  BuyingBloc(this._usecase) : super(BuyingInitial()) {
    on<GetFavoritState>((event, emit) async{
      List<Map<String,dynamic>> rating=[];
      log("loged");
        final box = await Hive.openBox("favorits");
      final favorit = await box.get(event.productId);

      final cartbox = await Hive.openBox("cart");
      final data = await cartbox.get(event.productId);
      try {
        final ratingList = await _firebaseFirestore.collection("raring").doc(event.productId).collection("rating").get().then((value) => value.docs.map((e) => e.data()).toList());
      for (var ratingRow in ratingList) {
        if(ratingRow["review"]!=null)
        {
          log('>>>>>>'+ratingRow["rating"].toString());
          rating.add(ratingRow);
        }
      }
      } catch (e) {
        log(">>>>"+e.toString());
      }
      if(rating.isEmpty)
      {
        emit(BuyingPageState(favoritListAdded: favorit!=null,cartListAdded: data!=null));
      }else{
        emit(BuyingPageState(favoritListAdded: favorit!=null,cartListAdded: data!=null,review: rating));
      }
      
    });
    on<OrderPlace>((event,emit)async{
      if(_auth.currentUser==null)return;
      final uid = _auth.currentUser!.uid;
      final id = "${event.data.productId}$uid";
      final map = event.data.map!;
      await _usecase.buyConfrom(map: map as Map<String,dynamic>, uid: uid, id: id);
    });
  }
  
}
