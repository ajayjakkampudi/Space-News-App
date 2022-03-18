import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:spacenews1/information_page.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import '../main.dart';

class Telescopes extends StatefulWidget {
  const Telescopes({Key? key}) : super(key: key);

  @override
  _TelescopesState createState() => _TelescopesState();
}

class _TelescopesState extends State<Telescopes> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          backgroundColor: Colors.grey[700],
          leading: IconButton(
            icon: Icon(Icons.arrow_back_ios_new),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          title: Center(
            child: DefaultTextStyle(
              style: const TextStyle(
                  color: Colors.white,
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 6
                  //fontFamily: 'Horizon',
                  ),
              child: Center(
                child: AnimatedTextKit(
                  animatedTexts: [
                    RotateAnimatedText('Telescopes'),
                    RotateAnimatedText('Satellites'),
                    //RotateAnimatedText('DIFFERENT'),
                  ],
                  repeatForever: true,
                ),
              ),
            ),
          ),
        ),
        backgroundColor: Colors.grey[900],
        body: StreamBuilder(
          stream: FirebaseFirestore.instance
              .collection('Telescopes')
              .orderBy('Time', descending: true)
              .snapshots(),
          builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (!snapshot.hasData) {
              return Center(child: CircularProgressIndicator());
            }

            return ListView.builder(
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.all(1.0),
                  child: ListTile(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => info(
                                  snapshot.data!.docs[index].id,
                                  'Telescopes')));
                      setState(() {});
                    },
                    tileColor: Colors.grey,
                    leading: Container(
                      width: 80,
                      height: 50,
                      decoration: BoxDecoration(
                          image: DecorationImage(
                              image: NetworkImage(
                                  snapshot.data!.docs[index]['Image']),
                              fit: BoxFit.cover),
                          borderRadius: BorderRadius.all(Radius.circular(8))),
                    ),
                    title: Text(
                      snapshot.data!.docs[index]['Title'],
                      textAlign: TextAlign.start,
                    ),
                  ),
                );
              },
              itemCount: snapshot.data!.docs.length,
            );
          },
        ),
      ),
    );
  }
}
