import 'dart:convert';


import 'package:beer/models/Estabelecimento.dart';
import 'package:http/http.dart' as http;

class EstabelecimentoDAO {
  static Future<List<Estabelecimento>> retrieveAll() async {
    final response = await http.get('https://danilod.pythonanywhere.com/estabelecimento/');

    if (response.statusCode == 200) {
      List<Estabelecimento> estabelecimentoList = new List();

      final estabelecimentoJson = json.decode(response.body) as List<dynamic>;
      for (int x = 0; x < estabelecimentoJson.length; x++)
        estabelecimentoList.add(Estabelecimento.fromJson(estabelecimentoJson[x] as Map<String, dynamic>));

      return estabelecimentoList;
    } else {
      throw Exception('Falha ao listar bebidas');
    }
  }

  static Future<Estabelecimento> retrieveById(int id) async {
    final response = await http
        .get('https://danilod.pythonanywhere.com/estabelecimento/' + id.toString() + "/");

    if (response.statusCode == 200) {
      return Estabelecimento.fromJson(json.decode(response.body));
    } else {
      throw Exception('Falha ao carregar estabelecimento');
    }
  }

  static Future<Estabelecimento> create(Estabelecimento bebida) async {
    final response = await http.post(
        'https://danilod.pythonanywhere.com/estabelecimento/',
        headers: {"Content-Type": "application/json"},
        body: json.encode(bebida.toJSON())
    );

    if (response.statusCode == 201) {
      return Estabelecimento.fromJson(json.decode(response.body));
    } else {
      throw Exception('Falha ao salvar a novo estabelecimento');
    }
  }

  static Future<Estabelecimento> update(Estabelecimento estabelecimento) async {
    final response = await http
        .patch('https://danilod.pythonanywhere.com/estabelecimento/' + estabelecimento.id.toString()
        + "/",
        headers: {"Content-Type": "application/json"},
        body: json.encode(estabelecimento.toJSON()));

    if (response.statusCode == 201) {
      return Estabelecimento.fromJson(json.decode(response.body));
    } else {
      throw Exception('Falha ao editar estabelecimento');
    }
  }

  static Future<bool> remove(int id) async {
    final response = await http
        .delete('https://danilod.pythonanywhere.com/estabelecimento/' + id.toString() + "/");

    return (response.statusCode == 204) ? true : false;
  }

}
