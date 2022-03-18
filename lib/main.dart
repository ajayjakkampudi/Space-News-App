import 'dart:async';
import 'dart:convert';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:spacenews1/Drawer/Astranauts.dart';
import 'package:spacenews1/Drawer/Blackholes.dart';
import 'package:spacenews1/Drawer/Missions.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:spacenews1/Telescopes.dart';
import 'package:spacenews1/cards.dart';
//import 'package:spacenews1/Buttons.dart';
import 'package:spacenews1/Fontsize.dart';
import 'package:spacenews1/comment.dart';
import 'package:connectivity/connectivity.dart';
import 'package:animated_splash_screen/animated_splash_screen.dart';
//import 'package:splashscreen/splashscreen.dart' show SplashScreen;

var siz = 25.0;
void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp();

  runApp(MaterialApp(
    home: S(),
    debugShowCheckedModeBanner: false,
  ));
}

class S extends StatelessWidget {
  const S({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AnimatedSplashScreen(
        backgroundColor: Colors.black,
        duration: 5000,
        splash: Center(
          child: DefaultTextStyle(
            style: const TextStyle(
                fontSize: 30.0,
                fontFamily: 'Horizon',
                color: Colors.white,
                fontWeight: FontWeight.bold),
            child: AnimatedTextKit(
              animatedTexts: [
                TypewriterAnimatedText('SPACENEWS',
                    speed: Duration(milliseconds: 500)),
              ],
              onTap: () {
                print("Tap Event");
              },
            ),
          ),
        ),
        /*Text(
          'SPACENEWS',
          style: TextStyle(fontFamily: 'Horizon', color: Colors.white),
        ),*/
        /*SizedBox(
          width: 5500.0,
          child: TextLiquidFill(
              text: 'SPACENEWS',
              waveColor: Colors.white,
              waveDuration: Duration(seconds: 3),
              //boxBackgroundColor: Colors.redAccent,
              textStyle: TextStyle(
                color: Colors.white,
                fontSize: 60.0,
                fontWeight: FontWeight.bold,
              ),
              boxHeight: 75.0),
        ),*/
        //splashTransition: SplashTransition.rotationTransition,
        nextScreen: MyApp());
  }
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  late int _connectionStatus;
  final Connectivity _connectivity = Connectivity();
  late StreamSubscription<ConnectivityResult> _connectivitysubscription;
  @override
  void initState() {
    super.initState();
    initConnectivity();
    _connectivitysubscription =
        _connectivity.onConnectivityChanged.listen(_updateConnectionStatus);
  }

  void dispose() {
    super.dispose();
    _connectivitysubscription.cancel();
  }

  Future<void> initConnectivity() async {
    ConnectivityResult result = await _connectivity.checkConnectivity();
    return _updateConnectionStatus(result);
  }

  Future<void> _updateConnectionStatus(ConnectivityResult result) async {
    switch (result) {
      case ConnectivityResult.none:
        setState(() => _connectionStatus = 0);
        break;
      case ConnectivityResult.mobile:
      case ConnectivityResult.wifi:
        setState(() {
          _connectionStatus = 1;
        });
    }
  }

  Widget build(BuildContext context) {
    if (_connectionStatus == 0) {
      return Scaffold(
        body: SafeArea(
            child: Center(
          child: Column(
            children: [
              Center(
                child: Image.asset(
                    'assets/images/JoyousImpassionedBigmouthbass-max-1mb.gif'),
              ),
              Center(
                  child: Text(
                'No Internet.Please Connect to Wifi or Mobile data',
                style:
                    TextStyle(color: Colors.red, fontWeight: FontWeight.w900),
              ))
            ],
          ),
        )),
      );
    }
    return Scaffold(
      //backgroundColor: Colors.blueGrey[800],
      appBar: AppBar(
          //titleSpacing: 5,
          iconTheme: IconThemeData(color: Colors.white),
          /*flexibleSpace: ClipRRect(
              borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(40),
                  bottomRight: Radius.circular(40)),
              child: Container(
                decoration: BoxDecoration(
                    image: DecorationImage(
                  image: NetworkImage(
                      'http://pa1.narvii.com/7769/d7070b2a33f2d1e077be1d98470ec6235db3b423r1-280-158_00.gif'),
                  fit: BoxFit.cover,
                )),
              ),
            ),*/
          backgroundColor: Colors.grey[800],
          title: DefaultTextStyle(
            style: const TextStyle(fontSize: 20.0, letterSpacing: 1),
            child: AnimatedTextKit(
              //totalRepeatCount: 2,
              repeatForever: true,
              animatedTexts: [
                WavyAnimatedText('Space News',
                    textStyle: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    )),
                //WavyAnimatedText('Look at the waves'),
              ],
              isRepeatingAnimation: true,
            ),
          ),
          /*Text(
            'Space News',
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
          ),*/
          centerTitle: true,
          elevation: 500,
          //toolbarHeight: 150,
          /*shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(40),
                    bottomRight: Radius.circular(40))),*/
          actions: [
            IconButton(
                onPressed: () {
                  showDialog(context: context, builder: (context) => dialog());
                },
                tooltip: 'Random Word',
                icon: Icon(
                  Icons.all_inclusive_rounded,
                  color: Colors.white,
                )),
            Container(
              child: Theme(
                data: Theme.of(context).copyWith(
                  cardColor: Colors.white,
                  iconTheme: IconThemeData(color: Colors.white),
                ),
                child: PopupMenuButton(
                    color: Colors.grey[600],
                    itemBuilder: (BuildContext context) => <PopupMenuEntry>[
                          PopupMenuItem(
                            child: ListTile(
                              title: Text(
                                'Settings',
                                style: TextStyle(color: Colors.white),
                              ),
                              onTap: () {
                                Navigator.pop(context);
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => Settings()));
                              },
                            ),
                          ),
                          PopupMenuItem(
                            child: ListTile(
                              title: Text(
                                'Comment',
                                style: TextStyle(color: Colors.white),
                              ),
                              onTap: () {
                                Navigator.pop(context);
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => Comments()));
                              },
                            ),
                          ),
                        ]),
              ),
            )
          ]),
      backgroundColor: Colors.black45,
      body: Cards(),
      drawer: drawer(),
      drawerScrimColor: Colors.black,

      //drawer: Container(child: drawer()),
    );
  }
}

