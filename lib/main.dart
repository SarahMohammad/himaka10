import 'package:flutter/material.dart';
import 'package:himaka/Screens/language_screen.dart';
import 'package:himaka/Screens/start_screen.dart';
import 'package:himaka/services/base_view.dart';
import 'package:himaka/services/locator.dart';
import 'package:himaka/utils/AppLanguage.dart';
import 'package:himaka/utils/app_localizations.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:himaka/utils/caching.dart';
import 'package:himaka/utils/globals.dart';
import 'package:animated_splash/animated_splash.dart';

import 'Screens/home.dart';

void main() async {
  setupLocator();
  WidgetsFlutterBinding.ensureInitialized();
  AppLanguage appLanguage = AppLanguage();
  await appLanguage.fetchLocale();
  runApp(MyApp(
    appLanguage: appLanguage,
  ));
}

class MyApp extends StatefulWidget {
  final AppLanguage appLanguage;

  MyApp({this.appLanguage});

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  String _login;

  @override
  void initState() {
    super.initState();
    if (widget.appLanguage != null)
      locator<AppLanguage>().changeLanguage(widget.appLanguage.appLocal);
    isLogin().then((value) {
      if (value != null) {
        _login = "true";
        Globals.userData = value;
      } else {
        _login = "false";
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return BaseView<AppLanguage>(
        builder: (context, model, child) => LayoutBuilder(builder:
                (BuildContext context, BoxConstraints viewportConstraints) {
              return MaterialApp(
                locale: model.appLocal,
                supportedLocales: [
                  Locale('en', 'US'),
                  Locale('ar', ''),
                ],
                localizationsDelegates: [
                  AppLocalizations.delegate,
                  GlobalMaterialLocalizations.delegate,
                  GlobalWidgetsLocalizations.delegate,
                ],
                debugShowCheckedModeBanner: false,
                title: 'Flutter Demo',
                theme: ThemeData(
                    primarySwatch: Colors.blue,
                    visualDensity: VisualDensity.adaptivePlatformDensity,
                    inputDecorationTheme: const InputDecorationTheme(
                      labelStyle:
                          TextStyle(color: Colors.white, fontFamily: 'balance'),
                      hintStyle:
                          TextStyle(color: Colors.white, fontFamily: 'roboto'),
                    )),
                home: AnimatedSplash(
                  imagePath: 'images/logo.png',
//                  customFunction: duringSplash,
                  duration: 1200,
                  type: AnimatedSplashType.StaticDuration,
                  home: SafeArea(
                      child: _login == "true" ? HomePage() : LanguageScreen()),
                ),
              );
            }));
  }

//  Function duringSplash = () {
//    print('Something background process');
//    int a = 123 + 23;
//    print(a);
//
//    if (a > 100)
//      return 1;
//    else
//      return 2;
//  };
}
