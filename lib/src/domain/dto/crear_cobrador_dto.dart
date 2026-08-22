class CrearCobradorDto {
  final String nombre;
  final String apellido;
  final String documento;
  final String telefono;
  final String username;
  final String password;

  CrearCobradorDto({
    required this.nombre,
    required this.apellido,
    required this.documento,
    required this.telefono,
    required this.username,
    required this.password,
  });

  Map<String, dynamic> toJson() => {
    "nombre": nombre,
    "apellido": apellido,
    "documento": documento,
    "telefono": telefono,
    "username": username,
    "password": password,
  };
}
