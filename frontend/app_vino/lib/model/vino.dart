class Vino {
  final String vinoId;
  final String modelo;
  final String pais;
  final String region;
  final String do_; // Aquí está el guión bajo
  final List<String> variedades;
  final String url;
  final String imagen;

  Vino({
    required this.vinoId,
    required this.modelo,
    required this.pais,
    required this.region,
    required this.do_, // Aquí también
    required this.variedades,
    required this.url,
    required this.imagen,
  });
    // Getter para el campo modelo
  String get getVinoId => vinoId;
  // Getter para el campo modelo
  String get getModelo => modelo;

  // Getter para el campo pais
  String get getPais => pais;

  // Getter para el campo region
  String get getRegion => region;

  // Getter para el campo do_
  String get getDO => do_;

  // Getter para el campo variedades
  List<String> get getVariedades => variedades;

  // Getter para el campo url
  String get getUrl => url;

  // Getter para el campo imagen
  String get getImagen => imagen;

  factory Vino.fromJson(Map<String, dynamic> json) {
    return Vino(
      vinoId: json['_id'],
      modelo: json['modelo'],
      pais: json['datos_tecnicos']['pais'],
      region: json['datos_tecnicos']['region'],
      do_: json['datos_tecnicos']['do'], // Corregido aquí
      variedades: List<String>.from(json['datos_tecnicos']['variedades']),
      url: json['url'],
      imagen: json['imagen'],
    );
  }
}


/*
class Vino {
  final String modelo;
  final String pais;
  final String region;
  final String do_;
  final List<String> variedades;
  final String url;
  final String imagen;

  Vino({
    required this.modelo,
    required this.pais,
    required this.region,
    required this.do_,
    required this.variedades,
    required this.url,
    required this.imagen,
  });

  factory Vino.fromJson(Map<String, dynamic> json) {
    return Vino(
      modelo: json['modelo'],
      pais: json['datos_tecnicos']['pais'],
      region: json['datos_tecnicos']['region'],
      do_: json['datos_tecnicos']['do'],
      variedades: List<String>.from(json['datos_tecnicos']['variedades']),
      url: json['url'],
      imagen: json['imagen'],
    );
  }
}
*/
