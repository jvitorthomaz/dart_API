
import 'package:dart_application/application/database/i_database_connection.dart';
import 'package:dart_application/application/exceptions/database_exception.dart';
import 'package:dart_application/application/logger/i_logger.dart';
import 'package:dart_application/entities/category.dart';
import 'package:dart_application/modules/categories/data/i_categories_repository.dart';
import 'package:injectable/injectable.dart';
import 'package:mysql1/mysql1.dart';

@LazySingleton(as: ICategoriesRepository)
class CategoriesRepository implements ICategoriesRepository{
  IDatabaseConnection connection;
  ILogger log;
  
  CategoriesRepository({
    required this.connection,
    required this.log,
  });

  @override
  Future<List<Category>> findAll() async {
    MySqlConnection? conn;

    try {
      conn = await connection.openConnection();
      final result = await conn.query('select * from categorias_fornecedor');

      if (result.isNotEmpty) {
        return result.map((e) => Category(
          id: e['id'],
          name: e['nome_categoria'],
          type: e['tipo_categoria']
        )).toList();
        
      }

      return [];

    } on MySqlException catch (e, s) {
      log.error('Erro ao buscar as categorias do fornecedor', e, s);
      throw DatabaseException();

    } finally {
      await conn?.close();

    }
  }
}
