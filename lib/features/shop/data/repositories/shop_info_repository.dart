import 'package:main_work/features/account/data/data_sources/remote/remote_data_source.dart';

import '../../domain/repositories/shop_info_repository.dart';

class AccountRepositoryImp implements AccountRepository {
  final AccountRemoteDataSource _dataSource;
  AccountRepositoryImp(this._dataSource);
  
}