import 'package:app_vino/model/valoraciones.dart';
import 'package:app_vino/model/vino.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class FetchApi {

  final String baseUrl = dotenv.env['API_URL']!;
  
  Future<List<Vino>> getAllWines() async {
    List<Vino> listaVinos = [];

    final response = await http.get(Uri.parse('$baseUrl/modelo/'));
    if (response.statusCode == 200) {
      final List<dynamic> parsedJson =
          jsonDecode(utf8.decode(response.bodyBytes));

      listaVinos = parsedJson.map((json) => Vino.fromJson(json)).toList();
    } else {
      throw Exception('Error, no se puede conectar con la api');
    }
    return listaVinos;
  }

  Future<bool> createRating(Map<String, dynamic> requestBody) async {
    bool isRating = false;
   // final url = Uri.parse('http://192.168.1.37:8000/api/api/valoraciones/create/');
  final url = Uri.parse('$baseUrl/api/valoraciones/create/');
    // El cuerpo de la solicitud
    /*
  final Map<String, dynamic> requestBody = {
    "valoracion": 4,
    "comentario": "sdfaRA@phone.es",
    "modelo_vino_id": "11",
    "usuario_id": "1234"
  };
  */

    // Encabezados de la solicitud
    final Map<String, String> headers = {
      'Content-Type': 'application/json; charset=UTF-8',
    };

    try {
      // Enviar la solicitud POST
      final response = await http.post(
        url,
        headers: headers,
        body: jsonEncode(requestBody),
      );

      if (response.statusCode == 201) {
        // La solicitud fue exitosa
        final responseData = jsonDecode(response.body);
        print('Valoración registrada: ${responseData['valoracion']}');
        isRating = true;
      } else {
        // La solicitud falló
        print('Error: ${response.statusCode}');
        print('Response: ${response.body}');
      }
    } catch (e) {
      // Manejo de errores
      print('Error: $e');
    }
    return isRating;
  }

  Future<bool> createUser(Map<String, dynamic> requestBody) async {
    bool isRegister = false;
    
    final url = Uri.parse('$baseUrl/api/usuarios/create/');
    // final url = Uri.parse('http://192.168.1.37:8000/api/api/usuarios/create/');
    // El cuerpo de la solicitud
    /*
  final Map<String, dynamic> requestBody = {
    "id": "sdfd",
    "email": "gdsjhs@wer.es",
    "password": "adf",
    "avatar": "https://www.shutterstock.com/image-vector/young-smiling-man-avatar-brown-600nw-2261401207.jpg"
}
  */

    // Encabezados de la solicitud
    final Map<String, String> headers = {
      'Content-Type': 'application/json; charset=UTF-8',
    };

    try {
      // Enviar la solicitud POST
      final response = await http.post(
        url,
        headers: headers,
        body: jsonEncode(requestBody),
      );

      if (response.statusCode == 201) {
        // La solicitud fue exitosa
        final responseData = jsonDecode(response.body);
        print('Usuario registrado: ${responseData['email']}');
        isRegister = true;
      } else {
        // La solicitud falló
        print('Error: ${response.statusCode}');
        print('Response: ${response.body}');
      }
    } catch (e) {
      // Manejo de errores
      print('Error: $e');
    }
    return isRegister;
  }

  Future<List<Valoraciones>> getRatingWines(String userId) async {
    List<Valoraciones> listaVinos = [];
    String url =
        "$baseUrl/valoracion/?usuario_id=$userId";
    //String? baseUrl = dotenv.env['BASE_URL'];
    final response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      
      final List<dynamic> parsedJson = jsonDecode(response.body);

      listaVinos = parsedJson.map((json) => Valoraciones.fromJson(json)).toList();
    } else {
      throw Exception('Error, no se puede conectar con la api');
    }
    return listaVinos;
  }

  Future<Vino> getWineById(String vinoId) async {
  late Vino vino;
  String url = "$baseUrl/modelo/$vinoId"; 
  final response = await http.get(Uri.parse(url));

  if (response.statusCode == 200) {
    //Obtener datos en utf-8
    final parsedJson = jsonDecode(utf8.decode(response.bodyBytes));
    vino = Vino.fromJson(parsedJson);
  } else {
    throw Exception('Error, no se puede conectar con la API');
  }
  return vino;
  }
}
