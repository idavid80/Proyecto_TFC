
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:app_vino/page/logout_page.dart';
import 'package:app_vino/theme/colors.dart';
import 'package:app_vino/widget/loanding_logo.dart';
import 'package:app_vino/page/user_page.dart';

Future<void> main() async {
  // Cargar variables de entorno
  await dotenv.load(fileName: ".env");
  runApp(const MyApp());
}
// GlobalKey permite navegar sin necesidad del context local.
final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: WineAppTheme.theme,
      /*
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),*/
      home: const SplashScreen(),
      navigatorKey: navigatorKey,
    );
  }
}

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
      loanding();
  }

  Future<void> loanding() async {
    try {
      await Future.delayed(const Duration(seconds: 3)); // Simula una operación de carga
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      String? token = prefs.getString('token');
      if (token != null) {
        print('Token encontrado $token');
        // Usuario ya está logueado
       navigatorKey.currentState?.pushReplacement(
          MaterialPageRoute(builder: (context) => const UserPage(),));
      } else {
        // Usuario no está logueado
        print('Token no logueado $token');
       navigatorKey.currentState?.pushReplacement(
          MaterialPageRoute(builder: (context) => const LogoutPage()));
      }
    } on TimeoutException {
      print('Timeout: la operación tomó más de 5 segundos.');
    }
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Logo(), // Asumiendo que tienes un widget llamado Logo
            SizedBox(height: 20),
            Text("Wine APP"),
          ],
        ),
      ),
    );
  }
}