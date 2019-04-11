
import 'package:flutter/material.dart';

import './pages/home_page.dart';

void main() => runApp(new MaterialApp(
  home: new HomePage(),
));

/*

  // GET ALL BEBIDAS NO LIST VIEW
  final String url="https://danilod.pythonanywhere.com/bebidas/";
  List data;

  @override
  void initState(){
    super.initState();
    this.getJsonData();
  }

  Future<String> getJsonData() async{
    var response = await http.get(
        Uri.encodeFull(url),
        headers: {"Accept": "application/json"}

    );

    print(response.body);

    setState(() {
      var toJsonData = json.decode(response.body);
      data = toJsonData;
    });

    return "Success";
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return new Scaffold(
        appBar: new AppBar(
          title: new Text("GET API"),
        ),
        body: new ListView.builder(
            itemCount: data == null ? 0 : data.length,
            itemBuilder: (BuildContext context, int index) {
              return new Container(
                  child: new Center(
                      child: new Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: <Widget>[
                          new Card(
                              child: new Container(
                                child: new Text(data[index]['fabricante']),
                                padding: const EdgeInsets.all(20),
                              ))
                        ],
                      )));
            }));
  }
  */
