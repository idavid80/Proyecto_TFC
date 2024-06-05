import 'package:flutter/material.dart';

class BottomNav extends StatefulWidget {
  // funcion para pagina BottomNav
  final Function currentIndex;

  const BottomNav({super.key, required this.currentIndex});

  @override
  // ignore: library_private_types_in_public_api
  _BottomNavState createState() => _BottomNavState();
}


// https://www.youtube.com/watch?v=YqBWWwLkrOQ
class _BottomNavState extends State<BottomNav> {
  
  int index = 0;

//  bool isSelected;


  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return BottomNavigationBar(
      backgroundColor: theme.colorScheme.tertiary,
      currentIndex: index,
      onTap: (int i) {
        setState(() {
          index = i;
          widget.currentIndex(i);
        });
      },
      
      type: BottomNavigationBarType.fixed,
      selectedItemColor: theme.colorScheme.primary,
      unselectedItemColor: theme.colorScheme.onPrimary,
      iconSize: 25.0,
      selectedFontSize: 14.0,
     // selectedLabelStyle: TextStyle(color: theme.colorScheme.primary),
      unselectedFontSize: 12.0,
      items: [
        BottomNavigationBarItem(icon: Icon(Icons.home_outlined, color: theme.colorScheme.onPrimary),activeIcon: Icon(Icons.home, color: theme.colorScheme.primary), label: "Home"),
        BottomNavigationBarItem(icon: Icon(Icons.wine_bar_outlined, color: theme.colorScheme.onPrimary),activeIcon: Icon(Icons.wine_bar, color: theme.colorScheme.primary), label: "Wine List"),
        BottomNavigationBarItem(icon: Icon(Icons.list_outlined, color: theme.colorScheme.onPrimary),activeIcon: Icon(Icons.list, color: theme.colorScheme.primary), label: "My list")
      ],
    );
  }
}