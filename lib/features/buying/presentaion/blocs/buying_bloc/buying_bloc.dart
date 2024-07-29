
import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/hive_flutter.dart';

part 'buying_event.dart';
part 'buying_state.dart';

FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;

class BuyingBloc extends Bloc<BuyingEvent, BuyingState> {
  BuyingBloc() : super(BuyingInitial()) {
    on<GetFavoritState>((event, emit) async{
      emit(BuyingInitial());
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
        log(">>>>"+e.toString());
      }
      if(rating.isEmpty)
      {
        emit(BuyingPageState(favoritListAdded: favorit!=null,cartListAdded: data!=null));
      }else{
        emit(BuyingPageState(favoritListAdded: favorit!=null,cartListAdded: data!=null,review: rating));
      }
      
    });
    
  }
  
}
