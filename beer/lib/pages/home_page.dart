import 'package:beer/dao/CestaDAO.dart';
import 'package:beer/models/Cesta.dart';
import 'package:beer/pages/CadastroCestas.dart';
import 'package:beer/pages/CestasItens.dart';
import 'package:flutter/material.dart';
import 'package:toast/toast.dart';
import './CadastroBebidas.dart';
import './CadastroEstabelecimentos.dart';


class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => new _HomePageState();
}

class _HomePageState extends State<HomePage> {

  String currentProfilePic = "https://avatars3.githubusercontent.com/u/16825392?s=460&v=4";
  String otherProfilePic = "https://yt3.ggpht.com/-2_2skU9e2Cw/AAAAAAAAAAI/AAAAAAAAAAA/6NpH9G8NWf4/s900-c-k-no-mo-rj-c0xffffff/photo.jpg";

  void switchAccounts() {
    String picBackup = currentProfilePic;
    this.setState(() {
      currentProfilePic = otherProfilePic;
      otherProfilePic = picBackup;
    });
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        appBar: new AppBar(title: new Text("Água Dura"), backgroundColor: Colors.deepOrange,),
        drawer: new Drawer(
          child: new ListView(
            children: <Widget>[
              new UserAccountsDrawerHeader(
                accountEmail: new Text("danilolive30@gmail.com"),
                accountName: new Text("Danilo"),


                decoration: new BoxDecoration(
                    image: new DecorationImage(
                        image: new NetworkImage("https://img00.deviantart.net/35f0/i/2015/018/2/6/low_poly_landscape__the_river_cut_by_bv_designs-d8eib00.jpg"),
                        fit: BoxFit.fill
                    )
                ),
              ),
              new ListTile(
                  title: new Text("Cadastrar Bebidas"),
                  trailing: new Icon(Icons.arrow_forward_ios),
                  onTap: () {
                    Navigator.of(context).pop();
                    Navigator.of(context).push(new MaterialPageRoute(builder: (BuildContext context) => new BebidaForm()));
                  }
              ),
              new ListTile(
                  title: new Text("Cadastrar Estabelecimento"),
                  trailing: new Icon(Icons.arrow_forward_ios),
                  onTap: () {
                    Navigator.of(context).pop();
                    Navigator.of(context).push(new MaterialPageRoute(builder: (BuildContext context) => new EstabelecimentoForm()));
                  }
              ),
              new ListTile(
                  title: new Text("Minhas Cestas"),
                  trailing: new Icon(Icons.add_shopping_cart),
                  onTap: () {
                    Navigator.pop(context);
                    //Navigator.of(context).push(new MaterialPageRoute(builder: (BuildContext context) => new EstabelecimentoForm()));
                  }
              ),
              new Divider(),
              new ListTile(
                title: new Text("Cancel"),
                trailing: new Icon(Icons.cancel),
                onTap: () => Navigator.pop(context),
              ),
            ],
          ),
        ),
        body: new Center(
            child: FutureBuilder(
              future: CestaDAO.retrieveAll(),
              builder: (BuildContext context, AsyncSnapshot snapshot) {
                switch (snapshot.connectionState) {
                  case ConnectionState.none:
                  case ConnectionState.waiting:
                    return new CircularProgressIndicator();
                  default:
                    if (snapshot.hasError)
                      return new Text('Error: ${snapshot.error}');
                    else
                      return _createListView(context, snapshot);
                }
              },
            )),
        //drawer: MainUI.getDrawer(context),
        floatingActionButton: FloatingActionButton.extended(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) =>
                      CestaForm(cesta: null, nome: "Nova Marca")),
            );
          },
          backgroundColor: Colors.deepOrange,
          label: Text("Adicionar nova cesta"),
          icon: Icon(Icons.save),
         // child: Icon(Icons.add),
        )
    );
  }
  _createListView(BuildContext context, AsyncSnapshot snapshot) {
    List<Cesta> cestas = snapshot.data;
    return new ListView.builder(
      scrollDirection: Axis.vertical,
      shrinkWrap: true,
      itemCount: cestas.length,
      itemBuilder: (BuildContext context, int index) {
        return new Card(
          elevation: 8.0,
          margin: new EdgeInsets.symmetric(horizontal: 10.0, vertical: 6.0),
          child: Container(
            decoration: BoxDecoration(color: Colors.orangeAccent),
            child: ListTile(
                onTap: () {
                  Navigator.of(context).push(new MaterialPageRoute(builder: (BuildContext context) => new CestaItensForm(
                                              cesta: cestas[index], nome: cestas[index].nome, id: cestas[index].id)));
                },
                contentPadding:
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
                        bool success = (await CestaDAO.remove(cestas[index].id));
                        if(success) {
                          Toast.show("Cesta deletada com sucesso!", context, duration: Toast.LENGTH_LONG);
                          cestas.remove(cestas[index]);
                        } else {
                          Toast.show("Erro ao deletar. Tente novamente!", context, duration: Toast.LENGTH_LONG);
                        }
                      },
                    )
                ),
                title: Text(
                  cestas[index].nome,
                  style:
                  TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                ),
                subtitle: Row(
                  children: <Widget>[
                    Icon(Icons.linear_scale, color: Colors.deepOrange),
                    Text(" ID: " + cestas[index].id.toString(), style: TextStyle(color: Colors.white))
                  ],
                ),
                trailing: GestureDetector(
                  child: Icon(Icons.keyboard_arrow_right,
                      color: Colors.white, size: 30.0),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => CestaForm(
                              cesta: cestas[index],
                              nome: "Editando Cesta: " + cestas[index].nome)),
                    );
                  },
                )
            ),

          ),
        );
      },
    );
  }
}