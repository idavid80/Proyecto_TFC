import 'package:flutter/material.dart';

class FooterLogin extends StatefulWidget {
  // funcion para pagina BottomNav
  final Function currentIndex;

  const FooterLogin({super.key, required this.currentIndex});

  @override
  // ignore: library_private_types_in_public_api
  _FooterLoginState createState() => _FooterLoginState();
}


// https://www.youtube.com/watch?v=YqBWWwLkrOQ
class _FooterLoginState extends State<FooterLogin> {

  

  int index = 0;
  
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return BottomNavigationBar(
      backgroundColor: theme.colorScheme.primary, //Colors.white,
      currentIndex: index,
      onTap: (int i){
        setState(() {
          index = i;  
          widget.currentIndex(i);        
        });
      },
      type: BottomNavigationBarType.fixed,
      selectedItemColor: theme.colorScheme.onPrimary,
      unselectedItemColor: theme.colorScheme.secondary,
      iconSize: 25.0,
      selectedFontSize: 14.0,
     // selectedLabelStyle: TextStyle(color: theme.colorScheme.primary),
      unselectedFontSize: 12.0,
      items:   [
      BottomNavigationBarItem(icon: Icon(Icons.login, color: theme.colorScheme.secondary), label: "Login", activeIcon: Icon(Icons.login, color: theme.colorScheme.onPrimary)),
      BottomNavigationBarItem(icon: Icon(Icons.account_circle_rounded, color: theme.colorScheme.secondary), label: "Register", activeIcon: Icon(Icons.account_circle_rounded, color: theme.colorScheme.onPrimary)),
    ]
    );
  }
}
