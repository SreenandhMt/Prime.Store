import 'package:main_work/features/buying/data/data_sources/remote_data_source.dart';

import '../../domain/repositories/repository.dart';

class BuyingRepositoryImp implements BuyingRepository{
  final BuyingDataSource _dataSource;
  BuyingRepositoryImp(this._dataSource);
  @override
  Future<String> buyConfrom({required Map<String,dynamic> map,required String uid,required String id}) {
    return _dataSource.buyConfrom(map: map, uid: uid, id: id);
  }

  @override
  Future<String> buyConfromCartProduct({required List<Map<dynamic,dynamic>> map,required String uid,required String id}) {
    return _dataSource.buyConfromCartProduct(map: map, uid: uid, id: id);
  }
  
}