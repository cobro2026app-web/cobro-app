import 'package:personal/src/data/model/cobrador_model.dart';
import 'package:personal/src/domain/entities/ruta_entity.dart';

class RutaModel extends RutasEntity {
  RutaModel({required super.exito, required super.msg, required super.data});

  factory RutaModel.fromJson(Map<String, dynamic> json) => RutaModel(
    exito: json["exito"],
    msg: json["msg"],
    data: List<DatumRModel>.from(
      json["data"].map((x) => DatumRModel.fromJson(x)),
    ),
  );
}

class DatumRModel extends DatumREntity {
  DatumRModel({
    required super.id,
    required super.nombre,
    required super.descripcion,
    required super.habilitada,
    super.cobrador,
    required super.cantidadClientes,
    required super.createdAt,
    required super.updatedAt,
  });

  factory DatumRModel.fromJson(Map<String, dynamic> json) => DatumRModel(
    id: json["id"],
    nombre: json["nombre"],
    descripcion: json["descripcion"],
    habilitada: json["habilitada"],
    cobrador: json["cobrador"] == null
        ? DatumCModel.fromJson({})
        : DatumCModel.fromJson(json["cobrador"]),
    cantidadClientes: json["cantidadClientes"],
    createdAt: DateTime.parse(json["createdAt"]),
    updatedAt: DateTime.parse(json["updatedAt"]),
  );
}
