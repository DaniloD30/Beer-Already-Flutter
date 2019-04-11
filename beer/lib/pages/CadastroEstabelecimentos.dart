import 'package:beer/dao/EstabelecimentoDAO.dart';
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
class EstabelecimentoForm extends StatefulWidget {
  final Estabelecimento estabelecimento;
  final String nome ;
  final String endereco;

  const EstabelecimentoForm({Key key, this.estabelecimento, this.nome, this.endereco}) : super(key: key);

  @override
  CadastroEstabelecimentos createState() => CadastroEstabelecimentos(estabelecimento, nome, endereco);
}

class CadastroEstabelecimentos extends State<EstabelecimentoForm> {
  final TextEditingController controllerNome = new TextEditingController();
  final TextEditingController controllerEndereco = new TextEditingController();

  final Estabelecimento estabelecimento;
  final String nome ;
  final String endereco;

  CadastroEstabelecimentos(this.estabelecimento, this.nome, this.endereco);

  @override
  Widget build(BuildContext context) {
    if (estabelecimento != null) {
      controllerNome.text = estabelecimento.nome;
      controllerEndereco.text = estabelecimento.endereco;
    }

    String miliText = null;
    // TODO: implement build
    return new Scaffold(
      appBar: new AppBar(title: new Text("Cadastrar Estabelecimento"), backgroundColor: Colors.deepOrangeAccent,),
      body: new Container(

        child: new Container(
          child: new Center(
            child: new Column(
              children: <Widget>[
                new Padding(padding: EdgeInsets.only(top: 20.0)),
                new TextField(
                    decoration: new InputDecoration(

                        hintText: "Digite o nome do estabelecimento",
                      border: new OutlineInputBorder(
                        borderRadius: new BorderRadius.circular(20.0),
                        borderSide: new BorderSide(),
                      ),
                    ),
                    controller: controllerNome,
                ),
                new Padding(padding: EdgeInsets.only(top: 15.0)),
                new TextField(
                    decoration: new InputDecoration(
                        hintText: "Digite o Endereço",
                      border: new OutlineInputBorder(
                        borderRadius: new BorderRadius.circular(20.0),
                        borderSide: new BorderSide(),
                      ),

                    ),
                  controller: controllerEndereco,
                ),


              ],
            ),
          ),
        )

      ),
        floatingActionButton: FloatingActionButton.extended(
          onPressed: () async {
            if (this.estabelecimento == null) {
              Estabelecimento estabelecimento = new Estabelecimento(id: 0, nome: controllerNome.text, endereco: controllerEndereco.text);
              Future<Estabelecimento> novoEstabelecimento = EstabelecimentoDAO.create(estabelecimento);

              if(novoEstabelecimento != null) {
                Toast.show("Estabelecimento cadastrado com sucesso", context, duration: Toast.LENGTH_LONG);
                Navigator.pop(context);
              }else {
                Toast.show("Erro ao cadastrar novo estabelecimento. Tente novamente!", context, duration: Toast.LENGTH_LONG);
              }

            } else {}

            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => EstabelecimentoForm(estabelecimento: null)),
            );
          },
          backgroundColor: Colors.deepOrangeAccent,
          label: Text("Salvar"),
          icon: Icon(Icons.save),
        ));
    return null;
  }

}