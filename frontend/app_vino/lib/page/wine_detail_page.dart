import 'dart:math';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:app_vino/model/vino.dart';
import 'package:app_vino/widget/rating_dialog.dart';

class WineDetailPage extends StatelessWidget {
  final Vino vino;

  const WineDetailPage({super.key, required this.vino});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final random = Random();
    final int rating = random.nextInt(5) + 1; // Genera la calificación aleatoria una vez

    return Scaffold(
      appBar: AppBar(
        title: const Text('Detalles del Vino'),
      ),
      backgroundColor: Colors.amber,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Stack(
                children: [
                  Container(
                    color: Colors.transparent, // Fondo blanco
                    child: Image.network(
                      vino.imagen,
                      fit: BoxFit.contain,
                      width: double.infinity,
                      height: 300,
                    ),
                  ),
                  Positioned(
                    bottom: 16.0,
                    right: 16.0,
                    child: Container(
                      padding: const EdgeInsets.all(8.0),
                      decoration: BoxDecoration(
                        color: theme.colorScheme.primary,
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      child: Row(
                        children: [
                          Icon(
                            Icons.star,
                            color: theme.colorScheme.secondary,
                          ),
                          const SizedBox(width: 4.0),
                          Text(
                            rating.toString(), // Usamos la calificación generada aleatoriamente
                            style: const TextStyle(
                              fontSize: 16.0,
                              color: Colors.yellow,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16.0),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  ElevatedButton(
                    style: ButtonStyle(
                      backgroundColor: WidgetStateProperty.all(theme
                          .colorScheme.tertiary), // Color de fondo del botón
                      textStyle:
                          WidgetStateProperty.all(theme.textTheme.titleMedium),
                    ),
                    onPressed: () {
                      // Acción para valorar
                      _showRatingDialog(context);
                    },
                    child: Text('Valorar',
                        style: TextStyle(color: theme.colorScheme.onPrimary)),
                  ),
                  ElevatedButton(
                    style: ButtonStyle(
                      backgroundColor: WidgetStateProperty.all(theme
                          .colorScheme.tertiary), // Color de fondo del botón
                      textStyle:
                          WidgetStateProperty.all(theme.textTheme.titleMedium),
                      //   TextStyle(color: theme.colorScheme.primary,  fontSize: 16,)), // Estilo del texto
                    ),
                    onPressed: () async {
                      final Uri vinoUrl = Uri.parse(vino.url);
                      if (await canLaunchUrl(vinoUrl)) {
                        await launchUrl(vinoUrl);
                      } else {
                        throw 'No se puede abrir la URL ${vino.url}';
                      }
                    },
                    child: Text('Comprar',
                        style: TextStyle(color: theme.colorScheme.onPrimary)),
                  ),
                ],
              ),
              const SizedBox(height: 16.0),
              Row(
                children: <Widget>[
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text('Modelo: ${vino.modelo}',
                            style: theme.textTheme.bodyLarge),
                        const SizedBox(height: 8.0),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Text('País: ${vino.pais}',
                                style: theme.textTheme.bodyLarge),
                            Container(
                              padding: const EdgeInsets.all(8.0),
                              decoration: BoxDecoration(
                                color: theme.colorScheme.primary,
                                borderRadius: BorderRadius.circular(8.0),
                              ),
                              child: Text(vino.do_,
                                  style: theme.textTheme.titleMedium),
                            ),
                          ],
                        ),
                        const SizedBox(height: 8.0),
                        Text('Región: ${vino.region}',
                            style: theme.textTheme.bodyLarge),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16.0),
              Row(
                children: <Widget>[
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text('Variedades:', style: theme.textTheme.bodyLarge),
                        for (var variedad in vino.variedades)
                          Text('- $variedad', style: theme.textTheme.bodyLarge),
                        Container(
                          alignment: Alignment.center,
                          child: ElevatedButton(
                            onPressed: () {
                              // Acción para valorar
                              _showRatingDialog(context);
                            },
                            child: Text('Más información', style: TextStyle(color: theme.colorScheme.onPrimary)),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _showRatingDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return RatingDialog(vino: vino);
      },
    );
  }
}