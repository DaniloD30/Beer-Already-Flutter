import 'dart:convert';


import 'package:beer/models/Bebida.dart';
import 'package:http/http.dart' as http;

class BebidaDAO {

  static Future<List<Bebida>> retrieveAll() async {
    final response = await http.get('https://danilod.pythonanywhere.com/bebidas/');

    if (response.statusCode == 200) {
      List<Bebida> bebidasList = new List();

      final bebidasJson = json.decode(response.body) as List<dynamic>;
      for (int x = 0; x < bebidasJson.length; x++)
        bebidasList.add(Bebida.fromJson(bebidasJson[x] as Map<String, dynamic>));

      return bebidasList;
    } else {
      throw Exception('Falha ao listar bebidas');
    }
  }

  static Future<Bebida> retrieveById(int id) async {
    final response = await http
        .get('https://danilod.pythonanywhere.com/bebidas/' + id.toString() + "/");

    if (response.statusCode == 200) {
      return Bebida.fromJson(json.decode(response.body));
    } else {
      throw Exception('Falha ao carregar bebida');
    }
  }

  static Future<Bebida> create(Bebida bebida) async {
    final response = await http.post(
        'https://danilod.pythonanywhere.com/bebidas/',
        headers: {"Content-Type": "application/json"},
        body: json.encode(bebida.toJSON())
    );

    if (response.statusCode == 201) {
      return Bebida.fromJson(json.decode(response.body));
    } else {
      throw Exception('Falha ao salvar a nova bebida');
    }
  }

  static Future<Bebida> update(Bebida bebida) async {
    final response = await http
        .patch('https://danilod.pythonanywhere.com/bebidas/' + bebida.id.toString()
        + "/",
        headers: {"Content-Type": "application/json"},
        body: json.encode(bebida.toJSON()));

    if (response.statusCode == 201) {
      return Bebida.fromJson(json.decode(response.body));
    } else {
      throw Exception('Falha ao editar bebida');
    }
  }

  static Future<bool> remove(int id) async {
    final response = await http
        .delete('https://danilod.pythonanywhere.com/bebidas/' + id.toString() + "/");

    return (response.statusCode == 204) ? true : false;
  }

}
