class CrearClienteDto {
  final String nombres;
  final String apellidos;
  final String cedula;
  final String telefono;
  final String whatsapp;
  final String direccion;
  final String descripcionDireccion;

  CrearClienteDto({
    required this.nombres,
    required this.apellidos,
    required this.cedula,
    required this.telefono,
    required this.whatsapp,
    required this.direccion,
    required this.descripcionDireccion,
  });

  Map<String, dynamic> toJson() => {
    "nombres": nombres,
    "apellidos": apellidos,
    "cedula": cedula,
    "telefono": telefono,
    "whatsapp": whatsapp,
    "direccion": direccion,
    "descripcionDireccion": descripcionDireccion,
  };
}
