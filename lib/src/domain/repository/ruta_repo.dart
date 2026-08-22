import 'package:dartz/dartz.dart';
import 'package:personal/src/common/error/failures.dart';
import 'package:personal/src/domain/dto/ruta_dto.dart';
import 'package:personal/src/domain/entities/ruta_entity.dart';

abstract class RutaRepo {

  Future<Either<Failure, dynamic>> crear({required RutaDto dto});

  Future<Either<Failure, RutasEntity>> listar();
}