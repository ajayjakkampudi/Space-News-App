import 'package:flutter/material.dart';
import 'package:spacenews1/Buttons.dart';
import 'package:spacenews1/information_page.dart';
import 'package:spacenews1/main.dart';

class Settings extends StatefulWidget {
  Settings({Key? key}) : super(key: key);

  @override
  _SettingsState createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  var l = ["Small", "Medium", "Large"];

  int _value = 1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Settings',
        ),
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(Icons.arrow_back_ios_new)),
        backgroundColor: Colors.grey[800],
        centerTitle: true,
      ),
      backgroundColor: Colors.grey[900],
      body: Column(
        //mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(28, 8, 0, 0),
            child: Text(
              'Choose your Font Size',
              style: TextStyle(fontSize: 23, color: Colors.white),
            ),
          ),
          for (int i = 0; i < l.length; i++)
            ListTile(
              title: Text(
                l[i],
                style: TextStyle(color: Colors.white),
              ),
              leading: Theme(
                data: ThemeData.light(),
                child: Radio(
                    activeColor: Colors.white,
                    hoverColor: Colors.white,
                    value: i,
                    groupValue: _value,
                    onChanged: (value) {
                      setState(() {
                        _value = i;
                        if (_value == 1) {
                          siz = 25.0;
                        } else if (_value == 2) {
                          siz = 35.0;
                        } else if (_value == 0) {
                          siz = 10.0;
                        }
                      });
                    }),
              ),
            )
        ],
      ),
    );
  }
}

TextStyle textstyle(double s) {
  return TextStyle(fontSize: s, color: Colors.white);
}
