import 'package:main_work/features/buying/domain/repositories/repository.dart';

class BuyingUsecase{
  final BuyingRepository _buyingRepository;
  BuyingUsecase(this._buyingRepository);
  Future<String> buyConfrom({required Map<String,dynamic> map,required String uid,required String id}) {
    return _buyingRepository.buyConfrom(map: map, uid: uid, id: id);
  }

  Future<String> buyConfromCartProduct({required List<Map<dynamic,dynamic>> map,required String uid,required String id}) {
    return _buyingRepository.buyConfromCartProduct(map: map, uid: uid, id: id);
  }
}