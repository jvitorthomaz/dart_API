import 'dart:async';
import 'dart:convert';
import 'package:dart_application/application/exceptions/request_validation_exception.dart';
import 'package:dart_application/application/exceptions/user_exists_exception.dart';
import 'package:dart_application/application/exceptions/user_not_found_exception.dart';
import 'package:dart_application/application/helpers/jwt_helper.dart';
import 'package:dart_application/application/logger/i_logger.dart';
import 'package:dart_application/entities/user.dart';
import 'package:dart_application/modules/user/service/i_user_service.dart';
import 'package:dart_application/modules/user/view_models/login_view_model.dart';
import 'package:dart_application/modules/user/view_models/user_save_input_model.dart';
import 'package:injectable/injectable.dart';
import 'package:shelf/shelf.dart';
import 'package:shelf_router/shelf_router.dart';

part 'auth_controller.g.dart';

@Injectable()
class AuthController {

  IUserService userService;
  ILogger log;

  AuthController({
    required this.userService,
    required this.log,
  });

  @Route.post('/')
  Future<Response> login(Request request) async {
    try {
      final loginViewModel = LoginViewModel(await request.readAsString());

      User user;

      if (!loginViewModel.socialLogin) {
        //loginViewModel.loginEmailValidate();
        user = await userService.loginWithEmailPassword(
          loginViewModel.login, loginViewModel.password!, loginViewModel.supplierUser
        );
      } 
      else {
        user = User();
        // loginViewModel.loginSocialValidate();
        // // Social Login (Facebook, google, apple, etc...)
        // user = await userService.loginWithSocial(
        //   loginViewModel.login,
        //   loginViewModel.avatar,
        //   loginViewModel.socialType!,
        //   loginViewModel.socialKey!
        // );
      }
      print('ID: ${user.id}');
      return Response.ok( 
        jsonEncode({ 
          'access_token': JwtHelper.generateJWT(user.id!, user.supplierId),
        })
      );

    } on UserNotFoundException {
      return Response.forbidden(
          jsonEncode({'message': 'Usuário ou senha inválidos'}));

    } on RequestValidationException catch (e, s) {
      log.error('Erro de parametros obrigatorios não enviados', e, s);
      return Response(400, body: jsonEncode(e.errors));

    } catch (e, s) {
      log.error('Erro ao fazer login', e, s);
      return Response.internalServerError(
        body: jsonEncode({
          'message': 'Erro ao realizar login',
        })
      );
    }

  }

   @Route.post('/register')
   Future<Response> saveUser(Request request) async { 
    try {
      final userModel = UserSaveInputModel.requestMapping(await request.readAsString());
      print('userModel: \n${userModel.email}\n ${userModel.password}');
      await userService.createUser(userModel);
      // await userService.createUserDB(userModel);
      return Response.ok(
        jsonEncode({'message': 'cadastro realizado com sucesso'}));

    } on UserExistsException {
      return Response(
        400,
        body: jsonEncode({'message': 'Usuario ja cadastrado na base de dados'})
      );

    } catch (e) {
      log.error('Erro ao cadastrar usuario', e);
      return Response.internalServerError();
    }
   }

   Router get router => _$AuthControllerRouter(this);
}
