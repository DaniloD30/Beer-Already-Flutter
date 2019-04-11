import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;

class Item {
  int id;
  int id_bebida;
  int id_cesta;


  //Constructor
  Item({
    this.id,
    this.id_cesta,
    this.id_bebida

  });
  //This is a static method
  factory Item.fromJson(Map<String, dynamic> json) {
    return Item(
      id: json["id"],
      id_cesta: json["id_cesta"],
      id_bebida: json["id_bebida"],


    );
  }

  Map<String, dynamic> toJSON() {
    return {
      "id": this.id,
      "id_cesta": this.id_cesta,
      "id_bebida": this.id_bebida,


    };
  }

  @override
  String toString() {
    return this.id.toString();
  }


}

