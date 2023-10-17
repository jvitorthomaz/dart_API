// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:dart_application/entities/category.dart';
import 'package:dart_application/modules/categories/data/i_categories_repository.dart';
import 'package:dart_application/modules/categories/service/i_categories_service.dart';
import 'package:injectable/injectable.dart';

@LazySingleton(as: ICategoriesService)
class CategoriesService implements ICategoriesService {
  ICategoriesRepository repository;

  CategoriesService({
    required this.repository,
  });

  @override
  Future<List<Category>> findAll() => repository.findAll();

}
