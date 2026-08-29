import 'package:dio/dio.dart';
import 'package:personal/src/common/error/exceptions.dart';
import 'package:personal/src/common/network/api_client.dart';
import 'package:personal/src/domain/dto/pago_dto.dart';

abstract class PagoService {
  Future<dynamic> pagar({required PagoDto dto});
}

class PagoServiceImpl implements PagoService {
  final ApiClient apiClient;

  PagoServiceImpl({required this.apiClient});
  @override
  Future<dynamic> pagar({required PagoDto dto}) async {
    try {
      await apiClient.dio.post("/pago", data: dto.toJson());
      return true;
    } on DioException catch (e) {
      throw ServerExceptions(message: e.response!.data["message"]);
    } catch (e) {
      throw Exception("Error inesperado");
    }
  }
}
