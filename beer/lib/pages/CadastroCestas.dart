import 'package:beer/dao/CestaDAO.dart';
import 'package:beer/dao/EstabelecimentoDAO.dart';
import 'package:beer/models/Cesta.dart';
import 'package:beer/models/Estabelecimento.dart';
import 'package:flutter/material.dart';
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
class CestaForm extends StatefulWidget {
  final Cesta cesta;
  final String nome ;


  const CestaForm({Key key, this.cesta, this.nome}) : super(key: key);

  @override
  CadastroCestas createState() => CadastroCestas(cesta, nome);
}

class CadastroCestas extends State<CestaForm> {
  final TextEditingController controllerNome = new TextEditingController();


  final Cesta cesta;
  final String nome ;


  CadastroCestas(this.cesta, this.nome);

  @override
  Widget build(BuildContext context) {
    if (cesta != null) {
      controllerNome.text = cesta.nome;

    }

    String miliText = null;
    // TODO: implement build
    return new Scaffold(
        appBar: new AppBar(title: new Text("Adicionar Cesta"), backgroundColor: Colors.deepOrangeAccent,),
        body: new Container(

            child: new Container(
              child: new Center(
                child: new Column(
                  children: <Widget>[
                    new Padding(padding: EdgeInsets.only(top: 20.0)),
                    new TextField(
                      decoration: new InputDecoration(

                        hintText: "Digite o nome da sua cesta",
                        border: new OutlineInputBorder(
                          borderRadius: new BorderRadius.circular(20.0),
                          borderSide: new BorderSide(),
                        ),
                      ),
                      controller: controllerNome,
                    ),
                    new Padding(padding: EdgeInsets.only(top: 15.0)),



                  ],
                ),
              ),
            )

        ),
        floatingActionButton: FloatingActionButton.extended(
          onPressed: () async {
            if (this.cesta == null) {
              Cesta  cesta = new Cesta(id: 0, nome: controllerNome.text);
              Future<Cesta> novaCesta = CestaDAO.create(cesta);

              if(novaCesta != null) {
                Toast.show("Nova Cesta cadastrado com sucesso", context, duration: Toast.LENGTH_LONG);
                Navigator.pop(context);
              }else {
                Toast.show("Erro ao cadastrar novo cesta. Tente novamente!", context, duration: Toast.LENGTH_LONG);
              }

            } else {}

            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => CestaForm(cesta: null)),
            );
          },
          backgroundColor: Colors.deepOrangeAccent,
          label: Text("Salvar"),
          icon: Icon(Icons.save),
        ));
    return null;
  }

}