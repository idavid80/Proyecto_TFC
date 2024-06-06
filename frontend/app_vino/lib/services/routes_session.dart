import 'package:flutter/material.dart';
import 'package:app_vino/page/login_page.dart';
import 'package:app_vino/page/register_page.dart';


class RouteSession extends StatelessWidget {

  final int index;
  const RouteSession({super.key, required this.index});


  @override
  Widget build(BuildContext context){
    
    List<Widget> pageList = [
      const LoginPage(),
      const RegisterPage(),
    ];
    return pageList[index];
  }
} 
