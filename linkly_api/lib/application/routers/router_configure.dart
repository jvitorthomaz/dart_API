
import 'package:dart_application/application/routers/i_router.dart';
import 'package:dart_application/modules/user/user_router.dart';
import 'package:shelf_router/shelf_router.dart';

class RouterConfigure {
  final Router _router;
  final List<IRouter> _routers = [
    UserRouter(),
    
  ];

  RouterConfigure(this._router);

  void configure() => _routers.forEach((r) => r.configure(_router));

  
}