import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:app_vino/model/vino.dart';
import 'package:app_vino/widget/carrusel_item.dart';

class CarouselWine extends StatefulWidget {
  final List<Vino> listaVinos;

  const CarouselWine({super.key, required this.listaVinos});

  @override
  _CarouselWineState createState() => _CarouselWineState();
}

class _CarouselWineState extends State<CarouselWine> {
  int currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Column(
      children: <Widget>[
        widget.listaVinos.isEmpty
            ? const Center(child: CircularProgressIndicator())
            : CarouselSlider(
                options: CarouselOptions(
                  height: 200.0,
                  autoPlay: true,
                  autoPlayInterval: const Duration(seconds: 4),
                  autoPlayAnimationDuration: const Duration(milliseconds: 1000),
                  autoPlayCurve: Curves.fastOutSlowIn,
                  pauseAutoPlayOnTouch: true,
                  aspectRatio: 2.0,
                  onPageChanged: (index, reason) {
                    setState(() {
                      currentIndex = index;
                    });
                  },
                ),
                items: widget.listaVinos.map((vino) {
                  return Builder(
                    builder: (BuildContext context) {
                      return SizedBox(
                        height: MediaQuery.of(context).size.height * 0.30,
                        width: MediaQuery.of(context).size.width,
                        child: Card(
                          color: theme.colorScheme.tertiary,
                          child: Item1(vino: vino),
                        ),
                      );
                    },
                  );
                }).toList(),
              ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: List.generate(widget.listaVinos.length, (index) {
            return Container(
              width: 10.0,
              height: 10.0,
              margin: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 2.0),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: currentIndex == index ? theme.colorScheme.secondary : theme.colorScheme.tertiary,
              ),
            );
          }),
        ),
      ],
    );
  }
}
