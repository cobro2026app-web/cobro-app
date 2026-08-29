import 'package:dartz/dartz.dart';
import 'package:personal/src/common/error/exceptions.dart';
import 'package:personal/src/common/error/failures.dart';
import 'package:personal/src/data/services/pago_service.dart';
import 'package:personal/src/domain/dto/pago_dto.dart';
import 'package:personal/src/domain/repository/pago_repo.dart';

class PagoRepoImpl implements PagoRepo {
  final PagoService pagoService;

  PagoRepoImpl({required this.pagoService});
  @override
  Future<Either<Failure, dynamic>> pagar({required PagoDto dto}) async {
    try {
      final response = await pagoService.pagar(dto: dto);

      return Right(response);
    } on ServerExceptions catch (e) {
      final failure = ServerFailure(message: e.message);
      return Left(failure);
    } catch (e) {
      final failure = ServerFailure(message: "Error inesperado: $e");
      return Left(failure);
    }
  }
}
