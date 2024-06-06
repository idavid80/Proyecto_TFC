import 'package:flutter/material.dart';
import 'package:app_vino/page/home_page.dart';
import 'package:app_vino/page/recommendations_page.dart';
import 'package:app_vino/page/wine_list_page.dart';

class RoutesPage extends StatelessWidget {

  final int index;
  const RoutesPage({super.key, required this.index});


  @override
  Widget build(BuildContext context){
    
    List<Widget> pageList = [
      const RecommendationsPage(),
      const WineList(),
      const HomePage()
    ];
    return pageList[index];
  }
} 
