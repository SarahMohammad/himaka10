import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:himaka/Screens/SignUp/signup_screen.dart';
import 'package:himaka/Screens/signin_screen.dart';
import 'package:himaka/Screens/start_screen.dart';
import 'package:himaka/utils/AppLanguage.dart';
import 'package:himaka/utils/app_localizations.dart';
import 'package:provider/provider.dart';

class LanguageScreen extends StatefulWidget {
  @override
  _LanguageScreenState createState() => _LanguageScreenState();
}

class _LanguageScreenState extends State<LanguageScreen> {
  @override
  @override
  Widget build(BuildContext context) {
    var appLanguage = Provider.of<AppLanguage>(context);

    return Stack(
      children: [
        Image.asset(
          "images/blur_bg.jpg",
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          fit: BoxFit.cover,
        ),
        Scaffold(
            backgroundColor: Colors.transparent,
            body: Padding(
              padding:
                  const EdgeInsets.symmetric(vertical: 8.0, horizontal: 14.0),
              child: Container(
//                color: Colors.green,
                child: Column(
                  children: [
                    SizedBox(
                      height: 50,
                    ),
                    Image.asset(
                      "images/logo.png",
//                      height: MediaQuery.of(context).size.height/10,
//                      width: MediaQuery.of(context).size.width,
                      fit: BoxFit.cover,
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width,
                      child: Text(
                        AppLocalizations.of(context).translate('hello'),
                        textAlign: TextAlign.start,
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 24,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width,
                      child: Text(
                        AppLocalizations.of(context).translate('choose_lang'),
                        textAlign: TextAlign.start,
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    Card(
                      color: Colors.white,
                      child: ExpansionTile(
                          leading:
                              Icon(Icons.language, color: Colors.grey[800]),
                          title: Text(
                            AppLocalizations.of(context).translate('lang'),
                            style: TextStyle(color: Colors.grey[800]),
                          ),
//                        trailing: Icon(
//                          Icons.arrow_forward_ios,
//                          color: Colors.lightBlue,
//                        ),
                          children: <Widget>[
                            Container(
                              child: Padding(
                                padding: const EdgeInsets.all(1.0),
                                child: ListTile(
                                  title: Text(
                                    'English',
                                    textDirection: TextDirection.ltr,
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  onTap: () {
                                    setState(() {
                                      appLanguage.changeLanguage(Locale("en"));
                                    });
                                  },
                                ),
                              ),
                              color: Colors.lightBlueAccent,
                            ),
                            Padding(
                              padding: const EdgeInsets.all(1.0),
                              child: ListTile(
                                  onTap: () {
                                    setState(() {
                                      appLanguage.changeLanguage(Locale("ar"));
                                    });
                                  },
                                  title: Text("العربيه",
                                      textDirection: TextDirection.rtl,
                                      style: TextStyle(
                                          color: Colors.lightBlueAccent,
                                          fontWeight: FontWeight.bold))),
                            ),
                          ]),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(vertical: 16.0),
                      child: ButtonTheme(
                        minWidth: MediaQuery.of(context).size.width,
                        child: RaisedButton(
                          elevation: 0.0,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          onPressed: () {
                            Navigator.push(
                                context,
                                new MaterialPageRoute(
                                    builder: (context) => new StartScreen()));
                          },
                          padding: EdgeInsets.all(20),
                          color: Colors.lightBlueAccent,
                          child: Text(
                              AppLocalizations.of(context).translate('done'),
                              style: TextStyle(color: Colors.white)),
                        ),
                      ),
                    ),
                    Expanded(
                      child: Align(
                          alignment: FractionalOffset.bottomCenter,
                          child: RichText(
                            textAlign: TextAlign.center,
                            text: new TextSpan(
                              text:
                                  'by creating or logging to an account you agree to out ',
                              children: <TextSpan>[
                                new TextSpan(
                                    text: AppLocalizations.of(context)
                                        .translate('terms_and_conditions'),
                                    style: new TextStyle(
                                      decoration: TextDecoration.underline,
                                    )),
                                new TextSpan(text: ' and '),
                                new TextSpan(
                                  text: AppLocalizations.of(context)
                                      .translate('privacy_policy'),
                                  style: new TextStyle(
                                    decoration: TextDecoration.underline,
                                  ),
                                  recognizer: new TapGestureRecognizer()
                                    ..onTap = () => print('Tap Here onTap'),
                                ),
                              ],
                            ),
                          )),
                    ),
                    SizedBox(
                      height: 50,
                    ),
                  ],
                ),
              ),
            ))
      ],
    );
  }
}
