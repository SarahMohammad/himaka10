import 'dart:convert';
import 'dart:core';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:himaka/Models/login_response.dart';
import 'package:himaka/Models/pre_register_response.dart';
import 'package:himaka/ViewModels/auth_view_model.dart';
import 'package:himaka/ViewModels/base_model.dart';
import 'package:himaka/services/base_view.dart';
import 'package:himaka/services/locator.dart';
import 'package:himaka/utils/AppLanguage.dart';
import 'package:himaka/utils/app_localizations.dart';
import 'package:himaka/utils/caching.dart';
import 'package:himaka/utils/globals.dart';
import 'package:himaka/utils/show_toast.dart';

import '../home.dart';

class FourthStepSignUpScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => new _FourthStepSignUpScreenState();
}

class _FourthStepSignUpScreenState extends State<FourthStepSignUpScreen> {
  final TextEditingController _methodController = new TextEditingController();
  final TextEditingController _descController = new TextEditingController();

  WithdrawMethod val;
  String phoneNumber;
  String phoneIsoCode;
  bool visible = false;
  String confirmedNumber = '';
  final _scaffoldKey = new GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return BaseView<AuthViewModel>(
        onModelReady: (model) {
          refreshScreen(model);
        },
        builder: (context, model, child) => LayoutBuilder(builder:
                (BuildContext context, BoxConstraints viewportConstraints) {
              return model.state == ViewState.Idle
                  ? new Scaffold(
                      backgroundColor: Colors.white,
                      key: _scaffoldKey,
                      appBar: _buildBar(context),
                      body: SafeArea(
                        child: new Container(
                            padding: EdgeInsets.all(16.0),
                            child: new Column(
                              children: <Widget>[
                                SizedBox(
                                  height: 10,
                                ),
//                                    Container(
//                                      child: Text(
//                                        'by creating or logging to an account you agree to out you agree to out',
//                                        textAlign: TextAlign.center,
//                                        style: TextStyle(color: Colors.white),
//                                      ),
//                                    ),
                                Container(
                                  padding: EdgeInsets.only(top: 20.0),
                                  width: MediaQuery.of(context).size.width,
                                  child: DropdownButton<WithdrawMethod>(
                                    dropdownColor: Colors.grey,
                                    icon: Icon(
                                      Icons.arrow_drop_down,
                                      color: Colors.black,
                                    ),
                                    isExpanded: true,
                                    hint: Text(
                                      "Select the method",
                                      style: TextStyle(color: Colors.black),
                                    ),
                                    value: val,
                                    onChanged: (WithdrawMethod value) {
                                      setState(() {
                                        model.methodIdValidate = true;
                                        val = value;
                                      });
                                    },
                                    items: model.preRegisterResponse.data
                                        .withdraws_methods
                                        .map(
                                      (WithdrawMethod method) {
                                        return DropdownMenuItem<WithdrawMethod>(
                                          value: method,
                                          child: Row(
                                            children: [
                                              SizedBox(
                                                width: 10,
                                              ),
                                              Padding(
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        vertical: 10.0),
                                                child: SvgPicture.asset(
                                                  'images/icon_money.svg',
                                                  height: 25.0,
                                                  width: 25.0,
                                                  color: Colors.black,
                                                  allowDrawingOutsideViewBox:
                                                      true,
                                                ),
                                              ),
                                              SizedBox(
                                                width: 10,
                                              ),
                                              Text(
                                                method.name,
                                                style: TextStyle(
                                                    color: Colors.black),
                                              ),
                                            ],
                                          ),
                                        );
                                      },
                                    ).toList(),
                                  ),
                                ),
                                model.methodIdValidate
                                    ? Container()
                                    : Container(
                                        width: double.infinity,
                                        child: Text(
                                          AppLocalizations.of(context)
                                              .translate('list_error'),
                                          style: TextStyle(
                                              color: Colors.red[700],
                                              fontSize: 13),
                                          textAlign: TextAlign.start,
                                        ),
                                      ),
                                val != null
                                    ? Column(
                                        children: [
                                          new Container(
                                            child: new TextField(
                                              cursorColor: Colors.black,
                                              controller: _methodController,
                                              decoration: new InputDecoration(
                                                labelText: val.field_name,
                                                labelStyle: TextStyle(
                                                    color: Colors.black),
                                                hintStyle: TextStyle(
                                                    fontSize: 20.0,
                                                    color: Colors.black),
                                                errorText: model
                                                        .methodFieldValidate
                                                    ? null
                                                    : AppLocalizations.of(
                                                            context)
                                                        .translate(
                                                            'eight_validate_error'),
                                                enabledBorder:
                                                    UnderlineInputBorder(
                                                  borderSide: BorderSide(
                                                      color: Colors.black),
                                                ),
                                                focusedBorder:
                                                    UnderlineInputBorder(
                                                  borderSide: BorderSide(
                                                      color: Colors.black),
                                                ),
                                              ),
                                            ),
                                          ),
                                          new Container(
                                            child: new TextField(
                                              cursorColor: Colors.black,
                                              controller: _descController,
                                              decoration: new InputDecoration(
                                                labelText:
                                                    'Description the method you prefer to withdraw your money..',
                                                labelStyle: TextStyle(
                                                    color: Colors.black),
                                                hintStyle: TextStyle(
                                                    fontSize: 20.0,
                                                    color: Colors.black),
                                                prefixIcon: Padding(
                                                  padding: const EdgeInsets.all(
                                                      15.0),
                                                  child: SvgPicture.asset(
                                                    'images/icon_desc.svg',
                                                    height: 5.0,
                                                    width: 5.0,
                                                    allowDrawingOutsideViewBox:
                                                        true,
                                                  ),
                                                ),
                                                errorText: model.descValidate
                                                    ? null
                                                    : AppLocalizations.of(
                                                            context)
                                                        .translate(
                                                            'empty_error'),
                                                enabledBorder:
                                                    UnderlineInputBorder(
                                                  borderSide: BorderSide(
                                                      color: Colors.black),
                                                ),
                                                focusedBorder:
                                                    UnderlineInputBorder(
                                                  borderSide: BorderSide(
                                                      color: Colors.black),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      )
                                    : Container(),
                                SizedBox(
                                  height: 30,
                                ),
                                model.state == ViewState.Busy
                                    ? CircularProgressIndicator(
                                        backgroundColor: Colors.lightBlue,
                                      )
                                    : ButtonTheme(
                                        minWidth:
                                            MediaQuery.of(context).size.width,
                                        child: RaisedButton(
                                          elevation: 0.0,
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(10),
                                          ),
                                          onPressed: () {
                                            Navigator.pop(context);
//                                          if (model.forthSignUpValidation(
//                                              val,

//                                              _methodController.text.trim(),
//                                              _descController.text)) {
//                                            LoginResponse loginResponse =
//                                                // await model.register(
//                                                //     locator<AppLanguage>()
//                                                //         .appLocal
//                                                //         .languageCode,
//                                                //     widget.cPass,
//                                                //     widget.mcode,
//                                                //     widget.code,
//                                                //     widget.methodSubs,
//                                                //     widget.firstName,
//                                                //     widget.lastName,
//                                                //     widget.email,
//                                                //     widget.password,
//                                                //     widget.mobile,
//                                                //     widget.nationalId,
//                                                //     widget.pin,
//                                                //     widget.ques,
//                                                //     widget.answer,
//                                                //     val.id.toString(),
//                                                //     _methodController.text
//                                                //         .trim(),
//                                                //     _descController.text
//                                                //         .trim());
//                                                await model.register(
//                                                    locator<AppLanguage>()
//                                                        .appLocal
//                                                        .languageCode,
//                                                    widget.cPass,
//                                                    widget.mcode,
//                                                    widget.code,
//                                                    widget.methodSubs,
//                                                    widget.firstName,
//                                                    widget.lastName,
//                                                    widget.email,
//                                                    widget.password,
//                                                    widget.mobile,
//                                                    widget.nationalId,
//                                                    widget.pin,
//                                                    widget.ques,
//                                                    widget.answer);
//                                            if (loginResponse == null) {
//                                              final snackBar = SnackBar(
//                                                content: Text(
//                                                    AppLocalizations.of(context)
//                                                        .translate(
//                                                            'check_network')),
//                                                backgroundColor: Colors.red,
//                                              );
//                                              _scaffoldKey.currentState
//                                                  .showSnackBar(snackBar);
//                                            } else if (loginResponse.status &&
//                                                loginResponse.data != null &&
//                                                loginResponse.data.user !=
//                                                    null) {
//                                              saveLoginData(json.encode(
//                                                  loginResponse.data.user));
//                                              Globals.userData =
//                                                  loginResponse.data.user;
//                                              showToast(
//                                                  AppLocalizations.of(context)
//                                                      .translate(
//                                                          'auth_response_success'),
//                                                  Colors.green);
//                                              Navigator.pushAndRemoveUntil(
//                                                  context,
//                                                  MaterialPageRoute(
//                                                      builder: (context) =>
//                                                          HomePage()),
//                                                  (Route<dynamic> route) =>
//                                                      false);
//                                            } else if (!loginResponse.status) {
//                                              if (loginResponse.errors !=
//                                                      null &&
//                                                  loginResponse.errors.length >
//                                                      0) {
//                                                showToast(
//                                                    model.getRegisterErrors(
//                                                        loginResponse.errors),
//                                                    Colors.red);
//                                              } else
//                                                showToast(
//                                                    AppLocalizations.of(context)
//                                                        .translate(
//                                                            'something_went_error'),
//                                                    Colors.red);
//                                            } else {
//                                              final snackBar = SnackBar(
//                                                content: Text(
//                                                    AppLocalizations.of(context)
//                                                        .translate(
//                                                            'check_network')),
//                                                backgroundColor: Colors.red,
//                                              );
//                                              _scaffoldKey.currentState
//                                                  .showSnackBar(snackBar);
//                                            }
//                                          }
                                          },
                                          padding: EdgeInsets.all(20),
                                          color: Colors.lightBlueAccent,
                                          child: Text(
                                              AppLocalizations.of(context)
                                                  .translate('done'),
                                              style: TextStyle(
                                                  color: Colors.white)),
                                        ),
                                      ),
//                          Expanded(
//                              child: Align(
//                                  alignment:
//                                  FractionalOffset.bottomCenter,
//                                  child: RichText(
//                                    textAlign: TextAlign.center,
//                                    text: new TextSpan(
//                                      text:
//                                      'by creating or logging to an account you agree to out ',
//                                      children: <TextSpan>[
//                                        new TextSpan(
//                                            text:
//                                            'terms and conditions',
//                                            style: new TextStyle(
//                                              decoration:
//                                              TextDecoration
//                                                  .underline,
//                                            )),
//                                        new TextSpan(text: ' and '),
//                                        new TextSpan(
//                                          text: 'privacy policy',
//                                          style: new TextStyle(
//                                            decoration: TextDecoration
//                                                .underline,
//                                          ),
//                                          recognizer:
//                                          new TapGestureRecognizer()
//                                            ..onTap = () => print(
//                                                'Tap Here onTap'),
//                                        ),
//                                      ],
//                                    ),
//                                  )))
                              ],
                            )),
                      ),
                    )
                  : Center(
                      child: CircularProgressIndicator(
                        backgroundColor: Colors.lightBlue,
                      ),
                    );
            }));
  }

  Widget _buildBar(BuildContext context) {
    return new AppBar(
      title: new Text(
        AppLocalizations.of(context).translate('change_withdraw'),
        style: TextStyle(color: Colors.black),
      ),
      centerTitle: true,
      backgroundColor: Colors.transparent,
      elevation: 0.0,
    );
  }

  void refreshScreen(AuthViewModel model) {
    model.preRegister(locator<AppLanguage>().appLocal.languageCode);
  }
}
