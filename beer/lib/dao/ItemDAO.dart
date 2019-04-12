import 'dart:convert';

import 'package:beer/dao/BebidaDAO.dart';
import 'package:beer/models/Bebida.dart';
import 'package:beer/models/Estabelecimento.dart';
import 'package:beer/models/Item.dart';
import 'package:http/http.dart' as http;

class ItemDAO {
  static Future<List<Item>> retrieveAll() async {
    final response = await http.get('https://danilod.pythonanywhere.com/item/');

    if (response.statusCode == 200) {
      List<Item> estabelecimentoList = new List();

      final estabelecimentoJson = json.decode(response.body) as List<dynamic>;
      for (int x = 0; x < estabelecimentoJson.length; x++)
        estabelecimentoList
            .add(Item.fromJson(estabelecimentoJson[x] as Map<String, dynamic>));

      return estabelecimentoList;
    } else {
      throw Exception('Falha ao listar bebidas');
    }
  }

  static Future<Item> retrieveById(int id) async {
    final response = await http
        .get('https://danilod.pythonanywhere.com/item/' + id.toString() + "/");

    if (response.statusCode == 200) {
      return Item.fromJson(json.decode(response.body));
    } else {
      throw Exception('Falha ao carregar estabelecimento');
    }
  }

  static Future<Item> create(Item bebida) async {
    final response = await http.post('https://danilod.pythonanywhere.com/item/',
        headers: {"Content-Type": "application/json"},
        body: json.encode(bebida.toJSON()));

    if (response.statusCode == 201) {
      return Item.fromJson(json.decode(response.body));
    } else {
      throw Exception('Falha ao salvar a novo item');
    }
  }

  static Future<Item> update(Item estabelecimento) async {
    final response = await http.patch(
        'https://danilod.pythonanywhere.com/item/' +
            estabelecimento.id.toString() +
            "/",
        headers: {"Content-Type": "application/json"},
        body: json.encode(estabelecimento.toJSON()));

    if (response.statusCode == 201) {
      return Item.fromJson(json.decode(response.body));
    } else {
      throw Exception('Falha ao editar estabelecimento');
    }
  }

  static Future<bool> remove(int id) async {
    final response = await http.delete(
        'https://danilod.pythonanywhere.com/item/' + id.toString() + "/");

    return (response.statusCode == 204) ? true : false;
  }

  static Future<List<Bebida>> retrieveItemsByCesta(int cestaId) async {
    List<Bebida> bebidas = [];
    List<Item> itens = await ItemDAO.retrieveAll();

    for(int x = 0; x < itens.length; x++) {
      if(itens[x].id_cesta == cestaId) {
        Bebida bebida = await BebidaDAO.retrieveById(itens[x].id_bebida);
        bebidas.add(bebida);
      }
    }

    return bebidas;
  }
}