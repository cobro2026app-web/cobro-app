class ClienteEntity {
  final bool exito;
  final String msg;
  final List<DatumClEntity> data;

  ClienteEntity({required this.exito, required this.msg, required this.data});
}

class DatumClEntity {
  final String id;
  final String nombres;
  final String rutaId;
  final String apellidos;
  final String cedula;
  final String telefono;
  final String whatsapp;
  final String direccion;
  final String descripcionDireccion;
  final String estado;
  final int totalPrestado;

  DatumClEntity({
    required this.id,
    required this.nombres,
    required this.rutaId,
    required this.apellidos,
    required this.cedula,
    required this.telefono,
    required this.whatsapp,
    required this.direccion,
    required this.descripcionDireccion,
    required this.estado,
    required this.totalPrestado
  });
}
