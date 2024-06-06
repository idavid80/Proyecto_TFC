import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:app_vino/main.dart';
import 'package:app_vino/services/ory_services.dart';
import 'package:app_vino/services/routes_session.dart';
import 'package:app_vino/widget/app_bar_custom.dart';
import 'package:app_vino/widget/footer_logout.dart';

class LogoutPage extends StatefulWidget {
  const LogoutPage({super.key});

  @override
  _LogoutPageState createState() => _LogoutPageState();
}

class _LogoutPageState extends State<LogoutPage> {
  int index = 0;
  FooterLogin? bottomNav;

   void logout() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final sessionToken = prefs.getString("sessionToken");
    if (sessionToken != null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Bienvenido, ${prefs.get("email")}')),
      );
    } else {
      final bool isLogout = await OryServices().logout(sessionToken.toString());
      if(isLogout) {
        
      prefs.clear();
      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Sesión cerrada exitosamente')));
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => const SplashScreen()),
        (Route<dynamic> route) => false,
      );
      
      }
    }
  }
                

  @override
  void initState() {
    // inicializamos BottomNav con la funcion paginacion
    bottomNav = FooterLogin(
      currentIndex: (page) {
        setState(() {
          index = page;
        });
      },
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(logout: logout, isLogin: false,),
      body: RouteSession(index: index),
      bottomNavigationBar: bottomNav,
    );  
  }
}
