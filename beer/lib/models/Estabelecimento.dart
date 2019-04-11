import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;

class Estabelecimento {
  int id;
  String nome;
  String endereco;


  //Constructor
  Estabelecimento({
    this.id,
    this.nome,
    this.endereco

  });
  //This is a static method
  factory Estabelecimento.fromJson(Map<String, dynamic> json) {
    return Estabelecimento(
        id: json["id"],
        nome: json["nome"],
        endereco: json["endereco"],


    );
  }

  Map<String, dynamic> toJSON() {
    return {
      "id": this.id,
      "nome": this.nome,
      "endereco": this.endereco,


    };
  }

  @override
  String toString() {
    return this.nome.toString() + " - " + this.endereco;
  }


}

