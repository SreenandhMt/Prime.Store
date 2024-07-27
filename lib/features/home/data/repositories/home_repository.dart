import 'package:main_work/features/home/data/data_sources/remote/home_data_sources.dart';
import 'package:main_work/features/home/data/module/home_category_module.dart';
import 'package:main_work/features/home/domain/entities/home_category_entities.dart';
import 'package:main_work/features/home/domain/repositories/home_repository.dart';

class HomeRepositoryImp extends HomeRepository {
  HomeDataSources _dataSources;
  HomeRepositoryImp(this._dataSources);
  @override
  Future<List<HomeCategoryData>> getFeed() async{
    return await _dataSources.homeFeedData();
  }
  
}