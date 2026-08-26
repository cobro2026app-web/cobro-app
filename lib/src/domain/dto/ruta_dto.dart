class RutaDto {
  final String? nombre;
  final String? descripcion;
  final String? cobradorId;
  final bool? habilitada;

  RutaDto({this.nombre, this.descripcion, this.cobradorId, this.habilitada});

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    if (nombre != null) {
      data['nombre'] = nombre;
    }
    if (descripcion != null) {
      data['descripcion'] = descripcion;
    }
    if (cobradorId != null) {
      data['cobradorId'] = cobradorId;
    }
    if (habilitada != null) {
      data['habilitada'] = habilitada;
    }
    return data;
  }
}
