import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:main_work/features/account/data/module/account_orders_module.dart';
import 'package:main_work/features/account/domain/entities/account_favorit_entities.dart';
import 'package:main_work/features/account/domain/entities/account_orders_entities.dart';
import 'package:main_work/main.dart';

const height10 = SizedBox(height: 10,);
const height20 = SizedBox(height: 20,);
const height30 = SizedBox(height: 30,);
Map<String, dynamic>? ratingResult;
final reviewController = TextEditingController();
double rating = 2.0;

FirebaseAuth _auth = FirebaseAuth.instance;
FirebaseFirestore _firestore =FirebaseFirestore.instance;

Widget ratingWidget(BuildContext context,AccountOrdersDataEntities product){
  final size = MediaQuery.of(context).size;
  return FutureBuilder(
    future: chack(product),
    builder: (context, snapshot) {
      if(snapshot.data==null)
      {
        return const Center(child: CircularProgressIndicator(),);
      }
      return BottomSheet(
        dragHandleSize: Size(size.width*0.9, 200),
        backgroundColor: theme.background,
        enableDrag: false,
        onClosing: (){}, builder: (context) => SizedBox(
          // height: size.width*0.89,
          child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            height10,
            Container(width: size.width*0.3,height: 10,decoration: BoxDecoration(borderRadius: BorderRadius.circular(3),color: Colors.grey),),
            height10,
            Text("What is Your Rate?",style: GoogleFonts.radioCanada(fontSize:14),),
            RatingBar.builder(ignoreGestures: snapshot.data!,itemCount: 5,initialRating: ratingResult==null?2:ratingResult!["rating"]??2,itemBuilder: (context, index) => const Icon(Icons.star_border_rounded,size: 40,color: Colors.yellow,), onRatingUpdate: (value) =>rating=value,),
            height10,
            Text("Please share your opinion\nabout the prodect",textAlign: TextAlign.center,style: GoogleFonts.radioCanada(fontSize:18),),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: LimitedBox(
                maxWidth: size.width*0.9,
                child: TextFormField(controller: reviewController,keyboardType: snapshot.data!?TextInputType.none:TextInputType.text,decoration: InputDecoration(border: OutlineInputBorder(borderRadius: BorderRadius.circular(10),borderSide: const BorderSide(color: Colors.green)),hintText: "Review"),maxLength: 50,maxLines: 4,),
              ),
            ),
            if(!snapshot.data!)
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: GestureDetector(onTap: ()async{
                if(snapshot.data==true)return;
                final data = await _firestore.collection("products").doc(product.productId!).get().then((value) => value.data());
                // final map = {
                //         "productId": product.productId,
                //         "productUrls": product.map!.productUrls,
                //         "productName": product.map!.productName,
                //         "productAbout": product.map!["productAbout"],
                //         "highlights": product.map!["highlights"],
                //         "productType": data!["productType"],
                //         "sellerId": product.sellerId,
                //         "colors": 1,
                //         "colorList": product.map!["colorList"],
                //         "sizeList": product.map!["sizeList"],
                //         "size": "",
                //         "rate1":rating>=1&&rating<=1.9?1+(data["rate1"]??0.0): data["rate1"] ?? 0.0,
                //         "rate2":rating>=2&&rating<=2.9?1+(data["rate2"]??0.0): data["rate2"] ?? 0.0,
                //         "rate3":rating>=3&&rating<=3.9?1+(data["rate3"]??0.0): data["rate3"] ?? 0.0,
                //         "rate4":rating>=4&&rating<=4.9?1+(data["rate4"]??0.0): data["rate4"] ?? 0.0,
                //         "rate5":rating>=5&&rating<=5.9?1+(data["rate5"]??0.0): data["rate5"] ?? 0.0,
                //       };
                if(reviewController.text.isNotEmpty)
                {
                  await _firestore.collection("raring").doc(product.productId!).collection("rating").doc(_auth.currentUser!.uid).set({"uid":_auth.currentUser!.uid,"rating":rating,"review":reviewController.text});
                }else{
                  await _firestore.collection("raring").doc(product.productId!).collection("rating").doc(_auth.currentUser!.uid).set({"uid":_auth.currentUser!.uid,"rating":rating});
                }
                // await _firestore
                //           .collection("products")
                //           .doc(product.productId!)
                //           .set(map);
                // ignore: use_build_context_synchronously
                Navigator.pop(context);
              },child: Container(width:double.infinity,height: size.width*0.14,decoration:BoxDecoration(color:  Colors.grey,borderRadius: BorderRadius.circular(10)),child: Center(child: Text("Submit",style: GoogleFonts.pottaOne(fontSize:18),)),)),
            ),
          ],
            ),
        ),);
    }
  );
}

Future<bool> chack(AccountOrdersDataEntities product)async{
  try {
    final result = await _firestore.collection("raring").doc(product.productId!).collection("rating").doc(_auth.currentUser!.uid).get().then((value) => value.data());
    if(result==null)
    {
      return false;
    }else{
      ratingResult=result;
      reviewController.text=result["review"]??"";
      return true;
    }
  } catch (e) {
   return false; 
  }
}