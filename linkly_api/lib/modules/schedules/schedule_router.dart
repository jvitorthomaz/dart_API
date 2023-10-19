import 'package:dart_application/application/routers/i_router.dart';
import 'package:dart_application/modules/schedules/controller/schedule_controller.dart';
import 'package:get_it/get_it.dart';
import 'package:shelf_router/shelf_router.dart';

class ScheduleRouter implements IRouter {
  
  @override
  void configure(Router router) {
    final scheduleController = GetIt.I.get<ScheduleController>();
    router.mount('/schedules/', scheduleController.router);
  }
}