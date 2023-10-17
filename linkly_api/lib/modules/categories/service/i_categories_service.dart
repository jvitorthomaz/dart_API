import 'package:dart_application/entities/category.dart';

abstract class ICategoriesService {
  Future<List<Category>> findAll();
}