import 'package:beer/dao/BebidaDAO.dart';
import 'package:beer/dao/EstabelecimentoDAO.dart';
import 'package:beer/dao/ItemDAO.dart';
import 'package:beer/models/Bebida.dart';
import 'package:beer/models/Cesta.dart';
import 'package:beer/models/Estabelecimento.dart';
import 'package:beer/models/Item.dart';
import 'package:beer/pages/CadastroBebidas.dart';
import 'package:flutter/material.dart';
import 'package:toast/toast.dart';

class AddBebidaCesta extends StatefulWidget {
  final Cesta cesta;
  final String nome;
  final int id;

  const AddBebidaCesta({Key key, this.cesta, this.nome, this.id}) : super(key: key);

  @override
  _HomePageState createState() => new _HomePageState(cesta);
}

class _HomePageState extends State<AddBebidaCesta> {
  final Cesta cesta;

  _HomePageState(this.cesta);


  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        appBar: new AppBar(title: new Text("Bebidas cadastradas"), backgroundColor: Colors.deepOrange,),
        body: new Center(
          child: FutureBuilder(
            future: BebidaDAO.retrieveAll(),
            builder: (BuildContext context, AsyncSnapshot snapshot) {
              switch (snapshot.connectionState) {
                case ConnectionState.none:
                case ConnectionState.waiting:
                  return new CircularProgressIndicator();
                default:
                  if (snapshot.hasError)

                    return new Text('Error: ${snapshot.error}');
                  else {
                    return _createListView(context, snapshot, this.cesta.id);
                  }
              }
            },
          )
        ),
        floatingActionButton: FloatingActionButton.extended(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) =>
                      BebidaForm(bebida: null, fabricante: "Nova Marca")),
            );
          },
          backgroundColor: Colors.deepOrange,
         // backgroundColor: Colors.deepOrange,
          label: Text("Adicionar nova bebida"),
          icon: Icon(Icons.save),
          //child: Icon(Icons.add),
        )
    );

  }
}

_createListView(BuildContext context, AsyncSnapshot snapshot, int idCesta) {

  List<Bebida> bebidas = snapshot.data;
  return new ListView.builder(
    scrollDirection: Axis.vertical,
    shrinkWrap: true,
    itemCount: bebidas.length,
    itemBuilder: (BuildContext context, int index) {
      return new Card(
        elevation: 8.0,
        margin: new EdgeInsets.symmetric(horizontal: 10.0, vertical: 6.0),
        child: Container(
          decoration: BoxDecoration(color: Colors.orangeAccent),
          child: ListTile(
              onTap: (){
                //print("Vc clicou na cesta ${idCesta}");
                //print("Vc clicou na bebida ${bebidas[index].id}");
                Toast.show("Bebida adicionada na cesta!", context, duration: Toast.LENGTH_LONG);
                Item i = new Item(id: 0, id_cesta:idCesta, id_bebida:bebidas[index].id );
                Future<Item> novaCesta = ItemDAO.create(i);
                },
              contentPadding://his.bebida, this.fabricante, this.estabelecimento, this.mililitros, this.preco}
              EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
              leading: Container(
                  padding: EdgeInsets.only(right: 12.0),
                  decoration: new BoxDecoration(
                      border: new Border(
                          right:
                          new BorderSide(width: 1.0, color: Colors.white24))),
                  child: GestureDetector(
                    child: Icon(Icons.delete, color: Colors.white),
                    onTap: () async {
                      bool success = (await BebidaDAO.remove(bebidas[index].id));
                      if(success) {
                        Toast.show("Bebida deletada com sucesso!", context, duration: Toast.LENGTH_LONG);
                        bebidas.remove(bebidas[index]);
                      } else {
                        Toast.show("Erro ao deletar. Tente novamente!", context, duration: Toast.LENGTH_LONG);
                      }
                    },
                  )
              ),
              title: Text(
                bebidas[index].fabricante,
                style:
                TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
              ),
              subtitle: Row(
                children: <Widget>[
                  Icon(Icons.linear_scale, color: Colors.deepOrange),
                  Text(" ID: " + bebidas[index].id.toString(), style: TextStyle(color: Colors.white))
                ],
              ),
              trailing: GestureDetector(
                child: Icon(Icons.keyboard_arrow_right,
                    color: Colors.white, size: 30.0),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => BebidaForm(
                            bebida: bebidas[index], fabricante: bebidas[index].fabricante, estabelecimento: bebidas[index].estabelecimento,
                            mililitros: bebidas[index].mililitros, preco: bebidas[index].preco)),
                  );
                },
              )
          ),

        ),
      );
    },
  );
}

