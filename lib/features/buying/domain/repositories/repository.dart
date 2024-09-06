abstract class BuyingRepository {
  Future<String> buyConfrom({required Map<String,dynamic> map,required String uid,required String id,required String selectedColor,required String selectedSize,required String itemCount});
  Future<String> buyConfromCartProduct({required List<Map<dynamic,dynamic>> map,required String uid,required String id});
}