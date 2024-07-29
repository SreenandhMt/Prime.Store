abstract class BuyingRepository {
  Future<String> buyConfrom({required Map<String,dynamic> map,required String uid,required String id});
  Future<String> buyConfromCartProduct({required List<Map<dynamic,dynamic>> map,required String uid,required String id});
}