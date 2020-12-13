import 'package:flutter/material.dart';
import 'package:himaka/Screens/change_question_screen.dart';
import 'package:himaka/Screens/search_screen.dart';
import 'package:himaka/utils/app_localizations.dart';
import 'package:himaka/utils/globals.dart';
import 'package:himaka/utils/show_toast.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

Future<void> pinPassValidateDialog(context) async {
  TextEditingController passwordKeyController = new TextEditingController();
  TextEditingController pinKeyController = new TextEditingController();
  Alert(
      title: '',
      type: AlertType.none,
      context: context,
      content: Column(
        children: <Widget>[
          TextField(
            controller: pinKeyController,
            decoration: InputDecoration(
              labelStyle: TextStyle(color: Colors.black38),
              hintStyle: TextStyle(color: Colors.black38),
              labelText: AppLocalizations.of(context).translate('pin'),
              hintText: AppLocalizations.of(context).translate('pin'),
              border: OutlineInputBorder(
                gapPadding: 0.0,
                borderRadius: BorderRadius.circular(1.5),
              ),
            ),
          ),
          SizedBox(
            height: 6,
          ),
          TextField(
            controller: passwordKeyController,
            decoration: InputDecoration(
              labelStyle: TextStyle(color: Colors.black38),
              hintStyle: TextStyle(color: Colors.black38),
              labelText: AppLocalizations.of(context).translate('password'),
              hintText: AppLocalizations.of(context).translate('password'),
              border: OutlineInputBorder(
                gapPadding: 0.0,
                borderRadius: BorderRadius.circular(1.5),
              ),
            ),
          ),
        ],
      ),
      buttons: [
        DialogButton(
          onPressed: () {
            print(Globals.userData.pin.toString() +
                Globals.userData.password.toString());
            if (pinKeyController.text.isNotEmpty &&
                passwordKeyController.text.isNotEmpty) {
              if (pinKeyController.text == Globals.userData.pin &&
                  passwordKeyController.text == Globals.userData.password) {
                Navigator.push(
                    context,
                    new MaterialPageRoute(
                        builder: (context) => new ChangeQuestionScreen(
                            Globals.userData.question.toString(),
                            Globals.userData.answer.toString())));
              } else {
                showToast("invalid data", Colors.red);
              }
            } else {
              showToast("fill both fields", Colors.red);
            }
//            if (searchKeyController.text.isNotEmpty) {
//              var result = await Navigator.push(
//                  context,
//                  new MaterialPageRoute(
//                      builder: (context) => new SearchScreen(
//                          callback, searchKeyController.text, screenIndex)));
//              if (result == null) Navigator.pop(context);
//            } else
//              Navigator.pop(context);
          },
          child: Text(
            AppLocalizations.of(context).translate('done'),
            style: TextStyle(color: Colors.white, fontSize: 20),
          ),
        )
      ]).show();
}
