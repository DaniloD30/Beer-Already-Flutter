import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;

class Bebida {
  int id;
  String fabricante;
  String estabelecimento;
  double preco;
  int mililitros;

  //Constructor
  Bebida({
    this.id,
    this.fabricante,
    this.estabelecimento,
    this.preco,
    this.mililitros
  });
  //This is a static method
  factory Bebida.fromJson(Map<String, dynamic> json) {
    return Bebida(
      id: json["id"],
      fabricante: json["fabricante"],
      estabelecimento: json["estabelecimento"],
      preco: json["preco"],
      mililitros: json["mililitros"]

    );
  }

  Map<String, dynamic> toJSON() {
    return {
      "id": this.id,
      "fabricante": this.fabricante,
      "estabelecimento": this.estabelecimento,
      "mililitros": this.mililitros,
      "preco": this.preco

    };
  }

  @override
  String toString() {
    return this.id.toString() + " - " + this.fabricante;
  }


}

