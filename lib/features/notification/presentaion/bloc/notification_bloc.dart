
import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:main_work/features/notification/domain/usecase/usecase.dart';

part 'notification_event.dart';
part 'notification_state.dart';

FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;
FirebaseAuth _auth = FirebaseAuth.instance;

class NotificationBloc extends Bloc<NotificationEvent, NotificationState> {
  final NotificationUsecase _usecase;
  NotificationBloc(this._usecase) : super(NotificationInitial()) {
    on<UpdateNotification>((event, emit) async{
      try {
        if(_auth.currentUser==null) return;
       _usecase.updateNotification(status: event.status, id: event.id, data: event.data);
      } catch (e) {
        log(e.toString());
      }
    });
    on<NotificationData>((event, emit) async{
      if(_auth.currentUser==null) return;
      final data = await _firebaseFirestore.collection("orders").doc("shop").collection(_auth.currentUser!.uid).get().then((value) => value.docs.map((e) => e.data()).toList());
      List<Map<String,dynamic>?>? productList=[];
      for (var product in data) {
        final temp = await  _firebaseFirestore.collection("products").doc(product["productId"]).get().then((value) => value.data());
        productList.add(temp);
      }
      List<Map<String,dynamic>?> location =[];
      for (var row in data) {
        final loc = await _firebaseFirestore.collection("location").doc(row["uid"]).get().then((value) => value.data());
        location.add(loc!);
      }
      emit(NotificationDataState(data: data,location: location,productData: productList));
    });
  }
}
