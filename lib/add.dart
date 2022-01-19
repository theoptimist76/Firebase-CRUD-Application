// ignore_for_file: prefer_const_constructors

import 'package:firebase_firestore/database.dart';
import 'package:flutter/material.dart';

class Add extends StatefulWidget {
  Add({Key? key, required this.db}) : super(key: key);
  final Database db;

  @override
  _AddState createState() => _AddState();
}

class _AddState extends State<Add> {
  TextEditingController nameController = TextEditingController();
  TextEditingController codeController = TextEditingController();
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Color.fromRGBO(56, 75, 49, 1.0),
      appBar: AppBar(
        backgroundColor: Color.fromRGBO(56, 75, 49, 1.0),
        title: Text("Countries Add"),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Container(
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
              widget.db.create(nameController.text, codeController.text);
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
