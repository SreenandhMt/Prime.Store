import 'package:main_work/features/home/data/module/home_category_module.dart';
import 'package:main_work/features/home/domain/entities/home_category_entities.dart';

abstract class HomeRepository {
  Future<List<HomeCategoryDataEntities>> getFeed();
}