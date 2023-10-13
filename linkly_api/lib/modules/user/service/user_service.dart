
import 'package:dart_application/application/exceptions/user_not_found_exception.dart';
import 'package:dart_application/application/helpers/jwt_helper.dart';
import 'package:dart_application/application/logger/i_logger.dart';
import 'package:dart_application/entities/user.dart';
import 'package:dart_application/modules/user/data/i_user_repository.dart';
import 'package:dart_application/modules/user/service/i_user_service.dart';
import 'package:dart_application/modules/user/view_models/user_confirm_input_model.dart';
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

  @override
  Future<User> loginWithSocial(String email, String? avatar, String socialType, String socialKey) async {
    try {
      return await userRepository.loginByEmailSocialKey(email, socialKey, socialType);
    } on UserNotFoundException catch (e) {
      log.error('Usuário não encontrando, criando um usuário', e);
      final user = User(
        email: email,
        imageAvatar: avatar,
        registerType: socialType,
        socialKey: socialKey,
        password: DateTime.now().toString(),
      );
      return await userRepository.createUser(user);
    }
  }
  
  @override
  Future<String> confirmLogin(UserConfirmInputModel inputModel) async {
    final refreshToken = JwtHelper.refreshToken(inputModel.accessToken);
    final user = User(
      id: inputModel.userId,
      refreshToken: refreshToken,
      iosToken: inputModel.iosDeviceToken,
      androidToken: inputModel.androidDeviceToken,
    );
    await userRepository.updateUserDeviceTokenAndRefreshToken(user);
    return refreshToken;
  }
}