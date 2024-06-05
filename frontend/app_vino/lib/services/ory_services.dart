import 'package:dio/dio.dart';
import 'package:ory_client/ory_client.dart';
import 'package:one_of/one_of.dart';
import 'package:one_of/src/oneOf/one_of_base.dart';
import 'package:built_value/json_object.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:app_vino/services/fetch_api.dart';

class OryServices {
  // final FrontendApi _api;
  Session? _identity;

  final _api = OryClient().getFrontendApi();

  Future<bool> login(String email, String password) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    bool isLogged = false;
    try {
      final response = await _api.createNativeLoginFlow(
          refresh: true, returnSessionTokenExchangeCode: true);

      UpdateLoginFlowWithPasswordMethod body =
          UpdateLoginFlowWithPasswordMethod((b) => b
            ..method = 'password'
            ..password = password
            ..identifier = email);

      final update = await _api.updateLoginFlow(
          flow: response.data!.id,
          updateLoginFlowBody: UpdateLoginFlowBody(
              (b) => b..oneOf = OneOf.fromValue1(value: body)));
      if (update.statusCode == 200) {
        isLogged = true;
        prefs.setString('email', email);
        prefs.setString('token', update.data!.sessionToken.toString());
        prefs.setString('userID', update.data!.session.identity!.id);
      }
    } on DioException {
      rethrow;
    }
    return isLogged;
  }

  // registro con ory sdk
  Future<bool> register(String username, String email, String password) async {
    final api = OryClient().getFrontendApi();
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    bool isRegister = false;
    try {
      final response = await api.createNativeRegistrationFlow(
          returnSessionTokenExchangeCode: true);

      // print('id ${response.data!.id}');

      // String username = "victor@rovimatica.es";
      // String password = "asdfgji!@854*";
      UpdateRegistrationFlowWithPasswordMethod body =
          UpdateRegistrationFlowWithPasswordMethod((b) => b
            ..method = 'password'
            ..password = password
            ..traits = JsonObject({'email': email}));

      final update = await api.updateRegistrationFlow(
          flow: response.data!.id,
          updateRegistrationFlowBody: UpdateRegistrationFlowBody(
              (b) => b..oneOf = OneOf.fromValue1(value: body)));

      // print('UPDATE STATUS CODE -> ${update.statusCode}');
      if (update.statusCode! >= 200 && update.statusCode! <= 299) {
        // Almacenar en el movil
        prefs.setString('username', username);
        prefs.setString('email', email);
        prefs.setString('token', update.data!.sessionToken.toString());
        prefs.setString('userID', update.data!.identity.id);
        prefs.setBool('isChecked', true);

        // Guardar en Base de datos
        final Map<String, dynamic> requestBody = {
          "user_id": prefs.getString("userID"),
          "email": email,
          "username": username,
          "avatar":
              "https://www.shutterstock.com/image-vector/young-smiling-man-avatar-brown-600nw-2261401207.jpg"
        };
        final isUser = await FetchApi().createUser(requestBody);
        isUser ? isRegister = true : isRegister = false;
      }
    } on DioException catch (e) {
      print(e);
    }
    return isRegister;
  }

  //Google

  Future<bool> isAuthenticated() async {
    return _api.toSession().then((resp) {
      if (resp.statusCode == 200) {
        _identity = resp.data;
        return true;
      }
      return false;
    }).catchError((error) {
      return false;
    });
  }

  Future<bool> logout(String sessionToken) async {
    bool checkLogout = false;
    try {
      final respuesta = await _api.performNativeLogout(
        performNativeLogoutBody:
            PerformNativeLogoutBody((b) => b..sessionToken = sessionToken),
      );
      if (respuesta.statusCode! >= 200 && respuesta.statusCode! <= 299) {
        checkLogout = true;
      } else {}
    } on DioException catch (e) {
      print(e);
    }
    return checkLogout;
  }

  get identity => _identity;
}
