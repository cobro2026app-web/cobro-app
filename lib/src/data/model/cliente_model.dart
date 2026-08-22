import 'package:personal/src/domain/entities/cliente_entity.dart';

class ClienteModel extends ClienteEntity {
  ClienteModel({required super.exito, required super.msg, required super.data});

  factory ClienteModel.fromJson(Map<String, dynamic> json) => ClienteModel(
    exito: json["exito"],
    msg: json["msg"],
    data: List<DatumClModel>.from(
      json["data"].map((x) => DatumClModel.fromJson(x)),
    ),
  );
}

class DatumClModel extends DatumClEntity {
  DatumClModel({
    required super.id,
    required super.nombres,
    required super.apellidos,
    required super.cedula,
    required super.telefono,
    required super.whatsapp,
    required super.direccion,
    required super.descripcionDireccion,
    required super.estado,
  });

  factory DatumClModel.fromJson(Map<String, dynamic> json) => DatumClModel(
    id: json["id"],
    nombres: json["nombres"],
    apellidos: json["apellidos"],
    cedula: json["cedula"],
    telefono: json["telefono"],
    whatsapp: json["whatsapp"],
    direccion: json["direccion"],
    descripcionDireccion: json["descripcionDireccion"],
    estado: json["estado"],
  );
}
