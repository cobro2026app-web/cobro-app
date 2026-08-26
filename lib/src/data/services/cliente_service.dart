import 'package:dio/dio.dart';
import 'package:personal/src/common/error/exceptions.dart';
import 'package:personal/src/common/network/api_client.dart';
import 'package:personal/src/data/model/cliente_model.dart';
import 'package:personal/src/domain/dto/crear_cliente_dto.dart';

abstract class ClienteService {
  Future<ClienteModel> listar();

  Future<dynamic> crear({required CrearClienteDto dto});
  Future<DatumClModel> obtenerCliente({required String id});
}

class ClienteServiceImpl implements ClienteService {
  final ApiClient apiClient;

  ClienteServiceImpl({required this.apiClient});

  @override
  Future<ClienteModel> listar() async {
    try {
      final response = await apiClient.dio.get('/cliente');

      return ClienteModel.fromJson(response.data);
    } on DioException catch (e) {
      throw ServerExceptions(message: e.response!.data["message"]);
    } catch (e) {
      throw Exception("Error inesperado");
    }
  }

  @override
  Future<dynamic> crear({required CrearClienteDto dto}) async {
    try {
      final response = await apiClient.dio.post('/cliente', data: dto.toJson());

      return response.data;
    } on DioException catch (e) {
      throw ServerExceptions(message: e.response!.data["message"]);
    } catch (e) {
      throw Exception("Error inesperado");
    }
  }

  @override
  Future<DatumClModel> obtenerCliente({required String id}) async {
    try {
      final r = await apiClient.dio.get("/cliente/$id");
      return DatumClModel.fromJson(r.data["data"]);
    } on DioException catch (e) {
      throw ServerExceptions(message: e.response!.data["message"]);
    } catch (e) {
      throw Exception("Error inesperado");
    }
  }
}
