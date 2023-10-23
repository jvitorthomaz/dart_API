import 'package:dart_application/entities/schedule.dart';
import 'package:dart_application/modules/schedules/view_models/schedule_save_input_model.dart';

abstract class IScheduleService {
  Future<void> scheduleService(ScheduleSaveInputModel model);
  Future<void> changeStatus(String status, int scheduleId);
  Future<List<Schedule>> findAllSchedulesByUser(int userId);
  Future<List<Schedule>> findAllSchedulesByUserSupplier(int userId);
  
}
