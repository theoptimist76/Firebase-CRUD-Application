// ignore_for_file: prefer_const_constructors

import 'package:firebase_firestore/database.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class View extends StatefulWidget {
  View({Key? key, required this.country, required this.db}) : super(key: key);
  final Map country;
  final Database db;

  @override
  _ViewState createState() => _ViewState();
}

class _ViewState extends State<View> {
  TextEditingController nameController = TextEditingController();
  TextEditingController codeController = TextEditingController();
  @override
  void initState() {
    super.initState();
    if (kDebugMode) {
      print(widget.country);
    }
    nameController.text = widget.country['name'];
    codeController.text = widget.country['code'];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(56, 75, 49, 1.0),
      appBar: AppBar(
        backgroundColor: Color.fromRGBO(56, 75, 49, 1.0),
        title: Text("Countries View"),
        centerTitle: true,
        actions: [
          IconButton(
              onPressed: () {
                widget.db.delete(widget.country["id"]);
                Navigator.pop(context, true);
              },
              icon: Icon(Icons.delete)),
        ],
      ),
      body: Stack(
        children: [
          Container(
            padding: EdgeInsets.all(20.0),
            child: Column(
              children: [
                TextFormField(
                  style: TextStyle(color: Colors.white),
                  decoration: inputDecoration("Country Name"),
                  controller: nameController,
                ),
                SizedBox(height: 20.0),
                TextFormField(
                  style: TextStyle(color: Colors.white),
                  decoration: inputDecoration("Country Code"),
                  controller: codeController,
                ),
              ],
            ),
          ),
        ],
      ),
      bottomNavigationBar: Container(
        padding: EdgeInsets.all(25),
        color: Colors.transparent,
        child: BottomAppBar(
          elevation: 0.0,
          color: Colors.transparent,
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
                primary: Color.fromRGBO(50, 75, 40, 1.0),
                elevation: 0.0,
                side: BorderSide(color: Colors.white, width: 0.4)),
            onPressed: () {
              widget.db.update(widget.country["id"], nameController.text,
                  codeController.text);
              Navigator.pop(context, true);
            },
            child: Text(
              "SAVE",
              style: TextStyle(color: Colors.white),
            ),
          ),
        ),
      ),
    );
  }

  InputDecoration inputDecoration(String labelText) {
    return InputDecoration(
      focusColor: Colors.white,
      labelStyle: TextStyle(color: Colors.white),
      labelText: labelText,
      fillColor: Color.fromRGBO(56, 75, 49, 1.0),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(20.0),
        borderSide: BorderSide(color: Colors.white, width: 1.9),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(20.0),
        borderSide: BorderSide(
          color: Color.fromRGBO(110, 110, 1, 1.0),
          width: 1.5,
        ),
      ),
    );
  }
}
