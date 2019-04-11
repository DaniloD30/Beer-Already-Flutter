import 'dart:convert';
import 'package:beer/models/Cesta.dart';
import 'package:http/http.dart' as http;

class CestaDAO {

  static Future<List<Cesta>> retrieveAll() async {
    final response = await http.get('https://danilod.pythonanywhere.com/cestas/');

    if (response.statusCode == 200) {
      List<Cesta> cestaList = new List();

      final cestaJson = json.decode(response.body) as List<dynamic>;
      for (int x = 0; x < cestaJson.length; x++)
        cestaList.add(Cesta.fromJson(cestaJson[x] as Map<String, dynamic>));

      return cestaList;
    } else {
      throw Exception('Falha ao listar cestas');
    }
  }

  static Future<Cesta> retrieveById(int id) async {
    final response = await http
        .get('https://danilod.pythonanywhere.com/cestas/' + id.toString() + "/");

    if (response.statusCode == 200) {
      return Cesta.fromJson(json.decode(response.body));
    } else {
      throw Exception('Falha ao carregar Cestas');
    }
  }

  static Future<Cesta> create(Cesta cesta) async {
    final response = await http.post(
        'https://danilod.pythonanywhere.com/cestas/',
        headers: {"Content-Type": "application/json"},
        body: json.encode(cesta.toJSON())
    );

    if (response.statusCode == 201) {
      return Cesta.fromJson(json.decode(response.body));
    } else {
      throw Exception('Falha ao salvar a novo cesta');
    }
  }

  static Future<Cesta> update(Cesta cesta) async {
    final response = await http
        .patch('https://danilod.pythonanywhere.com/cestas/' + cesta.id.toString()
        + "/",
        headers: {"Content-Type": "application/json"},
        body: json.encode(cesta.toJSON()));

    if (response.statusCode == 201) {
      return Cesta.fromJson(json.decode(response.body));
    } else {
      throw Exception('Falha ao editar cesta');
    }
  }

  static Future<bool> remove(int id) async {
    final response = await http
        .delete('https://danilod.pythonanywhere.com/cestas/' + id.toString() + "/");

    return (response.statusCode == 204) ? true : false;
  }

}
