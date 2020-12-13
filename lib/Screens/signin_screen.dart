import 'dart:convert';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:himaka/Models/login_response.dart';
import 'package:himaka/Screens/forget_password_screen.dart';
import 'package:himaka/Screens/home.dart';
import 'package:himaka/ViewModels/auth_view_model.dart';
import 'package:himaka/ViewModels/base_model.dart';
import 'package:himaka/services/base_view.dart';
import 'package:himaka/utils/app_localizations.dart';
import 'package:himaka/utils/caching.dart';
import 'package:himaka/utils/globals.dart';
import 'package:himaka/utils/show_toast.dart';

class SignInScreen extends StatefulWidget {
  @override
  _SignInScreenState createState() => new _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final _scaffoldKey = new GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    final forgotLabel = Align(
        alignment: FractionalOffset.bottomCenter,
        child: RichText(
          textAlign: TextAlign.center,
          text: new TextSpan(
            text: 'by creating or logging to an account you agree to out ',
            children: <TextSpan>[
              new TextSpan(
                  text: 'terms and conditions',
                  style: new TextStyle(
                    decoration: TextDecoration.underline,
                  )),
              new TextSpan(text: ' and '),
              new TextSpan(
                text: 'privacy policy',
                style: new TextStyle(
                  decoration: TextDecoration.underline,
                ),
                recognizer: new TapGestureRecognizer()
                  ..onTap = () => print('Tap Here onTap'),
              ),
            ],
          ),
        ));

