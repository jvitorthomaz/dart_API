
import 'package:dart_application/application/routers/i_router.dart';
import 'package:dart_application/modules/teste/teste_controller.dart';
import 'package:shelf_router/src/router.dart';

class TesteRouter implements IRouter{

  @override
  void configure(Router router) {
    router.mount('/hello/', TesteController().router);
  }
 
  
}