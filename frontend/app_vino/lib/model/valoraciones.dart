class Valoraciones {
  final int valoracion;
  final String comentario;
  final String fechaCreacion;
  final String fechaModificacion;
  final String vinoId; // Aquí está el guión bajo
  final String usuarioId;

  Valoraciones({
    required this.valoracion,
    required this.comentario,
    required this.fechaCreacion,
    required this.fechaModificacion,
    required this.vinoId, // Aquí también
    required this.usuarioId,

  });
    // Getter para el campo modelo
  int get getValoracion => valoracion;
  // Getter para el campo modelo
  String get getComentario => comentario;

  // Getter para el campo pais
  String  get getFechaCreacion => fechaCreacion;

  // Getter para el campo region
  String  get getFechaModificacion => fechaModificacion;

  // Getter para el campo do_
  String get getVinoId => vinoId;

  // Getter para el campo imagen
  String get getUsuarioId => usuarioId;

  factory Valoraciones.fromJson(Map<String, dynamic> json) {
    return Valoraciones(
      valoracion: json['valoracion'],
      comentario: json['comentario'],
      fechaCreacion: json['fecha_creacion'],
      fechaModificacion: json['fecha_modificacion'],
      usuarioId: json['usuario_id'],
      vinoId: json['modelo_vino_id']

    );
  }
}
