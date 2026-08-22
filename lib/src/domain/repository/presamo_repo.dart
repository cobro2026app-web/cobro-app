import 'package:dartz/dartz.dart';
import 'package:personal/src/common/error/failures.dart';
import 'package:personal/src/domain/dto/crear_prestamo_dto.dart';

abstract class PresamoRepo {
  Future<Either<Failure, dynamic>> crear({required CrearPrestamoDto dto});
}