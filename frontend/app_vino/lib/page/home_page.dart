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
      for (int i = 0; i < allWines.length; i ++) {
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
                        title: Text(
                          vino.modelo,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                            fontSize: 16.0,
                            fontWeight: FontWeight.bold,
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
