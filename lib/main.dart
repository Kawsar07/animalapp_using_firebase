import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_database/firebase_database.dart';
void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: MyApp(),
  ));
}
class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}
class _MyAppState extends State<MyApp> {
  final Future<FirebaseApp>_initialize = Firebase.initializeApp();
  @override
  void initState() {
    _initialize;
    // TODO: implement initState
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("FireBase"),
        centerTitle: true,
      ),
      body:StreamBuilder<QuerySnapshot>(
          stream: FirebaseFirestore.instance.collection("Birds").snapshots(),

          builder: (context,snapshots){
            if(!snapshots.hasData){
              return Center(child: Text("Loading"),);
            }
            if (snapshots.hasData) {
              // <3> Retrieve `List<DocumentSnapshot>` from snapshot
              final List<DocumentSnapshot> documents = snapshots.data!.docs;
              return ListView(
                  children: documents.map((doc) => Card(
                    child: ListTile(
                      title: Text(doc['name']),
                      leading: Image.network(doc['img']),
                      // leading: Image.network(doc['img']),
                      subtitle: Text(doc['rank'].toString()),),)).toList());
            }
            else if (snapshots.hasError) {
              return Text("Error");
            }
            return Center(child: CircularProgressIndicator(),);
          }),
    );
  }
}