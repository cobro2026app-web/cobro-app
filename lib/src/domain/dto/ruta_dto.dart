


class RutaDto {
    final String nombre;
    final String descripcion;
    final String cobradorId;
    final bool habilitada;

    RutaDto({
        required this.nombre,
        required this.descripcion,
        required this.cobradorId,
        required this.habilitada,
    });

   

    Map<String, dynamic> toJson() => {
        "nombre": nombre,
        "descripcion": descripcion,
        "cobradorId": cobradorId,
        "habilitada": habilitada,
    };
}