// ignore: camel_case_types
// ignore: must_be_immutable
// ignore: camel_case_types
class Animated_text extends StatelessWidget {
  late String word;
  late Color colour;
  //Animated_text({ Key? key,required get this.wo }) : super(key: key);
  Animated_text(this.word, this.colour);

  @override
  Widget build(BuildContext context) {
    return DefaultTextStyle(
      style: const TextStyle(fontSize: 20.0, letterSpacing: 1),
      child: AnimatedTextKit(
        totalRepeatCount: 2,
        animatedTexts: [
          WavyAnimatedText(word,
              textStyle: TextStyle(
                  color: colour,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 4)),
          //WavyAnimatedText('Look at the waves'),
        ],
        isRepeatingAnimation: true,
      ),
    );
  }
}

var random = new Random();

// ignore: camel_case_types
class dialog extends StatefulWidget {
  dialog({Key? key}) : super(key: key);

  @override
  _dialogState createState() => _dialogState();
}

// ignore: camel_case_types
class _dialogState extends State<dialog> {
  List data = [];

  Future<void> loadJsonData() async {
    var jsonText = await rootBundle.loadString('assets/glossary.json');
    setState(() => data = json.decode(jsonText));
  }

  @override
  void initState() {
    super.initState();
    this.loadJsonData();
  }

  Widget build(BuildContext context) {
    int x = random.nextInt(data.length);
    if (data.isEmpty) return LinearProgressIndicator();
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          leading: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: Icon(Icons.arrow_back_ios_new)),
          centerTitle: true,
          title: Text('Space Words Wall'),
          backgroundColor: Colors.grey[600],
        ),
        body: ListView(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    data[x]['name'] + ':',
                    style: TextStyle(fontSize: 30),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(data[x]['surname']),
                ),
                FlatButton(
                    onPressed: loadJsonData,
                    child: Text(
                      'Random Word',
                      //style: TextStyle(color: Colors.white),
                    ))
              ],
            ),
          ],
        ),
      ),
    );
    /*Container(
      child: AlertDialog(
        elevation: 500,
        //backgroundColor: Colors.grey[600],
        title: Text(
          data[x]["name"],
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        content: Text(
          data[x]["surname"],
          //style: TextStyle(color: Colors.white),
        ),
        actions: [
          Expanded(
              child: Row(
            children: [
              FlatButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Text(
                    'Back',
                    style: TextStyle(color: Colors.white),
                  )),
              FlatButton(
                  onPressed: loadJsonData,
                  child: Text(
                    'Random Word',
                    style: TextStyle(color: Colors.white),
                  ))
            ],
          )),
        ],
      ),
    );*/

    //return Text('jkkh');
  }
}

class Category extends StatelessWidget {
  const Category({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: [
          Container(
              child: Stack(children: [
            Image.network(
              'https://i.pinimg.com/564x/b5/64/70/b564702dee0d02025f47b4228958ca01.jpg',
              width: 40,
              height: 50,
            ),
            Container(
              child: Text(
                'Mars',
                style: TextStyle(color: Colors.white),
              ),
            ),
          ])),
          Stack(children: [
            Image.network(
              'https://i.pinimg.com/564x/b5/64/70/b564702dee0d02025f47b4228958ca01.jpg',
              width: 40,
              height: 50,
            ),
            Container(
              child: Text(
                'Mars',
                style: TextStyle(color: Colors.white),
              ),
            ),
          ])
        ],
      ),
    );
  }
}

// ignore: camel_case_types
class drawer extends StatelessWidget {
  const drawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.black,
      child: Drawer(
        child: ListView(
          children: [
            Container(
                child: Container(
              height: 80,
              child: Container(
                color: Colors.grey[800],
                child: DrawerHeader(
                    child: Text(
                  'Categories',
                  style: TextStyle(color: Colors.black),
                )),
              ),
            )),
            Container(
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 1),
                    child: ListTile(
                      tileColor: Colors.grey[500],
                      title: Text(
                        'Missiles And Rockets',
                        style: TextStyle(color: Colors.black),
                      ),
                      onTap: () {
                        Navigator.pop(context);
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => Missions()));
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 1),
                    child: ListTile(
                      tileColor: Colors.grey[500],
                      title: Text(
                        'Telescopes And Satellites',
                        style: TextStyle(color: Colors.black),
                      ),
                      onTap: () {
                        Navigator.pop(context);
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => Telescopes()));
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 1),
                    child: ListTile(
                        tileColor: Colors.grey[500],
                        title: Text(
                          'Blackholes',
                          style: TextStyle(color: Colors.black),
                        ),
                        onTap: () {
                          Navigator.pop(context);
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => Blackholes()));
                        }),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 1),
                    child: ListTile(
                        tileColor: Colors.grey[500],
                        title: Text(
                          'Astronauts In Space Rigt Now',
                          style: TextStyle(color: Colors.black),
                        ),
                        onTap: () {
                          Navigator.pop(context);
                          Navigator.push(context,
                              MaterialPageRoute(builder: (context) => Astro()));
                        }),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
