import 'package:beer/dao/BebidaDAO.dart';
import 'package:beer/models/Bebida.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:toast/toast.dart';

/*
void main(){
  runApp(new MaterialApp(
    home: new MyTextInput()
  ));
}

class MyTextInput extends StatefulWidget {
  @override
  MyTextInputState createState() => new MyTextInputState();
}
*/
class BebidaForm extends StatefulWidget {
  final Bebida bebida;
  final String fabricante;
  final String estabelecimento;
  final int mililitros;
  final double preco;


  const BebidaForm(
      {Key key, this.bebida, this.fabricante, this.estabelecimento, this.mililitros, this.preco})
      : super(key: key);

  @override
  CadastroBebidas createState() =>
      CadastroBebidas(bebida, fabricante, estabelecimento, mililitros, preco);

}

class CadastroBebidas extends State<BebidaForm> {
  final TextEditingController nomeC = new TextEditingController();
  final TextEditingController estabalecimentoController = new TextEditingController();
  final TextEditingController mililitrosController = new TextEditingController();
  final TextEditingController precoController = new TextEditingController();



  String result = "";

  final _formKey = GlobalKey<FormState>();
  final Bebida bebida;
  String fabricante;
  String estabelecimento;
  int mililitros;
  double preco;


  CadastroBebidas(this.bebida, this.fabricante, this.estabelecimento,
      this.mililitros, this.preco);

  @override
  Widget build(BuildContext context) {
    if (bebida != null) {
      nomeC.text = bebida.fabricante;
      estabalecimentoController.text = bebida.estabelecimento;
      mililitrosController.text = bebida.mililitros.toString();
      precoController.text = bebida.preco.toStringAsFixed(2);
    }
    String miliText = null;
    // TODO: implement build
    return new Scaffold
      (
        appBar: new AppBar(title: new Text("Cadastrar Bebidas"), backgroundColor: Colors.deepOrangeAccent,),
        body: new Container(
          padding: const EdgeInsets.all(5.0),
          child: new Center(
            child: new Column(

              children: <Widget>[
                new Padding(padding: EdgeInsets.only(top: 20.0)),
                new TextField(decoration: new InputDecoration(

                      hintText: "Digite o fabricante",
                  border: new OutlineInputBorder(
                    borderRadius: new BorderRadius.circular(20.0),
                    borderSide: new BorderSide(),
                  ),
                  ),
                  controller: nomeC,
                ),
                new Padding(padding: EdgeInsets.only(top: 15.0)),
                new TextField(

                  controller: estabalecimentoController,
                  decoration: new InputDecoration(
                      hintText: "Digite o estabelecimento",
                    border: new OutlineInputBorder(
                      borderRadius: new BorderRadius.circular(20.0),
                      borderSide: new BorderSide(),
                    ),
                  ),


                ),
                new Padding(padding: EdgeInsets.only(top: 15.0)),
                new TextField(
                  controller: mililitrosController,
                  decoration: new InputDecoration(
                      hintText: "Digite a quantidade de mililitros",
                    border: new OutlineInputBorder(
                      borderRadius: new BorderRadius.circular(20.0),
                      borderSide: new BorderSide()
                    ),

                  ),
                    keyboardType: TextInputType.number,


                ),
                new Padding(padding: EdgeInsets.only(top: 15.0)),
                new TextField(
                  controller: precoController,
                  decoration: new InputDecoration(
                      hintText: "Digite o preço",
                    border: new OutlineInputBorder(
                        borderRadius: new BorderRadius.circular(20.0),
                        borderSide: new BorderSide()
                    ),
                  ),


                ),
              ],
            ),
          ),
        ),

        floatingActionButton: FloatingActionButton.extended(
          onPressed: () async {
            if (this.bebida == null) {
              Bebida bebida = new Bebida(id: 0, fabricante: nomeC.text, estabelecimento: estabalecimentoController.text
                  , mililitros: num.tryParse(mililitrosController.text), preco: num.tryParse(precoController.text)?.toDouble());
              Future<Bebida> novaBebida = BebidaDAO.create(bebida);

              if(novaBebida != null) {
                Toast.show("Bebida cadastrada com sucesso", context, duration: Toast.LENGTH_LONG);
                Navigator.pop(context);
              }else {
                Toast.show("Erro ao cadastrar nova marca. Tente novamente!", context, duration: Toast.LENGTH_LONG);
              }

            } else {}

            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => BebidaForm(bebida: null)),
            );
          },
          backgroundColor: Colors.deepOrangeAccent,
          label: Text("Salvar"),
          icon: Icon(Icons.save),
        ));
    return
      null;
  }

}
