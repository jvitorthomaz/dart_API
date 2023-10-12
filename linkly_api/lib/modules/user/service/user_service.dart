
import 'package:dart_application/application/logger/i_logger.dart';
import 'package:dart_application/entities/user.dart';
import 'package:dart_application/modules/user/data/i_user_repository.dart';
import 'package:dart_application/modules/user/service/i_user_service.dart';
import 'package:dart_application/modules/user/view_models/user_save_input_model.dart';
import 'package:injectable/injectable.dart';

@LazySingleton(as: IUserService)
class UserService implements IUserService{
  IUserRepository userRepository;
  ILogger log;

  UserService({
    required this.userRepository,
    required this.log,
  });

  @override
  Future<User> createUser(UserSaveInputModel user) {
  //Future<User> createUserDB(UserSaveInputModel user) {
    final userEntity = User(
      email: user.email,
      password: user.password,
      registerType: 'App',
      supplierId: user.supplierId
    );
    print('USER ENTITY: ${userEntity.email}\n${userEntity.password}');
    return userRepository.createUser(userEntity);
  }
  
  @override
  Future<User> loginWithEmailPassword(String email, String password, bool supplierUser) =>
    userRepository.loginWithEmailPassword(email, password, supplierUser);
}