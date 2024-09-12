import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:main_work/features/home/data/module/home_category_module.dart';
import 'package:main_work/features/home/domain/entities/home_entitie.dart';

import '../../module/home_module.dart';

FirebaseFirestore _firestore = FirebaseFirestore.instance;

class HomeDataSources {
  Future<List<HomeCategoryData>> homeFeedData() async {
    List<HomeCategoryData> categoryData = [];
      try {
      final shopList = await _firestore
          .collection("shop")
          .get()
          .then((value) => value.docs.map((e) => e.data()).toList());
      for (var shop in shopList) {
        List<HomeDataEntities> data = [];
        final themdata = await _firestore
            .collection("products")
            .where("sellerId", isEqualTo: shop["shopId"]).limit(6)
            .get()
            .then((value) =>
                value.docs.map((e) => HomeData.formjson(e.data())).toList());
        themdata.shuffle();
        // log(themdata.length.toString());
        String? type;
        for (int i = 0; i <themdata.length; i++) {
          if(themdata.length>4)
          {
            if (i==0||themdata[i].productType! == type) {
              type=themdata[i].productType!;
              data.add(themdata[i]);
            }  
          }
          if (themdata.length <= 4) {
            if (themdata.length==4&&themdata.length-1==i&&themdata[i].productType! == themdata[i - 1].productType!) {
              data.add(themdata[i]);
            }else 
            if (i<=3&&themdata[i].productType! == themdata[i + 1].productType!) {
              data.add(themdata[i]);
            }
          }
        }
        if(data.length>=4)
        {
          categoryData.add(HomeCategoryData(
            shopId: shop["shopId"],
            shopName: shop["shopName"],
            imageUrl: shop["image"],
            products: data));
        }
      }
      categoryData.shuffle();
      return categoryData;
      } catch (e) {
        log(e.toString());
        return categoryData;
      }
  }
}