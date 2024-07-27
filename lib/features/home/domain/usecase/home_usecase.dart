import 'package:main_work/features/home/data/module/home_category_module.dart';
import 'package:main_work/features/home/domain/entities/home_category_entities.dart';
import 'package:main_work/features/home/domain/repositories/home_repository.dart';

class HomeUsecase {
  HomeRepository _repository;
  HomeUsecase(this._repository);
  Future<List<HomeCategoryDataEntities>>? getFeed()async{
    return _repository.getFeed();
  }
}