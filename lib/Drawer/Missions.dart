import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:spacenews1/information_page.dart';
import 'package:animated_text_kit/animated_text_kit.dart';

import '../main.dart';

class Missions extends StatelessWidget {
  const Missions({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          leading: IconButton(
            icon: Icon(Icons.arrow_back_ios_new),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          backgroundColor: Colors.grey[700],
          title: Padding(
            padding: const EdgeInsets.all(2.0),
            child: Center(
              child: DefaultTextStyle(
                style: const TextStyle(
                    fontSize: 20.0,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 6
                    //fontFamily: 'Horizon',
                    ),
                child: Center(
                  child: AnimatedTextKit(
                    animatedTexts: [
                      RotateAnimatedText('Missiles'),
                      RotateAnimatedText('Rockets'),
                      //RotateAnimatedText('DIFFERENT'),
                    ],
                    repeatForever: true,
                  ),
                ),
              ),
            ),
          ),
        ),
        backgroundColor: Colors.grey[900],
        body: StreamBuilder(
          stream: FirebaseFirestore.instance
              .collection('Missions')
              .orderBy('Time', descending: true)
              .snapshots(),
          builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (!snapshot.hasData) {
              return LinearProgressIndicator();
            }
            return Container(
              margin: EdgeInsets.only(top: 2),
              child: GridView.builder(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      mainAxisExtent: 330,
                      crossAxisCount: 2,
                      mainAxisSpacing: 1,
                      crossAxisSpacing: 2),
                  itemCount: snapshot.data!.docs.length,
                  itemBuilder: (context, index) {
                    return Container(
                      padding: EdgeInsets.all(2),
                      child: GestureDetector(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => info(
                                      snapshot.data!.docs[index].id,
                                      'Missions')));
                        },
                        child: Container(
                          height: 30,
                          child: GridTile(
                              footer: Material(
                                color: Colors.grey,
                                child: GridTileBar(
                                  title: Text(
                                    snapshot.data!.docs[index]['Footer'],
                                    //style: TextStyle(fontSize: 20),
                                  ),
                                ),
                              ),
                              child: Container(
                                decoration: BoxDecoration(
                                    image: DecorationImage(
                                        image: NetworkImage(snapshot
                                            .data!.docs[index]['Image']),
                                        fit: BoxFit.cover),
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(5))),
                              )),
                        ),
                      ),
                    );
                  }),
            );
          },
        ),
      ),
    );
  }
}
