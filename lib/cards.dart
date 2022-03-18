import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:spacenews1/information_page.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'Fontsize.dart';

double siz = 20.0;

class Cards extends StatefulWidget {
  @override
  _CardsState createState() => _CardsState();
}

class _CardsState extends State<Cards> {
  late String str;

  Widget information(String i) {
    return StreamBuilder(
      stream: FirebaseFirestore.instance.collection('Cards').doc(i).snapshots(),
      builder: (context, AsyncSnapshot<DocumentSnapshot> snapshot) {
        if (snapshot.hasData) {
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
        }
        return Center(child: CircularProgressIndicator());
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
    );
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection('Cards')
            .orderBy('Time', descending: true)
            .snapshots(),
        builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (!snapshot.hasData) {
            return Center(child: CircularProgressIndicator());
          }

          return ListView.builder(
              itemCount: snapshot.data!.docs.length,
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            info(snapshot.data!.docs[index].id, 'Cards'),
                      ),
                    );
                    setState(() {});
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Card(
                      //sshape: RoundedRectangleBorder(borderRadius: Radius.c),
                      color: Colors.grey[700],
                      clipBehavior: Clip.antiAlias,
                      child: Column(
                        children: [
                          Image.network(snapshot.data!.docs[index]['Image']),
                          new ListTile(
                            isThreeLine: false,
                            title: new Text(
                              snapshot.data!.docs[index]['Heading'],
                              style: TextStyle(
                                  fontWeight: FontWeight.w700,
                                  color: Colors.white),
                            ),
                            subtitle: Text(
                                snapshot.data!.docs[index]['ShortNote'],
                                style: TextStyle(color: Colors.white)),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              });
        });
  }
}
