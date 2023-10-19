
import 'package:dart_application/dtos/supplier_nearby_me_dto.dart';
import 'package:dart_application/entities/category.dart';
import 'package:dart_application/entities/supplier.dart';
import 'package:dart_application/entities/supplier_service.dart' as entity;
import 'package:dart_application/modules/supplier/data/i_supplier_repository.dart';
import 'package:dart_application/modules/supplier/service/i_supplier_service.dart';
import 'package:dart_application/modules/supplier/view_models/create_supplier_user_view_model.dart';
import 'package:dart_application/modules/supplier/view_models/update_supplier__input_model.dart';
import 'package:dart_application/modules/user/service/i_user_service.dart';
import 'package:dart_application/modules/user/view_models/user_save_input_model.dart';
import 'package:injectable/injectable.dart';


@LazySingleton(as: ISupplierService)
class SupplierService implements ISupplierService{
  final ISupplierRepository repository;
  final IUserService userService;

  static const DISTANCE = 5;

  SupplierService({
    required this.repository,
    required this.userService,
  });

  @override
  Future<List<SupplierNearbyMeDTO>> findNearByMe(double lat, double lng) =>
    repository.findNearByPosition(lat, lng, DISTANCE);

  @override
  Future<Supplier?> findById(int id) => repository.findById(id);

  @override
  Future<List<entity.SupplierService>> findServicesBySupplier(int supplierId) =>
      repository.findServicesBySupplierId(supplierId);

  @override
  Future<bool> checkUserEmailsExists(String email) => repository.checkUserEmailExists(email);

  @override
  Future<void> createUserSupplier(CreateSupplierUserViewModel model) async {
    final supplierEntity = Supplier(
      name: model.supplierName, 
      category: Category(id: model.category)
    );

    final supplierId = await repository.saveSupplier(supplierEntity);

    final userInputModel = UserSaveInputModel(
      email: model.email,
      password: model.password,
      supplierId: supplierId,
    );

    await userService.createUser(userInputModel);
  }

  @override
  Future<Supplier> update(UpdateSupplierInputModel model) async {
    var supplier = Supplier(
      id: model.supplierId,
      name: model.name,
      address: model.address,
      lat: model.lat,
      lng: model.lng,
      logo: model.logo,
      phone: model.phone,
      category: Category(id: model.categoryId)
    );

    return await repository.update(supplier);
  }
}
