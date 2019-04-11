import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;

class Cesta {
  int id;
  String nome;



  //Constructor
  Cesta({
    this.id,
    this.nome,


  });
  //This is a static method
  factory Cesta.fromJson(Map<String, dynamic> json) {
    return Cesta(
      id: json["id"],
      nome: json["nome"],
    );
  }

  Map<String, dynamic> toJSON() {
    return {
      "id": this.id,
      "nome": this.nome,
    };
  }

  @override
  String toString() {
    return this.nome.toString();
  }


}

