
import 'dart:developer';

import 'package:hive/hive.dart';
import 'package:main_work/features/cart/data/module/cart_data_module.dart';
import 'package:main_work/features/cart/domain/entities/cart_entities.dart';

class CartLocalData {
  Future<List<CartEntities>> getCartData()async{
    try {
      final box = await Hive.openBox("cart");
    final value = box.values.toList();
    // log(value.toString());
    return value.map((e) => CartDataClass.formjson(e)).toList();
    } catch (e) {
      log(e.toString());
      return [];
    }
  }
  Future<List<CartEntities>> addCartData(Map map)async{
    try {
      final box = await Hive.openBox("cart");
    await box.put(map["productId"], map);
    return await getCartData();
    } catch (e) {
      log(e.toString());
      
      return [];
    }
  }
  Future<List<CartEntities>> deleteCartData(String productId)async{
    try {
      final box = await Hive.openBox("cart");
    await box.delete(productId);
    return await getCartData();
    } catch (e) {
      log(e.toString());
      return [];
    }
  }
}