// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: unnecessary_lambdas
// ignore_for_file: lines_longer_than_80_chars
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:get_it/get_it.dart' as _i1;
import 'package:injectable/injectable.dart' as _i2;

import '../../modules/categories/controller/categories_controller.dart' as _i26;
import '../../modules/categories/data/categories_repository.dart' as _i20;
import '../../modules/categories/data/i_categories_repository.dart' as _i19;
import '../../modules/categories/service/categories_service.dart' as _i22;
import '../../modules/categories/service/i_categories_service.dart' as _i21;
import '../../modules/schedules/data/i_schedule_repository.dart' as _i6;
import '../../modules/schedules/data/schedule_repository.dart' as _i7;
import '../../modules/schedules/service/i_schedule_service.dart' as _i9;
import '../../modules/schedules/service/schedule_service.dart' as _i10;
import '../../modules/supplier/controller/supplier_controller.dart' as _i25;
import '../../modules/supplier/data/i_supplier_repository.dart' as _i11;
import '../../modules/supplier/data/supplier_repository.dart' as _i12;
import '../../modules/supplier/service/i_supplier_service.dart' as _i23;
import '../../modules/supplier/service/supplier_service.dart' as _i24;
import '../../modules/user/controller/auth_controller.dart' as _i18;
import '../../modules/user/controller/user_controller.dart' as _i17;
import '../../modules/user/data/i_user_repository.dart' as _i13;
import '../../modules/user/data/user_repository.dart' as _i14;
import '../../modules/user/service/i_user_service.dart' as _i15;
import '../../modules/user/service/user_service.dart' as _i16;
import '../database/database_connection.dart' as _i4;
import '../database/i_database_connection.dart' as _i3;
import '../logger/i_logger.dart' as _i8;
import 'database_connection_configuration.dart' as _i5;

// ignore_for_file: unnecessary_lambdas
// ignore_for_file: lines_longer_than_80_chars
// initializes the registration of main-scope dependencies inside of GetIt
_i1.GetIt $initGetIt(
  _i1.GetIt getIt, {
  String? environment,
  _i2.EnvironmentFilter? environmentFilter,
}) {
  final gh = _i2.GetItHelper(
    getIt,
    environment,
    environmentFilter,
  );
  gh.lazySingleton<_i3.IDatabaseConnection>(
      () => _i4.DatabaseConnection(gh<_i5.DatabaseConnectionConfiguration>()));
  gh.lazySingleton<_i6.IScheduleRepository>(() => _i7.ScheduleRepository(
        connection: gh<_i3.IDatabaseConnection>(),
        log: gh<_i8.ILogger>(),
      ));
  gh.lazySingleton<_i9.IScheduleService>(
      () => _i10.ScheduleService(repository: gh<_i6.IScheduleRepository>()));
  gh.lazySingleton<_i11.ISupplierRepository>(() => _i12.SupplierRepository(
        connection: gh<_i3.IDatabaseConnection>(),
        log: gh<_i8.ILogger>(),
      ));
  gh.lazySingleton<_i13.IUserRepository>(() => _i14.UserRepository(
        connection: gh<_i3.IDatabaseConnection>(),
        log: gh<_i8.ILogger>(),
      ));
  gh.lazySingleton<_i15.IUserService>(() => _i16.UserService(
        userRepository: gh<_i13.IUserRepository>(),
        log: gh<_i8.ILogger>(),
      ));
  gh.factory<_i17.UserController>(() => _i17.UserController(
        userService: gh<_i15.IUserService>(),
        log: gh<_i8.ILogger>(),
      ));
  gh.factory<_i18.AuthController>(() => _i18.AuthController(
        userService: gh<_i15.IUserService>(),
        log: gh<_i8.ILogger>(),
      ));
  gh.lazySingleton<_i19.ICategoriesRepository>(() => _i20.CategoriesRepository(
        connection: gh<_i3.IDatabaseConnection>(),
        log: gh<_i8.ILogger>(),
      ));
  gh.lazySingleton<_i21.ICategoriesService>(() =>
      _i22.CategoriesService(repository: gh<_i19.ICategoriesRepository>()));
  gh.lazySingleton<_i23.ISupplierService>(() => _i24.SupplierService(
        repository: gh<_i11.ISupplierRepository>(),
        userService: gh<_i15.IUserService>(),
      ));
  gh.factory<_i25.SupplierController>(() => _i25.SupplierController(
        service: gh<_i23.ISupplierService>(),
        log: gh<_i8.ILogger>(),
      ));
  gh.factory<_i26.CategoriesController>(
      () => _i26.CategoriesController(service: gh<_i21.ICategoriesService>()));
  return getIt;
}
