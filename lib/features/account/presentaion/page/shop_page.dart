// ignore_for_file: invalid_use_of_visible_for_testing_member

import 'dart:developer';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:main_work/features/auth/presentaion/page/auth_page.dart';
import 'package:main_work/main.dart';

final _nameController = TextEditingController();
final _aboutController = TextEditingController();
FirebaseAuth _auth = FirebaseAuth.instance;
FirebaseFirestore _firestore = FirebaseFirestore.instance;
FirebaseStorage _storage = FirebaseStorage.instance;

class ShopPage extends StatefulWidget {
  const ShopPage({super.key});

  @override
  State<ShopPage> createState() => _ShopPageState();
}

class _ShopPageState extends State<ShopPage> {
  Map<String,dynamic>? shopData;
  XFile? image;
  String? imageUrl;
  late bool isEdit;
  @override
  void initState() {
    isEdit = _auth.currentUser!.displayName!=null&&_auth.currentUser!.displayName!.isNotEmpty;
    if(_auth.currentUser!.displayName!=null&&_auth.currentUser!.displayName!.isNotEmpty)
    {
      loadData();
      log("dd");
    }
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Container(
        padding: const EdgeInsets.all(10),
        color: theme.background,
        child: Column(
          children: [
             height10,
            imageUrl!=null&&image==null? CircleAvatar(radius: 50,backgroundImage: NetworkImage(imageUrl!),child: Align(alignment: Alignment.center,child: IconButton(onPressed: ()async{
              image = await ImagePicker.platform.getImageFromSource(source: ImageSource.gallery);
              setState(() {});
            }, icon: const Icon(Icons.add_a_photo,size: 20,)),),): image==null?IconButton(onPressed: ()async{
              image = await ImagePicker.platform.getImageFromSource(source: ImageSource.gallery);
              setState(() {});
            }, icon: const Icon(Icons.add_a_photo,size: 50,)):CircleAvatar(radius: 50,backgroundImage: FileImage(File(image!.path)),child: Align(alignment: Alignment.center,child: IconButton(onPressed: ()async{
              image = await ImagePicker.platform.getImageFromSource(source: ImageSource.gallery);
              setState(() {
                
              });
            }, icon: const Icon(Icons.add_a_photo,size: 20,)),),),
            height30,
            TextFormField(
              controller: _nameController,
              decoration: InputDecoration(
                  border:
                      OutlineInputBorder(borderRadius: BorderRadius.circular(5)),
                  hintText: "Prodect Name"),
            ),
            height20,
            TextFormField(
              controller: _aboutController,
              decoration: InputDecoration(
                  border:
                      OutlineInputBorder(borderRadius: BorderRadius.circular(5)),
                  hintText: "About"),
            ),
            height20,
            MaterialButton(onPressed: ()async{
              if(isEdit)
              {
                String? url;
                if(image!=null)
                {
                  final ref= await _storage.ref().child("shopImages/${image!.name}").putFile(File(image!.path));
                  url = await ref.ref.getDownloadURL();
                }
                final data = await _firestore.collection("shop").doc(_auth.currentUser!.uid).get().then((value) => value.data());
                await _firestore.collection("shop").doc(_auth.currentUser!.uid).set({
                  "image":url??data!["url"],
                  "shopName":_nameController.text.isEmpty?data!["shopName"]:_nameController.text,
                  "about":_aboutController.text.isEmpty?data!["about"]:_aboutController.text,
                  "shopId":data!["shopId"],
                });
              }
              if(_aboutController.text.isNotEmpty&&_nameController.text.isNotEmpty&&image!=null)
              {
                final ref= await _storage.ref().child("shopImages/${image!.name}").putFile(File(image!.path));
                final url = await ref.ref.getDownloadURL();
                await _firestore.collection("shop").doc(_auth.currentUser!.uid).set({
                  "image":url,
                  "shopName":_nameController.text,
                  "about":_aboutController.text,
                  "fashion":[],
                  "shopId":_auth.currentUser!.uid,
                });
                _auth.currentUser!.updateDisplayName("data uploaded");
              }
            },child: const Center(child: Text("Upload"),),color: Colors.green,padding: const EdgeInsets.only(top: 20,bottom: 20),)
          ],
        ),
      );
  }
  void loadData()async{
    shopData=  await _firestore.collection("shop").doc(_auth.currentUser!.uid).get().then((value) => value.data());
    _nameController.text = shopData!["shopName"];
    _aboutController.text = shopData!["about"];
    imageUrl = shopData!["image"];
    setState(() {});
  }
}