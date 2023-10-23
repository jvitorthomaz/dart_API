
import 'package:dart_application/entities/schedule_supplier_service.dart';
import 'package:dart_application/entities/supplier.dart';
/**
 * status:
 * P = pendente;
 * C = confirmando pelo prestador de serviços;
 * F = Finalizado.
 */

class Schedule {
  final int? id;
  final DateTime scheduleDate;
  final String status;
  final String name;
  // final String petName;
  final int userId;
  final Supplier supplier;
  final List<ScheduleSupplierService> services;

  Schedule({
    this.id,
    required this.scheduleDate,
    required this.status,
    required this.name,
    // required this.petName,
    required this.userId,
    required this.supplier,
    required this.services,
  });
}