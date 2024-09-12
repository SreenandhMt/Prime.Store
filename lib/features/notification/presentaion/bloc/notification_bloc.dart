
import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:main_work/features/notification/domain/usecase/usecase.dart';

import '../../../../core/main_data/module/address_module.dart';
import '../../../account/data/module/account_orders_module.dart';
import '../../../account/domain/entities/account_orders_entities.dart';

part 'notification_event.dart';
part 'notification_state.dart';

FirebaseFirestore _firestore = FirebaseFirestore.instance;
FirebaseAuth _auth = FirebaseAuth.instance;

class NotificationBloc extends Bloc<NotificationEvent, NotificationState> {
  final NotificationUsecase _usecase;
  NotificationBloc(this._usecase) : super(NotificationInitial()) {
    on<UpdateNotification>((event, emit) async{
      try {
        if(_auth.currentUser==null) return;
      //  _usecase.updateNotification(status: event.status, id: event.id, data: event.data);
      } catch (e) {
        log(e.toString());
      }
    });
    on<NotificationData>((event, emit) async{
      if(_auth.currentUser==null) return;
      final orders = await _firestore.collection("orders").doc("shop").collection(_auth.currentUser!.uid).get().then((value) => value.docs.map((e) => e.data()).toList());
      // List<Map<String,dynamic>> productList=[];
      List<AccountOrdersDataEntities> location =[];
      for (var product in orders) {
        final shopLocation = await  _firestore.collection("shop").doc(product["sellerId"]).collection("more_data").doc("address").get().then((value) => AddressData.formjson(value.data()!));
        final temp = await  _firestore.collection("products").doc(product["productId"]).get().then((value) => value.data()!);
        final loc = await _firestore.collection("address").doc(product["addressid"]).get().then((value) => AccountOrdersData.formjson(product,temp,AddressData.formjson(value.data()!),shopLocation));
        location.add(loc);
      }
      emit(NotificationDataState(data: location));
    });
  }
}
