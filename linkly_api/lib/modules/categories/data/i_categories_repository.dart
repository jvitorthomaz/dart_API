import 'package:dart_application/entities/category.dart';

abstract class ICategoriesRepository {
  Future<List<Category>> findAll();
}