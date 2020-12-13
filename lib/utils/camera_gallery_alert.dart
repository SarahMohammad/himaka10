import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'app_localizations.dart';

Future cameraLibraryDialog(BuildContext context) async {
  return showDialog<void>(
    context: context,
    barrierDismissible: true, // user must tap button!
    builder: (BuildContext context) {
      return AlertDialog(
        backgroundColor: Colors.white,
        title: Text(
          AppLocalizations.of(context).translate('select_from'),
          textAlign: TextAlign.center,
          style: TextStyle(
              fontFamily: 'ArbFont', color: Colors.black38),
        ),
        actions: <Widget>[
          FlatButton(
            child: Text(
                AppLocalizations.of(context).translate('camera'),
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.blue,
                    fontFamily: 'ArbFont')),
            onPressed: () {
              Navigator.pop(context, '1');
            },
          ),
          FlatButton(
            child: ClipRRect(
              borderRadius: BorderRadius.circular(30.0),
              child: Container(
                color: Colors.blueAccent,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                      AppLocalizations.of(context).translate('gallery'),
                      style: TextStyle(
                          fontWeight: FontWeight.bold, fontFamily: 'ArbFont',color: Colors.white)),
                ),
              ),
            ),
            onPressed: () {
              Navigator.of(context).pop('2');
            },
          ),
        ],
      );
    },
  );
}
