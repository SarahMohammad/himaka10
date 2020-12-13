import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:himaka/utils/app_localizations.dart';

class ForgotPasswordScreen extends StatefulWidget {
  @override
  _ForgotPasswordScreenState createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  TextEditingController emailController = new TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Stack(children: [
      Image.asset(
        "images/blur_bg.jpg",
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        fit: BoxFit.cover,
      ),
      Scaffold(
        backgroundColor: Colors.transparent,
        body: Container(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25.0),
            child: ListView(
              children: <Widget>[
                Container(
                  child: Image.asset(
                    "images/logo.png",
                  ),
                ),
                Center(
                    child: Text(
                  AppLocalizations.of(context).translate("forget_password"),
                  style: TextStyle(fontSize: 25, color: Colors.white),
                )),
                SizedBox(
                  height: 30,
                ),
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
//                      errorText: model.emailValidate
//                          ? null
//                          : AppLocalizations.of(context)
//                              .translate('email_error'),
                    hintText: AppLocalizations.of(context).translate('email'),
                    hintStyle: TextStyle(color: Colors.grey),
                    contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0)),
                  ),
                ),
                SizedBox(height: 24.0),
//                  model.state == ViewState.Busy
//                      ? CircularProgressIndicator(
//                          backgroundColor: Colors.lightBlue,
//                        )
//                      :
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 16.0),
                  child: ButtonTheme(
                    minWidth: MediaQuery.of(context).size.width,
                    child: RaisedButton(
                      elevation: 0.0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      onPressed: () {},
                      padding: EdgeInsets.all(20),
                      color: Colors.lightBlueAccent,
                      child: Text(
                          AppLocalizations.of(context).translate('send'),
                          style: TextStyle(color: Colors.white)),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    ]);
  }
}
