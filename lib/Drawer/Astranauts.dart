import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:spacenews1/main.dart';
import 'package:url_launcher/url_launcher.dart';

launchURLBrowser() async {
  const url = 'http://api.open-notify.org/astros.json';
  if (await canLaunch(url)) {
    await launch(url, forceSafariVC: true, forceWebView: true);
  } else {
    throw 'Could not launch $url';
  }
}

class Album {
  final number;
  final msg;
  final people;
  Album({this.number, this.msg, this.people});
  factory Album.fromJson(Map<String, dynamic> json) {
    return Album(
        number: json['number'], msg: json['message'], people: json['people']);
  }
}

// ignore: non_constant_identifier_names
Future<Album> Space() async {
  final response =
      await http.get(Uri.parse('http://api.open-notify.org/astros.json'));
  if (response.statusCode == 200) {
    return Album.fromJson(jsonDecode(response.body));
  } else {
    throw Exception('Failed in Loading');
  }
}

class Astro extends StatefulWidget {
  Astro({Key? key}) : super(key: key);

  @override
  _AstroState createState() => _AstroState();
}

class _AstroState extends State<Astro> {
  late Future<Album> futureAlbum;
  var i = 0;
  late List lists;
  @override
  void initState() {
    super.initState();
    futureAlbum = Space();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Scaffold(
            appBar: AppBar(
              backgroundColor: Colors.grey[600],
              title: Animated_text('Astronauts In Space', Colors.white),
              /*fltitle: Text(
                'Astronauts In Space Rigth Now',
                style: TextStyle(color: Colors.black, letterSpacing: 2),
              ),*/
              centerTitle: true,
              leading: IconButton(
                icon: Icon(Icons.arrow_back_ios_new),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
            ),
            body: Stack(
              children: [
                Container(
                  decoration: BoxDecoration(
                      image: DecorationImage(
                          image: NetworkImage(
                              'https://i.pinimg.com/564x/72/93/f3/7293f3aad030bc47d0b1c0a3f35dce40.jpg'),
                          fit: BoxFit.cover)),
                ),
                //Image.network('https://i.gifer.com/QP0D.gif'),
                FutureBuilder<Album>(
                  future: futureAlbum,
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      return ListView.builder(
                          itemCount: snapshot.data!.number,
                          itemBuilder: (context, index) {
                            return Padding(
                              padding: const EdgeInsets.only(left: 30),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  if (index == 0)
                                    Padding(
                                      padding: const EdgeInsets.only(top: 50),
                                      child: Text(
                                        'Number of People in Space : ' +
                                            snapshot.data!.number.toString(),
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold),
                                        textAlign: TextAlign.left,
                                      ),
                                    ),
                                  Padding(
                                    padding: const EdgeInsets.only(top: 50),
                                    child: Text(
                                      'Name of Astronaut : ' +
                                          snapshot.data!.people[index]['name'] +
                                          ' in ' +
                                          snapshot.data!.people[index]['craft'],
                                      textAlign: TextAlign.start,
                                      style: TextStyle(
                                          color: Colors.amber[300],
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                  Container(
                                    decoration: BoxDecoration(
                                        image: DecorationImage(
                                            image: NetworkImage(
                                                'https://i.pinimg.com/564x/72/93/f3/7293f3aad030bc47d0b1c0a3f35dce40.jpg'),
                                            fit: BoxFit.cover)),
                                  ),
                                ],
                              ),
                            );
                          });
                    }
                    return Center(child: CircularProgressIndicator());
                    /*return Center(
                      child: Column(
                        children: [
                          Image.asset(
                              'assets/images/JoyousImpassionedBigmouthbass-max-1mb.gif'),
                          Wrap(children: [
                            Text('Sorry! GitHub unable to track '),
                            TextButton(
                                onPressed: launchURLBrowser,
                                child: Text(
                                    'http://api.open-notify.org/astros.jso'))
                          ])
                        ],
                      ),
                    );*/
                  },
                ),
              ],
            )

            /*child: Column(children: [
              FutureBuilder<Album>(
                future: futureAlbum,
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    //return Text(snapshot.data!.number.toString());
                    return Text(snapshot.data!.people);
                  }
                  return CircularProgressIndicator();
                },
              ),
            ])),*/

            ));
  }
}
