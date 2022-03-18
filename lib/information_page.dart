import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:spacenews1/Fontsize.dart';
import 'package:spacenews1/main.dart';

/*class Info extends StatelessWidget {
  const Info({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: Scaffold(
      appBar: AppBar(
        title: Text('Info'),
      ),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance.collection('cards').snapshots(),
        builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
          return ListView.builder(
              itemCount: snapshot.data!.docs.length,
              itemBuilder: (context, int index) {
                for (int i = 0; i < snapshot.data!.docs.length; i++) {
                  if (i == index) {
                    return Text(snapshot.data!.docs[i]['info']);
                  }
                }
                return Text('Loading');
              });
        },
      ),
    ));
  }
}*/
class In extends StatelessWidget {
  const In({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        floatingActionButton: FloatingActionButton(
          tooltip: 'Back',
          child: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
    );
  }
}

var s;

// ignore: camel_case_types
// ignore: must_be_immutable
// ignore: camel_case_types
class info extends StatelessWidget {
  String i;
  String collections;
  info(this.i, this.collections);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Scaffold(
          appBar: AppBar(
            leading: IconButton(
              icon: Icon(Icons.arrow_back_ios_new),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
            backgroundColor: Colors.grey[800],
            title: Animated_text('Information', Colors.white),
            centerTitle: true,
          ),
          /*floatingActionButton: FloatingActionButton(
        tooltip: 'Back',
        child: Icon(Icons.arrow_back),
        onPressed: () {
          Navigator.pop(context);
        },
      ),*/
          backgroundColor: Colors.black,
          body: StreamBuilder(
            stream: FirebaseFirestore.instance
                .collection(collections)
                .doc(i)
                .snapshots(),
            builder: (context, AsyncSnapshot<DocumentSnapshot> snapshot) {
              if (!snapshot.hasData) {
                return LinearProgressIndicator();
              }
              Map<String, dynamic> data =
                  snapshot.data!.data() as Map<String, dynamic>;
              return Padding(
                padding: const EdgeInsets.all(10.0),
                child: ListView(children: [
                  Column(
                    children: [
                      Image.network(data['Image']),
                      Text(
                        data['Info'],
                        style: textstyle(siz),
                        textAlign: TextAlign.justify,
                      )
                    ],
                  ),
                ]),
              );
              /*ListView.builder(
              itemCount: snapshot.data!.docs.length,
              itemBuilder: (context, int index) {
                for (int i = 0; i < snapshot.data!.docs.length; i++) {
                  if (i == index) {
                    return Text(snapshot.data!.docs[i]['info']);
                  }
                }
                return Text('Loading');
              });*/
            },
          ),
        ));
  }
}
