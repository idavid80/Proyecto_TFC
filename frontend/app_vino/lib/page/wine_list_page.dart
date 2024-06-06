import 'package:flutter/material.dart';
import 'package:app_vino/model/vino.dart';
import 'package:app_vino/page/wine_detail_page.dart';
import 'package:app_vino/services/fetch_api.dart';

class WineList extends StatefulWidget {
  const WineList({super.key});

  @override
  _WineListState createState() => _WineListState();
}

class _WineListState extends State<WineList> {
  late List<Vino> vinos = [];
  late List<Vino> filterWines = [];

  Future<void> getAllWines() async {
    final allWines = await FetchApi().getAllWines();

    setState(() {
        final vinos = allWines;
        filterWines = List.from(vinos); // Inicializa filterWines
      });
  }

  @override
  void initState() {
    super.initState();
    getAllWines();
  }

  void searchWines(String query) {
    setState(() {
      filterWines = vinos
          .where((vino) =>
              vino.modelo.toLowerCase().contains(query.toLowerCase()) ||
              vino.region.toLowerCase().contains(query.toLowerCase()) ||
              vino.pais.toLowerCase().contains(query.toLowerCase()) ||
              vino.do_.toLowerCase().contains(query.toLowerCase()))
          .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
       final theme = Theme.of(context);
    return Scaffold(
      
      appBar: AppBar(
        backgroundColor: theme.colorScheme.secondary,
        title: TextField(
          onChanged: searchWines,
          decoration: InputDecoration(
            labelText: 'Buscar',
            hintText: 'Buscar por modelo, país, región, etc.',
            prefixIcon: Icon(Icons.search, color: theme.colorScheme.primary,),
          ),
        ),
      ),
      
      body: RefreshIndicator(
        onRefresh: getAllWines,
        child: OrientationBuilder(
          builder: (context, orientation) {
            final crossAxisCount = orientation == Orientation.portrait ? 2 : 3;

            return GridView.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: crossAxisCount,
                crossAxisSpacing: 8.0,
                mainAxisSpacing: 8.0,
              ),
              itemCount: filterWines.length,
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () {
                    // Acción al hacer clic en la tarjeta
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            WineDetailPage(vino: filterWines[index]),
                      ),
                    );
                  },
                  child: Card(
                    elevation: 4.0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    child: Stack(
                      children: [
                        // Imagen de fondo
                        Image.network(
                          filterWines[index].imagen,
                          fit: BoxFit.cover,
                          width: double.infinity,
                          height: double.infinity,
                        ),
                        // Contenedor blanco superpuesto para el fondo de la imagen
                        Container(
                          color: Colors.white.withOpacity(0.3),
                          width: double.infinity,
                          height: double.infinity,
                        ),
                        // Contenedor con el sticker del modelo do_
                        Positioned(
                          bottom: 0,
                          left: 0,
                          right: 0,
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 8.0, vertical: 4.0),
                            color: theme.colorScheme.secondary,
                            child: Text(
                              filterWines[index].do_,
                              style: theme.textTheme.headlineSmall,),
                          ),
                        ),
                        // Contenido principal
                        Positioned.fill(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                // Modelo del vino
                                Flexible(
                                  child: Text(
                                    filterWines[index].modelo,
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                    style: const TextStyle(
                                      fontSize: 16.0,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            );
          },
        ),
      ),
    );
  }
}
