import 'package:flutter/material.dart';
import 'package:sqf_insert_update/updatepage.dart';
import 'package:sqflite/sqflite.dart';

import 'insertpage.dart';
import 'model.dart';

void main() {
  runApp(MaterialApp(
    title: "SqfLite",
    home: homep(),
  ));
}

class homep extends StatefulWidget {
  const homep({Key? key}) : super(key: key);

  @override
  State<homep> createState() => _homepState();
}

class _homepState extends State<homep> {
  @override
  initState() {
    super.initState();
    get();
    setState(() {});
  }

  Widget? l;
  Database? db;
  List<Map> list = [];

  get() {
    DbHelper dbHelper = DbHelper();
    dbHelper.cfolder().then((value) async {
      db = value;
      String qry = 'SELECT * FROM Test';
      list = await db!.rawQuery(qry);
      l = ListView.builder(
        itemCount: list.length,
        itemBuilder: (context, index) {
          Map map = list[index];
          return ListTile(
            leading: Icon(Icons.list),
            trailing: TextButton(onPressed: () {
              showDialog(context: context, builder: (context) {
                return AlertDialog(
                  title: Text("Are You Sure"),
                  content: Text("What's Your Choice"),
                  actions: [                            Icon(

                    Icons.edit,
                    color: Colors.blue,
                  ),
                    TextButton(


                      onPressed: () {
                        Navigator.push(context, MaterialPageRoute(
                          builder: (context) {
                            return updatep(map);
                          },
                        ));
                      },
                      child: Text("Update"),
                    ),
                    Icon(
                      Icons.delete,
                      color: Colors.blue,
                    ),
                    TextButton(
                        onPressed: () {
                          Navigator.pop(context);
                          Icon(
                            Icons.delete,
                            color: Colors.blue,
                          );
                        },
                        child: Text("Delete"))


                  ],


                );
              },);
            }, child: Icon(Icons.more_vert)),
            title: Text("${map["name"]}"),
            subtitle: Text("${map["password"]}"),
          );
        },
      );
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("HomePage"),
      ),
      body: l,
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(context, MaterialPageRoute(
            builder: (context) {
              return insertp();
            },
          ));
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
