import 'package:personal/src/domain/dto/prestamo_fecha_dto.dart';

class CrearPrestamoDto {
  final String usuarioId;
  final int monto;
  final int interes;
  final int numeroCuotas;
  final int montoInteres;
  final int valorCuota;
  final String frecuencia;
  final String fechaInicio;
  final String fechaFin;
  final List<PrestamoFechaDto>? fechas;

  CrearPrestamoDto({
    required this.usuarioId,
    required this.monto,
    required this.interes,
    required this.numeroCuotas,
    required this.montoInteres,
    required this.valorCuota,
    required this.frecuencia,
    required this.fechaInicio,
    required this.fechaFin,
    this.fechas,
  });

  Map<String, dynamic> toJson() {
    return {
      'usuarioId': usuarioId,
      'monto': monto,
      'interes': interes,
      'numeroCuotas': numeroCuotas,
      'montoInteres': montoInteres,
      'valorCuota': valorCuota,
      'frecuencia': frecuencia,
      'fechaInicio': fechaInicio,
      'fechaFin': fechaFin,
      'fechas': fechas?.map((e) => e.toJson()).toList(),
    };
  }
}
