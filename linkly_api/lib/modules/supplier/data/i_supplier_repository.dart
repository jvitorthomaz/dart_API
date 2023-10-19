import 'package:dart_application/dtos/supplier_nearby_me_dto.dart';
import 'package:dart_application/entities/supplier.dart';
import 'package:dart_application/entities/supplier_service.dart';

abstract class ISupplierRepository {
  Future<List<SupplierNearbyMeDTO>> findNearByPosition(double lat, double lng, int distance);
  Future<Supplier?> findById(int id);
  Future<List<SupplierService>> findServicesBySupplierId(int supplierId);
  Future<bool> checkUserEmailExists(String email);
  Future<int> saveSupplier(Supplier supplier);
  Future<Supplier> update(Supplier supplier);
}
