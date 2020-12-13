import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:himaka/Models/pre_register_response.dart';
import 'package:himaka/Screens/SignUp/third_step_signup_screen.dart';
import 'package:himaka/ViewModels/auth_view_model.dart';
import 'package:himaka/services/base_view.dart';
import 'package:himaka/utils/app_localizations.dart';

import '../../Models/login_response.dart';
import '../../ViewModels/base_model.dart';
import '../../services/locator.dart';
import '../../utils/AppLanguage.dart';
import '../../utils/show_toast.dart';

class SecondStepSignUpScreen extends StatefulWidget {
  String firstName,
      lastName,
      email,
      password,
      mcode,
      cPass,
      mobile,
      code,
      nationalId;
  PreRegisterData data;

  SecondStepSignUpScreen(
      {this.firstName,
      this.lastName,
      this.email,
      this.password,
      this.cPass,
      this.mobile,
      this.mcode,
      this.code,
      this.data,
      this.nationalId});

  @override
  State<StatefulWidget> createState() => new _SecondStepSignUpScreenState();
}

class _SecondStepSignUpScreenState extends State<SecondStepSignUpScreen> {
  final TextEditingController _pinController = new TextEditingController();
  final TextEditingController _answerController = new TextEditingController();
  final _scaffoldKey = new GlobalKey<ScaffoldState>();

  String val;
  bool visible = false;
  String confirmedNumber = '';
  List<String> users = <String>[
    'In what city did your parents meet?',
    'What is your favorite color?',
    'What is your current job?',
    'What is your favorite team?',
    'What is your favorite movie?',
    'In what town was your first job?',
    'What is the color of your eyes?',
  ];