    return BaseView<AuthViewModel>(
        builder: (context, model, child) => LayoutBuilder(builder:
                (BuildContext context, BoxConstraints viewportConstraints) {
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
                    key: _scaffoldKey,
                    body: Container(
                      padding:
                          EdgeInsets.only(left: 24.0, right: 24.0, top: 16),
                      child: SingleChildScrollView(
                        child: ConstrainedBox(
                          constraints: BoxConstraints(
                            minHeight: viewportConstraints.minHeight,
                          ),
                          child: Container(
                            height: MediaQuery.of(context).size.height,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Container(
                                  child: Image.asset(
                                    "images/logo.png",
                                  ),
                                ),
                                SizedBox(height: 20.0),
                                Text(
                                    AppLocalizations.of(context)
                                        .translate('sign_in'),
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 24)),
                                SizedBox(height: 20.0),
                                TextFormField(
                                  keyboardType: TextInputType.emailAddress,
                                  controller: emailController,
                                  autofocus: false,
                                  decoration: InputDecoration(
                                    fillColor: Colors.white,
                                    filled: true,
                                    prefixIcon: Padding(
                                      padding: const EdgeInsets.all(15.0),
                                      child: SvgPicture.asset(
                                        'images/icon_mail.svg',
                                        height: 5.0,
                                        width: 5.0,
                                        allowDrawingOutsideViewBox: true,
                                      ),
                                    ),
                                    errorText: model.emailValidate
                                        ? null
                                        : AppLocalizations.of(context)
                                            .translate('email_error'),
                                    hintText: AppLocalizations.of(context)
                                        .translate('email'),
                                    hintStyle: TextStyle(color: Colors.grey),
                                    contentPadding: EdgeInsets.fromLTRB(
                                        20.0, 10.0, 20.0, 10.0),
                                    border: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(10.0)),
                                  ),
                                ),
                                SizedBox(height: 16.0),
                                TextFormField(
                                  autofocus: false,
                                  obscureText: true,
                                  controller: passwordController,
                                  decoration: InputDecoration(
                                    prefixIcon: Padding(
                                      padding: const EdgeInsets.all(15.0),
                                      child: SvgPicture.asset(
                                        'images/icon_padlock.svg',
                                        height: 5.0,
                                        width: 5.0,
                                        allowDrawingOutsideViewBox: true,
                                      ),
                                    ),
                                    hintText: AppLocalizations.of(context)
                                        .translate('password'),
                                    errorText: model.passwordValidate
                                        ? null
                                        : AppLocalizations.of(context)
                                            .translate('empty_error'),
                                    fillColor: Colors.white,
                                    hintStyle: TextStyle(color: Colors.grey),
                                    filled: true,
                                    contentPadding: EdgeInsets.fromLTRB(
                                        20.0, 10.0, 20.0, 10.0),
                                    border: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(10.0)),
                                  ),
                                ),
                                SizedBox(height: 24.0),
                                model.state == ViewState.Busy
                                    ? CircularProgressIndicator(
                                        backgroundColor: Colors.lightBlue,
                                      )
                                    : Padding(
                                        padding: EdgeInsets.symmetric(
                                            vertical: 16.0),
                                        child: ButtonTheme(
                                          minWidth:
                                              MediaQuery.of(context).size.width,
                                          child: RaisedButton(
                                            elevation: 0.0,
                                            shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                            ),
                                            onPressed: () async {
                                              if (model.authValidation(
                                                  emailController.text.trim(),
                                                  passwordController.text)) {
                                                LoginResponse loginResponse =
                                                    await model.login(
                                                        emailController.text
                                                            .trim(),
                                                        passwordController
                                                            .text);
                                                if (loginResponse == null) {
                                                  final snackBar = SnackBar(
                                                    content: Text(
                                                        AppLocalizations.of(
                                                                context)
                                                            .translate(
                                                                'check_network')),
                                                    backgroundColor: Colors.red,
                                                  );
                                                  _scaffoldKey.currentState
                                                      .showSnackBar(snackBar);
                                                } else if (loginResponse
                                                        .status &&
                                                    loginResponse.data !=
                                                        null &&
                                                    loginResponse.data.user !=
                                                        null) {
                                                  saveLoginData(json.encode(
                                                      loginResponse.data.user));
                                                  Globals.userData =
                                                      loginResponse.data.user;
                                                  Globals.userData.password =
                                                      passwordController.text;

                                                  showToast(
                                                      AppLocalizations.of(
                                                              context)
                                                          .translate(
                                                              'auth_response_success'),
                                                      Colors.green);
                                                  Navigator.pushAndRemoveUntil(
                                                      context,
                                                      MaterialPageRoute(
                                                          builder: (context) =>
                                                              HomePage()),
                                                      (Route<dynamic> route) =>
                                                          false);
                                                } else if (!loginResponse
                                                    .status) {
                                                  showToast(
                                                      AppLocalizations.of(
                                                              context)
                                                          .translate(
                                                              'auth_response_error'),
                                                      Colors.red);
                                                } else {
                                                  final snackBar = SnackBar(
                                                    content: Text(
                                                        AppLocalizations.of(
                                                                context)
                                                            .translate(
                                                                'check_network')),
                                                    backgroundColor: Colors.red,
                                                  );
                                                  _scaffoldKey.currentState
                                                      .showSnackBar(snackBar);
                                                }
                                              }
//                                              Navigator.pushAndRemoveUntil(
//                                                  context,
//                                                  MaterialPageRoute(
//                                                      builder: (context) =>
//                                                          HomePage()),
//                                                  (Route<dynamic> route) =>
//                                                      false);
                                            },
                                            padding: EdgeInsets.all(20),
                                            color: Colors.lightBlueAccent,
                                            child: Text(
                                                AppLocalizations.of(context)
                                                    .translate('login'),
                                                style: TextStyle(
                                                    color: Colors.white)),
                                          ),
                                        ),
                                      ),
                                SizedBox(height: 50.0),
                                InkWell(
                                  onTap: () {
                                    Navigator.push<Widget>(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            ForgotPasswordScreen(),
                                      ),
                                    );
                                  },
                                  child: Text(
                                      AppLocalizations.of(context)
                                          .translate('did_you_forgot_pass'),
                                      style: new TextStyle(
                                          decoration: TextDecoration.underline,
                                          color: Colors.white)),
                                ),
                                SizedBox(height: 40.0),
                                forgotLabel,
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              );
            }));
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    emailController.dispose();
    passwordController.dispose();
  }
}
