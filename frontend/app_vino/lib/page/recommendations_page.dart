import 'package:flutter/material.dart';
import 'package:app_vino/model/vino.dart';
import 'package:app_vino/services/fetch_api.dart';
import 'package:app_vino/widget/carrusel_wine.dart';

class RecommendationsPage extends StatefulWidget {
  const RecommendationsPage({super.key});

  @override
  _RecommendationsPageState createState() => _RecommendationsPageState();
}

class _RecommendationsPageState extends State<RecommendationsPage> {
  late List<Vino> listaVinos = [];

  Future<void> getTasteThatWine() async {
    final allWines = await FetchApi().getAllWines();

    setState(() {
      for (int i = 0; i < allWines.length; i += 5) {
        listaVinos.add(allWines[i]);
      }
    });
  }

  @override
  void initState() {
    super.initState();
    getTasteThatWine();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
        body: SingleChildScrollView(
      child: Column(
        children: [
          const SizedBox(
            width: 16.0,
            height: 16.0,
          ),
          Text(
            "Vinos más vendidos",
            style: theme.textTheme.headlineLarge,
            /*TextStyle(
                    fontSize: 24.0,
                    fontWeight: FontWeight.bold,
                  ),*/
          ),
          CarouselWine(listaVinos: listaVinos),
          const SizedBox(
            width: 16.0,
            height: 16.0,
          ),
          Text(
            "Tal ves te guste",
            style: theme.textTheme.headlineLarge,
          ),
          CarouselWine(listaVinos: listaVinos),
          const SizedBox(
            width: 16.0,
            height: 16.0,
          ),
          Text(
            "Porque te gustó",
            style: theme.textTheme.headlineLarge,
          ),
          listaVinos.isEmpty
              ? Text(
                  "Cargando recomendacion",
                  style: theme.textTheme.headlineLarge,
                )
              : Text(
                  listaVinos[0].modelo,
                  style: theme.textTheme.headlineMedium,
                ),
          const SizedBox(
            width: 16.0,
            height: 16.0,
          ),
          CarouselWine(listaVinos: listaVinos),
        ],
      ),
    ));
  }
}
