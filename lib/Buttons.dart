import 'package:flutter/material.dart';

Widget iconbuttons(icon) {
  return IconButton(onPressed: () {}, icon: Icon(icon));
}

Widget listtile(String name, ctx, other()) {
  return ListTile(
    title: Text(name),
  );
}

AppBar app(String name) {
  return AppBar(
    title: Text(name),
  );
}
