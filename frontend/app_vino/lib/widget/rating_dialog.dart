import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:app_vino/model/vino.dart';
import 'package:app_vino/services/fetch_api.dart';

class RatingDialog extends StatefulWidget {
  final Vino vino;

  const RatingDialog({super.key, required this.vino});

  @override
  _RatingDialogState createState() => _RatingDialogState();
}

class _RatingDialogState extends State<RatingDialog> {
  int _rating = 0;
  
  final TextEditingController _commentController = TextEditingController();
  late String vinoId;
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Valorar ${widget.vino.modelo}'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(5, (index) {
              return IconButton(
                icon: Icon(
                  index < _rating ? Icons.star : Icons.star_border,
                  color: Colors.amber,
                ),
                onPressed: () {
                  setState(() {
                    _rating = index + 1;
                    vinoId = widget.vino.vinoId;
                  });
                },
              );
            }),
          ),
          TextField(
            controller: _commentController,
            maxLines: 3,
            decoration: const InputDecoration(
              hintText: 'Deja un comentario',
            ),
          ),
        ],
      ),
      actions: <Widget>[
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: const Text('Cancelar'),
        ),
        ElevatedButton(
          onPressed: () {
            _submitRating();
          },
          child: const Text('Enviar'),
        ),
      ],
    );
  }

  void _submitRating() async {

    final SharedPreferences prefs = await SharedPreferences.getInstance();
    
    final String comment = _commentController.text;

    final Map<String, dynamic> requestBody = {
      "valoracion": _rating,
      "comentario": comment,
      "modelo_vino_id": vinoId,
      "usuario_id": prefs.getString("userID")
    };
    print('requestBody: $requestBody ');
    final isRating = await FetchApi().createRating(requestBody);

    isRating ?  ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Valoración con éxito, Tu puntuación es $_rating')),
      ) :       ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Error en la valoración')),
      );
    Navigator.of(context).pop();
  }

  
}
