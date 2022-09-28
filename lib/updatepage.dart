import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';

import 'main.dart';
import 'model.dart';

class updatep extends StatefulWidget {
  Map<dynamic, dynamic> map;

  updatep(this.map);

  @override
  State<updatep> createState() => _updatepState();
}

class _updatepState extends State<updatep> {
  @override
  Database? db;


  TextEditingController uname = TextEditingController();
  TextEditingController upassword = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    get();
  }
  get(){
    DbHelper dbHelper=DbHelper();
    dbHelper.cfolder().then((value){
      db=value;
    });


    uname.text=widget.map["name"];
    upassword.text=widget.map["password"];


  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Update Page"),
        ),
        body: Column(children: [
          Padding(padding: EdgeInsets.all(10)),
          TextField(
            controller: uname,
            decoration: InputDecoration(
                border: OutlineInputBorder(),
                hintText: "Enter Name",
                labelText: "Name"),
          ),
          TextField(
            controller: upassword,
            decoration: InputDecoration(
                border: OutlineInputBorder(),
                hintText: "Enter Password",
                labelText: "Password"),
          ),
          Padding(padding: EdgeInsets.all(10)),
          ElevatedButton(
            onPressed: () async {
              int i=widget.map["id"];
              var nname=uname.text;
              var npassword=upassword.text;


              var qry ='UPDATE Test SET name = "${nname}", password = "${npassword}" WHERE id="${i}"';
              await db!.rawUpdate(qry);


              Navigator.push(context, MaterialPageRoute(
                builder: (context) {
                  return homep();
                },
              ));
            },
            child: Text("Update"),
          )
        ]));
  }
}
