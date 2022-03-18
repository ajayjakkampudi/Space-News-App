import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';

// ignore: must_be_immutable
class Comments extends StatefulWidget {
  Comments({Key? key}) : super(key: key);

  @override
  _CommentsState createState() => _CommentsState();
}

class _CommentsState extends State<Comments> {
  late String textNote;
  late TextEditingController _comments;

  late CollectionReference comment =
      FirebaseFirestore.instance.collection('comments');

  @override
  void initState() {
    _comments = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _comments.dispose();
    super.dispose();
    setState(() {});
  }

  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          leading: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: Icon(Icons.arrow_back_ios_new)),
          backgroundColor: Colors.grey[700],
        ),
        backgroundColor: Colors.grey,
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              DefaultTextStyle(
                style: TextStyle(fontSize: 20, color: Colors.white),
                child: Text(
                  'Let us Know if any errors',
                  textAlign: TextAlign.justify,
                  style: TextStyle(
                      fontWeight: FontWeight.bold, color: Colors.white),
                ),
              ),
              TextFormField(
                controller: _comments,
                onChanged: (value) => (value.length > 0)
                    ? textNote = value
                    : 'Comment Section Should not be null',
                decoration: InputDecoration(
                  labelStyle: TextStyle(color: Colors.white),
                  hintStyle: TextStyle(color: Colors.white),
                  hintText: 'Comment and Submit it once',
                ),
              ),
              /*RaisedButton(
                  onPressed: () async {
                    await comment.add({'comments': textNote}).then((value) {
                      // Navigator.pop(context);
                    });*/
              Builder(
                  builder: (context) => Center(
                        child: RaisedButton(
                          onPressed: () async {
                            await comment.add({'comments': textNote});
                            //Navigator.pop(context);
                            final snackBar = SnackBar(
                              behavior: SnackBarBehavior.floating,
                              content: Text('Thanks for Commenting'),
                              action: SnackBarAction(
                                label: 'OK',
                                onPressed: () {
                                  // Some code to undo the change.
                                },
                              ),
                            );

                            ScaffoldMessenger.of(context)
                                .showSnackBar(snackBar);
                          },
                          child: Text('Submit'),
                        ),
                      )),
              //setState(() {});
            ],
          ),
        ),
      ),
    );
  }
}

/*class Snackbar extends StatelessWidget {
  const Snackbar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final snackbar = SnackBar(
      content: Text('Yay! A SnackBar!'),
      action: SnackBarAction(
        label: 'Undo',
        onPressed: () {
          // Some code to undo the change.
        },
      ),
    );
    return ScaffoldMessenger.of(context).showSnackBar(snackbar);
  }
}*/
