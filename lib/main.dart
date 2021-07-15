import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';


void main()async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      home: Home(),
    );
  }
}
class Home extends StatelessWidget {

  final ref = FirebaseFirestore.instance.collection("City");
  @override
  Widget build(BuildContext context) {
    



    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.red,
        title: Text("CityApp"),
        centerTitle: true,
      ),
      body: StreamBuilder(
        stream: ref.snapshots(),
        builder: (context,AsyncSnapshot<QuerySnapshot>snapshot){
          if(snapshot.hasData){
            return ListView.builder(
                itemCount: snapshot.data.docs.length,
                itemBuilder: (context,index){
                  return
                    Card(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          child: Column(
                            children: [

                              Image.network(snapshot.data.docs[index]['image']),
                              Text(snapshot.data.docs[index]['name'],style: TextStyle(fontSize: 30,fontWeight: FontWeight.bold),),
                              SizedBox(height: 20,),
                              Text(snapshot.data.docs[index]['desc']),
                            ],
                          ),
                        ),
                      ),
                    );
                });
          }
          else{
            return CircularProgressIndicator();
          }
        }),

    );
  }
}
