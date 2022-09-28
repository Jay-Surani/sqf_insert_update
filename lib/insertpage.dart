import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import 'main.dart';
import 'model.dart';

class insertp extends StatefulWidget {
  const insertp({Key? key}) : super(key: key);

  @override
  State<insertp> createState() => _insertpState();
}

class _insertpState extends State<insertp> {


  TextEditingController iname=TextEditingController();
  TextEditingController ipassword=TextEditingController();
  Database ?db;


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    DbHelper dbhelper=DbHelper();
    dbhelper.cfolder().then((value){
      db=value;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("InsertPage"),
      ),
      body: Column(
        children: [
          Padding(padding: EdgeInsets.all(10)),
          TextField(
            controller: iname,
            decoration: InputDecoration(
                border: OutlineInputBorder(),
                hintText: "Enter Name",
                labelText: "Name"),
          ),
          TextField(
            controller: ipassword,
            decoration: InputDecoration(
                border: OutlineInputBorder(),
                hintText: "Enter Password",
                labelText: "Password"),
          ),
          ElevatedButton(onPressed: () async {
            String qry='INSERT INTO Test(name, password) VALUES("${iname.text}","${ipassword.text}")';

            int i=await db!.rawInsert(qry);
            print("value of i=${i}");
            Navigator.push(context, MaterialPageRoute(builder: (context) {
              return homep();
            },));



          }, child:Text("Save"))

        ],
      ),
    );
  }
}
