import 'package:flutter/material.dart';
import 'package:app_vino/model/vino.dart';
import 'package:app_vino/page/wine_detail_page.dart';

class Item1 extends StatelessWidget {
  final Vino vino;

  const Item1({super.key, required this.vino});

  @override
  Widget build(BuildContext context) {
        final theme = Theme.of(context);
    return GestureDetector(
      onTap: () {
        // Acción al hacer clic en la tarjeta
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => WineDetailPage(vino: vino),
          ),
        );
      },
      child: Container(
        decoration: const BoxDecoration(
          borderRadius: BorderRadiusDirectional.all(Radius.elliptical(15, 15)),
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            stops: [0.3, 1],
            colors: [Color(0xFF800020), Color(0xFF808000)],
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Flexible(
              child: Text(
                vino.modelo,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: theme.textTheme.titleLarge,
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Column(
                  children: [
                    Text(
                      vino.do_,
                      style: theme.textTheme.titleMedium
                    ),
                    Text(
                      vino.region,
                      style: theme.textTheme.titleMedium
                    ),
                  ],
                ),
                Image.network(
                  vino.imagen,
                  fit: BoxFit.contain,
                  width: 100,

                  // height: 300,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
