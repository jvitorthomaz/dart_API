import 'dart:async';
import 'dart:convert';
import 'package:dart_application/application/exceptions/user_exists_exception.dart';
import 'package:dart_application/application/logger/i_logger.dart';
import 'package:dart_application/modules/user/service/i_user_service.dart';
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

   @Route.post('/register')
   Future<Response> saveUser(Request request) async { 
    try {
      final userModel = UserSaveInputModel.requestMapping(await request.readAsString());
      print('userModel: \n${userModel.email}\n ${userModel.password}');
      await userService.createUser(userModel);
      return Response.ok(
        jsonEncode({'message': 'cadastro realizado com sucesso'})
      );

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