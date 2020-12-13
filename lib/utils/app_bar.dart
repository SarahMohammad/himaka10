import 'package:flutter/material.dart';

Widget setAppBar(String title, context) {
  return AppBar(
    centerTitle: true,
    iconTheme: IconThemeData(
      color: Colors.grey[900], //change your color here
    ),
    title: Text(
      title,
      style: TextStyle(color: Colors.grey[900]),
    ),
    leading: InkWell(
      onTap: () {
        Navigator.of(context).pop();
      },
      child: Icon(Icons.arrow_back_ios),
    ),
    backgroundColor: Colors.transparent,
    elevation: 0.0,
  );
}
