// ignore_for_file: prefer_const_constructors

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_firestore/add.dart';
import 'package:firebase_firestore/view.dart';
import 'package:flutter/material.dart';

import 'database.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Firebase Firestore',
      home: MyHomePage(title: 'Firebase CRUD'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  late Database db;
  List docs = [];
  initialize() {
    db = Database();
    db.initialise();
    db.read().then(
          (value) => setState(
            () {
              docs = value;
            },
          ),
        );
  }

  @override
  void initState() {
    super.initState();
    initialize();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(56, 75, 49, 1.0),
      appBar: AppBar(
        title: Text("Countries"),
        backgroundColor: Color.fromRGBO(56, 75, 49, 1.0),
        centerTitle: true,
      ),
      body: ListView.builder(
        itemBuilder: (BuildContext context, int index) {
          return Card(
            margin: EdgeInsets.all(10.0),
            child: ListTile(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => View(
                              country: docs[index],
                              db: db,
                            ))).then((value) => {
                      if (value != null)
                        {
                          initialize(),
                        }
                    });
              },
              contentPadding: EdgeInsets.only(right: 30, left: 36),
              title: Text(docs[index]['name']),
              trailing: Text(docs[index]['code']),
            ),
          );
        },
        itemCount: docs.length,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
                  context, MaterialPageRoute(builder: (context) => Add(db: db)))
              .then((value) => {
                    if (value != null)
                      {
                        initialize(),
                      }
                  });
        },
        tooltip: 'Increment',
        hoverColor: Colors.white,
        backgroundColor: Color.fromRGBO(26, 45, 09, 1.0),
        child: Icon(
          Icons.add,
          size: 35,
        ),
      ),
    );
  }
}
