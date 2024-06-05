import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:app_vino/model/vino.dart';
import 'package:app_vino/page/wine_detail_page.dart';
import 'package:app_vino/services/fetch_api.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late List<Map<String, dynamic>> myList = [];

  Future<void> getRecommendations() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String userId = prefs.getString("userID").toString();
    final allWines = await FetchApi().getRatingWines(userId);
    if (allWines != null) {
      for (int i = 0; i < allWines.length; i += 6) {
        String vinoId = allWines[i].getVinoId;
        final vino = await FetchApi().getWineById(vinoId);
        setState(() {
          myList.add({
            'vino': vino,
            'rating': allWines[i].getValoracion.toString(),
          });
        });
      }
    }
  }

  void sortAlphabetically() {
    setState(() {
      myList.sort((a, b) => a['vino'].modelo.compareTo(b['vino'].modelo));
    });
  }

  void sortByRating() {
    setState(() {
      myList.sort((a, b) => b['rating'].compareTo(a['rating']));
    });
  }

  @override
  void initState() {
    super.initState();
    getRecommendations();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      body: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              FloatingActionButton(
                heroTag: 'sortAlpha',
                onPressed: sortAlphabetically,
                child: const Icon(Icons.sort_by_alpha),
              ),
              const SizedBox(height: 16),
              FloatingActionButton(
                heroTag: 'sortNumber',
                onPressed: sortByRating,
                child: const Icon(Icons.sort),
              ),
            ],
          ),
          Expanded(
            child: myList.isNotEmpty
                ? ListView.builder(
                    itemCount: myList.length,
                    physics: const BouncingScrollPhysics(),
                    itemBuilder: (context, index) {
                      final vino = myList[index]['vino'] as Vino;
                      final rating = myList[index]['rating'] as String;
                      return ListTile(
                        leading: Image.network(vino.imagen),
                        title: Flexible(
                          child: Text(
                            vino.modelo,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(
                              fontSize: 16.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        trailing: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            const Icon(Icons.star, color: Colors.yellow),
                            Text(rating, style: theme.textTheme.titleLarge),
                          ],
                        ),
                        subtitle: Text('${vino.pais}, ${vino.region}'),
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => WineDetailPage(vino: vino),
                            ),
                          );
                        },
                      );
                    },
                  )
                : const Center(
                    child: CircularProgressIndicator(),
                  ),
          ),
        ],
      ),
    );
  }
}


/* import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:vono_app/model/vino.dart';
import 'package:vono_app/page/wine_detail_page.dart';
import 'package:vono_app/services/fetch_api.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late List<Vino> listaVinos = [];
  late String rating = "";

  Future<void> getRecommendations() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String userId = prefs.getString("userID").toString();
    final allWines = await FetchApi().getRatingWines(userId);
 if (allWines != null){
      for (int i = 0; i < allWines.length; i += 6) {

        String vinoId = allWines[i].getVinoId;
        print("vini_id $vinoId");
        final vino = await FetchApi().getWineById(vinoId);
        print(vino.modelo);
        setState(() {
          rating = allWines[i].getValoracion.toString();
          listaVinos.add(vino);
        });
        
      }
 }

 
  }
  void sortAlphabetically() {
    setState(() {
      listaVinos.sort((a, b) => a.modelo.compareTo(b.modelo));
    });
  }

  @override
  void initState(){
    super.initState();
    getRecommendations();
  }
  @override
  Widget build(BuildContext context) {

     final theme = Theme.of(context);
    return Scaffold(

     
      body:   Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
                              FloatingActionButton(
                  heroTag: 'sortAlpha',
                  onPressed: sortAlphabetically,
                  child: const Icon(Icons.sort_by_alpha),
                ),
                const SizedBox(height: 16),
                FloatingActionButton(
                  heroTag: 'sortNumber',
                  onPressed: sortAlphabetically,
                  child: const Icon(Icons.sort),)
              /*
              ElevatedButton(
                onPressed: sortAlphabetically,
                child: const Text('Ordenar Alfabéticamente'),
              ),
              const SizedBox(width: 8),
              ElevatedButton(
                onPressed: sortAlphabetically,
                child: const Text('Ordenar por Número'),
              ),
              const SizedBox(width: 16),
              */
            ],
          ),
          Expanded(
            child: listaVinos.isNotEmpty && rating != null


/*
ListView.builder(
  itemCount: listaVinos.length,
  physics: const BouncingScrollPhysics(),
  itemBuilder: (context, index) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => WineDetailPage(vino: listaVinos[index]),
          ),
        );
      },
      child: Card(
        elevation: 4.0,
        margin: const EdgeInsets.all(8.0),
        child: Row(
          children: [
            Expanded(
              flex: 3,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      listaVinos[index].modelo,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        fontSize: 16.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 4.0),
                    Text(
                      '${listaVinos[index].pais}, ${listaVinos[index].region}',
                      style: TextStyle(
                        fontSize: 14.0,
                        color: Colors.grey[600],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
              flex: 1,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  const Icon(Icons.star, color: Colors.yellow),
                  Text(
                    rating,
                    style: Theme.of(context).textTheme.headline6,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  },
),

 */
/*ListView.builder(
  itemCount: listaVinos.length,
  physics: const BouncingScrollPhysics(),
  itemBuilder: (context, index) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => WineDetailPage(vino: listaVinos[index]),
          ),
        );
      }, */
            
     // listaVinos != null
          ? ListView.builder(
              itemCount: listaVinos.length,
              physics: const BouncingScrollPhysics(),
              itemBuilder: (context, index) {
                return ListTile(    
                  leading: Image.network(listaVinos[index].imagen),
                  title:   Flexible(
                                  child: Text(
                                    listaVinos[index].modelo,
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                    style: const TextStyle(
                                      fontSize: 16.0,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                                trailing: 
/*                                Row(
  mainAxisAlignment: MainAxisAlignment.end, // Alinea los elementos a la derecha
  children: [
    const Icon(Icons.star, color: Colors.yellow), // Icono de estrella
    Text(rating, style: theme.textTheme.titleLarge), // Texto del rating
  ],
), */
                                Text(rating, style: theme.textTheme.titleLarge,),
                  
                  subtitle:
                      Text('${listaVinos[index].pais}, ${listaVinos[index].region}'),

                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            WineDetailPage(vino: listaVinos[index]),
                      ),
                    );
                  },
                );
              },
            )
          : const Center(
              child: CircularProgressIndicator(),
            ),
      ),],
      ),
              
            
    );
  }
}
*/