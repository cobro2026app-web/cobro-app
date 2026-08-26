import 'package:personal/src/domain/entities/cobrador_entity.dart';

class RutasEntity {
    final bool exito;
    final String msg;
    final List<DatumREntity> data;

    RutasEntity({
        required this.exito,
        required this.msg,
        required this.data,
    });

}

class DatumREntity {
    final String id;
    final String nombre;
    final String descripcion;
    final bool habilitada;
    final DatumCEntity? cobrador;
    final int cantidadClientes;
    final DateTime createdAt;
    final DateTime updatedAt;

    DatumREntity({
        required this.id,
        required this.nombre,
        required this.descripcion,
        required this.habilitada,
        required this.cobrador,
        required this.cantidadClientes,
        required this.createdAt,
        required this.updatedAt,
    });

}
