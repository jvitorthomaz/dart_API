import 'package:dart_application/dtos/supplier_nearby_me_dto.dart';
import 'package:dart_application/entities/supplier.dart';
import 'package:dart_application/entities/supplier_service.dart';

abstract class ISupplierService {
  Future<List<SupplierNearbyMeDTO>> findNearByMe(double lat, double lng);
  Future<Supplier?> findById(int id);
  Future<List<SupplierService>> findServicesBySupplier(int supplierId);
  Future<bool> checkUserEmailsExists(String email);
  // Future<void> createUserSupplier(CreateSupplierUserViewModel model);
  // Future<Supplier> update(SupplierUpdateInputModel model);
}