  @override
  Widget build(BuildContext context) {
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
                  new Scaffold(
                    backgroundColor: Colors.transparent,
                    appBar: _buildBar(context),
                    key: _scaffoldKey,
                    body: SafeArea(
                      child: SingleChildScrollView(
                        child: ConstrainedBox(
                          constraints: BoxConstraints(
                            minHeight: viewportConstraints.minHeight,
                          ),
                          child: new Container(
                              height: MediaQuery.of(context).size.height,
                              padding: EdgeInsets.all(16.0),
                              child: new Column(
                                children: <Widget>[
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Container(
                                    child: Text(
                                      'To protect your money through withdraw process you answer the question and enter the PIN',
                                      textAlign: TextAlign.center,
                                      style: TextStyle(color: Colors.white),
                                    ),
                                  ),
                                  Container(
                                    child: new TextField(
                                      textAlign: TextAlign.center,
                                      cursorColor: Colors.white,
                                      controller: _pinController,
                                      decoration: new InputDecoration(
                                        errorText: model.pinValidate
                                            ? null
                                            : AppLocalizations.of(context)
                                                .translate(
                                                    'four_validate_error'),
                                        contentPadding: EdgeInsets.all(0),
                                        hintText: 'PIN',
                                        // labelText: 'PIN',
                                        // alignLabelWithHint: false,
                                        hintStyle: TextStyle(
                                          fontSize: 20.0,
                                          color: Colors.white,
                                        ),
                                        enabledBorder: UnderlineInputBorder(
                                          borderSide:
                                              BorderSide(color: Colors.white),
                                        ),
                                        focusedBorder: UnderlineInputBorder(
                                          borderSide:
                                              BorderSide(color: Colors.white),
                                        ),
                                      ),
                                    ),
                                  ),
                                  Container(
                                    padding: EdgeInsets.only(top: 20.0),
                                    width: MediaQuery.of(context).size.width,
                                    child: DropdownButton<String>(
                                      dropdownColor: Colors.grey,
                                      icon: Icon(
                                        Icons.arrow_drop_down,
                                        color: Colors.white,
                                      ),
                                      isExpanded: true,
                                      hint: Text(
                                        "Choose a question for your security",
                                        style: TextStyle(color: Colors.white),
                                      ),
                                      value: val,
                                      onChanged: (String value) {
                                        setState(() {
                                          val = value;
                                        });
                                      },
                                      items: users.map(
                                        (String question) {
                                          return DropdownMenuItem<String>(
                                            value: question,
                                            child: Row(
                                              children: [
                                                SizedBox(
                                                  width: 10,
                                                ),
                                                Icon(
                                                  Icons.help_outline,
                                                  color: Colors.white,
                                                ),
                                                SizedBox(
                                                  width: 10,
                                                ),
                                                Text(
                                                  question,
                                                  style: TextStyle(
                                                      color: Colors.white),
                                                ),
                                              ],
                                            ),
                                          );
                                        },
                                      ).toList(),
                                    ),
                                  ),
                                  model.quesValidate
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
                                  Container(
                                    child: new TextField(
                                      controller: _answerController,
                                      decoration: new InputDecoration(
                                        errorText: model.answerValidate
                                            ? null
                                            : AppLocalizations.of(context)
                                                .translate(
                                                    'four_validate_error'),
                                        labelText:
                                            'Answer the question have been chosen',
                                        prefixIcon: Padding(
                                          padding: const EdgeInsets.all(15.0),
                                          child: SvgPicture.asset(
                                            'images/icon_answers.svg',
                                            height: 5.0,
                                            width: 5.0,
                                            color: Colors.white,
                                            allowDrawingOutsideViewBox: true,
                                          ),
                                        ),
                                        enabledBorder: UnderlineInputBorder(
                                          borderSide:
                                              BorderSide(color: Colors.white),
                                        ),
                                        focusedBorder: UnderlineInputBorder(
                                          borderSide:
                                              BorderSide(color: Colors.white),
                                        ),
                                      ),
                                    ),
                                  ),
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
                                            onPressed: () async {
                                              if (model.secondSignUpValidation(
                                                  _pinController.text.trim(),
                                                  val,
                                                  _answerController.text
                                                      .trim())) {
                                                LoginResponse loginResponse =
                                                    await model
                                                        .validateRegisterPage2(
                                                            locator<AppLanguage>()
                                                                .appLocal
                                                                .languageCode,
                                                            _pinController.text,
                                                            val,
                                                            _answerController
                                                                .text
                                                                .trim());
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
                                                    .status) {
                                                  Navigator.push(
                                                      context,
                                                      new MaterialPageRoute(
                                                          builder: (context) =>
                                                              new ThirdStepSignUpScreen(
                                                                firstName: widget
                                                                    .firstName,
                                                                lastName: widget
                                                                    .lastName,
                                                                email: widget
                                                                    .email,
                                                                password: widget
                                                                    .password,
                                                                cPass: widget
                                                                    .cPass,
                                                                mobile: widget
                                                                    .mobile,
                                                                mcode: widget
                                                                    .mcode,
                                                                code:
                                                                    widget.code,
                                                                pin:
                                                                    _pinController
                                                                        .text,
                                                                ques: val,
                                                                answer:
                                                                    _answerController
                                                                        .text
                                                                        .trim(),
                                                                data:
                                                                    widget.data,
                                                                nationalId: widget
                                                                    .nationalId,
                                                              )));
                                                } else if (!loginResponse
                                                    .status) {
                                                  if (loginResponse.errors !=
                                                          null &&
                                                      loginResponse
                                                              .errors.length >
                                                          0) {
                                                    showToast(
                                                        model.getRegisterErrors(
                                                            loginResponse
                                                                .errors),
                                                        Colors.red);
                                                  } else
                                                    showToast(
                                                        AppLocalizations.of(
                                                                context)
                                                            .translate(
                                                                'something_went_error'),
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
//
                                            },
                                            padding: EdgeInsets.all(20),
                                            color: Colors.lightBlueAccent,
                                            child: Text('Next',
                                                style: TextStyle(
                                                    color: Colors.white)),
                                          ),
                                        ),
                                  Expanded(
                                      child: Align(
                                          alignment:
                                              FractionalOffset.bottomCenter,
                                          child: RichText(
                                            textAlign: TextAlign.center,
                                            text: new TextSpan(
                                              text:
                                                  'by creating or logging to an account you agree to out ',
                                              children: <TextSpan>[
                                                new TextSpan(
                                                    text:
                                                        'terms and conditions',
                                                    style: new TextStyle(
                                                      decoration: TextDecoration
                                                          .underline,
                                                    )),
                                                new TextSpan(text: ' and '),
                                                new TextSpan(
                                                  text: 'privacy policy',
                                                  style: new TextStyle(
                                                    decoration: TextDecoration
                                                        .underline,
                                                  ),
                                                  recognizer:
                                                      new TapGestureRecognizer()
                                                        ..onTap = () => print(
                                                            'Tap Here onTap'),
                                                ),
                                              ],
                                            ),
                                          )))
                                ],
                              )),
                        ),
                      ),
                    ),
                  ),
                ],
              );
            }));
  }

  Widget _buildBar(BuildContext context) {
    return new AppBar(
      title: new Text("Sign up"),
      centerTitle: true,
      backgroundColor: Colors.transparent,
      elevation: 0.0,
    );
  }
}