_createListViewBebidasOrdenadas(BuildContext context, List<Bebida> snapshot) {

  List<Bebida> bebidas = snapshot;
  return new ListView.builder(
    scrollDirection: Axis.vertical,
    shrinkWrap: true,
    itemCount: bebidas.length,
    itemBuilder: (BuildContext context, int index) {
      return new Card(
        elevation: 8.0,
        margin: new EdgeInsets.symmetric(horizontal: 10.0, vertical: 6.0),
        child: Container(
          decoration: BoxDecoration(color: Colors.orangeAccent),
          child: ListTile(
              contentPadding://his.bebida, this.fabricante, this.estabelecimento, this.mililitros, this.preco}
              EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
              leading: Container(
                  padding: EdgeInsets.only(right: 12.0),
                  decoration: new BoxDecoration(
                      border: new Border(
                          right:
                          new BorderSide(width: 1.0, color: Colors.white24))),
                  child: GestureDetector(
                    child: Icon(Icons.delete, color: Colors.white),
                    onTap: () async {
                      bool success = (await BebidaDAO.remove(bebidas[index].id));
                      if(success) {
                        Toast.show("Bebida deletada com sucesso!", context, duration: Toast.LENGTH_LONG);
                        bebidas.remove(bebidas[index]);
                      } else {
                        Toast.show("Erro ao deletar. Tente novamente!", context, duration: Toast.LENGTH_LONG);
                      }
                    },
                  )
              ),
              title: Text(
                bebidas[index].fabricante,
                style:
                TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
              ),
              subtitle: Row(
                children: <Widget>[
                  Icon(Icons.linear_scale, color: Colors.deepOrange),
                  Text(" ID: " + bebidas[index].id.toString(), style: TextStyle(color: Colors.white))
                ],
              ),
              trailing: GestureDetector(
                child: Icon(Icons.keyboard_arrow_right,
                    color: Colors.white, size: 30.0),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => BebidaForm(
                            bebida: bebidas[index], fabricante: bebidas[index].fabricante, estabelecimento: bebidas[index].estabelecimento,
                            mililitros: bebidas[index].mililitros, preco: bebidas[index].preco)),
                  );
                },
              )
          ),

        ),
      );
    },
  );
}
class CestaItensForm extends StatefulWidget {
  final Cesta cesta;
  final String nome ;
  final int id;

  const CestaItensForm({Key key, this.cesta, this.nome, this.id}) : super(key: key);

  @override
  CestaItens createState() => CestaItens(cesta, nome, id);
}

class CestaItens extends State<CestaItensForm> {
  final TextEditingController controllerNome = new TextEditingController();
  final TextEditingController controllerEndereco = new TextEditingController();

  final Cesta cesta;
  final String nome ;
  final int id;
  List<Bebida> listBebidas;
  List<Item> listItens;
  List<Bebida> bebidasCesta;

  CestaItens(this.cesta, this.nome, this.id);



  @override
  Widget build(BuildContext context) {

  /* listBebidas = returnBebidas();
   listItens = returnItens();

    //listBebidas = BebidaDAO.retrieveAll();
    //listBebidas.then(onValue);
  // print(listBebidas[1].fabricante);
    for(var i in listItens){
      if (i.id_cesta == this.id){
          for(var bebida in listBebidas){
            if (bebida.id == i.id_bebida){
              bebidasCesta.add(bebida);
            }
          }
      }
    }

    _createListViewBebidasOrdenadas(context, bebidasCesta);*/

    String miliText = null;
    // TODO: implement build
    return new Scaffold(

        appBar: new AppBar(title: new Text("Bebidas da cesta"), backgroundColor: Colors.deepOrangeAccent,),
        // PRECISO PEGAR TODOS MEUS ITENS,
        // TODAS AS MINHAS BEBIDAS,
        // LOOP PARA VER SE O ITEM TEM O MSMO ID DA CESTA
        // PERCORRER A LISTA DE ITENS COM A CONDIÇÃO SE ITENS.IDBEBIDA == ID BEBIDA
        floatingActionButton: FloatingActionButton.extended(
          onPressed: () async {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => AddBebidaCesta(cesta: this.cesta,nome:this.nome, id: this.id)),
            );
          },
          backgroundColor: Colors.deepOrangeAccent,
          label: Text("Adicionar bebidas a cesta"),
          icon: Icon(Icons.save),
        ));
    return null;
  }

  List<Bebida> retornaListBebidas(){
    List<Bebida> list;
    new Center(
        child: FutureBuilder(
          future: BebidaDAO.retrieveAll(),
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            switch (snapshot.connectionState) {
              case ConnectionState.none:
              case ConnectionState.waiting:
                return new CircularProgressIndicator();
              default:
                if (snapshot.hasError)
                  return new Text('Error: ${snapshot.error}');
                else {
                  list = snapshot.data;
                  print(list.length);
                }
            }
          },
        ));
    return list;
  }

  List<Item> retornaListItens(){
    List<Item> list;
    new Center(
        child: FutureBuilder(
          future: ItemDAO.retrieveAll(),
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            switch (snapshot.connectionState) {
              case ConnectionState.none:
              case ConnectionState.waiting:
                return new CircularProgressIndicator();
              default:
                if (snapshot.hasError)
                  return new Text('Error: ${snapshot.error}');
                else {
                  list = snapshot.data;
                }
            }
          },
        ));
    return list;
  }

  List<Bebida> returnBebidas(){
    List<Bebida> b;
    BebidaDAO.retrieveAll().then(
        (bebidas) => {
          b = bebidas
        }
    );
    return b;
  }

  List<Item> returnItens(){
    List<Item> b;
    ItemDAO.retrieveAll().then(
            (bebidas) => {
        b = bebidas
        }
    );
    return b;
  }



}

