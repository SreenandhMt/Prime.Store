import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:location/location.dart';

import 'package:main_work/features/home/domain/entities/home_entitie.dart';

import '../../features/buying/presentaion/page/order_confrom.dart';
import '../../features/cart/domain/entities/cart_entities.dart';

double? _latitude,_longitude;
FirebaseAuth _auth = FirebaseAuth.instance;
FirebaseFirestore _firestore = FirebaseFirestore.instance;
bool isLocationAddad=false;

class LocationRequest extends StatelessWidget {
  const LocationRequest({
    Key? key,
    this.cart,
    this.home,
  }) : super(key: key);
  final List<CartEntities>? cart;
  final HomeDataEntities? home;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: check(),
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
              );
            }
          // Navigator.pop(context);
        }
        return SizedBox(
          height: 300,
          child: Column(
            children: [
              MaterialButton(onPressed: ()async{
                await getLocation();
                await storeLocation();
                // ignore: use_build_context_synchronously
                Navigator.of(context).pop();
              },child: const Center(child: Text("Set this Location"),),)
            ],
          ),
        );
      }
    );
  }
  Future<void> getLocation() async {
    Location location = Location();

    bool _serviceEnabled;
    PermissionStatus _permissionGranted;
    LocationData _locationData;

    _serviceEnabled = await location.serviceEnabled();
    if (!_serviceEnabled) {
      _serviceEnabled = await location.requestService();
      if (!_serviceEnabled) {
        return;
      }
    }

    _permissionGranted = await location.hasPermission();
    if (_permissionGranted == PermissionStatus.denied) {
      _permissionGranted = await location.requestPermission();
      if (_permissionGranted != PermissionStatus.granted) {
        return;
      }
    }
    _locationData = await location.getLocation();
    if(_locationData.latitude!=null&&_locationData.longitude!=null) {
      _latitude= _locationData.latitude;
      _longitude= _locationData.longitude;
      return;
    }else{
      await getLocation();
    }
  }

  Future<bool> storeLocation()async{
    if(_auth.currentUser==null)return false;
    final uid = _auth.currentUser!.uid;
    await _firestore.collection("location").doc(uid).set({"locX":_latitude,"locY":_longitude});
    return true;
  }
  Future<bool> check()async{
    try {
      final uid = _auth.currentUser!.uid;
    final st = await _firestore
            .collection("location")
            .doc(uid)
            .get()
            .then((value) => value.data());
    if(st==null)
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
