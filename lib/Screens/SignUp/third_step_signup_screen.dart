import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:himaka/Models/login_response.dart';
import 'package:himaka/Models/pre_register_response.dart';
import 'package:himaka/Screens/SignUp/fourth_step_signup_screen.dart';
import 'package:himaka/Screens/start_screen.dart';
import 'package:himaka/ViewModels/auth_view_model.dart';
import 'package:himaka/ViewModels/base_model.dart';
import 'package:himaka/services/base_view.dart';
import 'package:himaka/services/locator.dart';
import 'package:himaka/utils/AppLanguage.dart';
import 'package:himaka/utils/app_localizations.dart';
import 'package:himaka/utils/show_toast.dart';

class ThirdStepSignUpScreen extends StatefulWidget {
  String firstName,
      lastName,
      email,
      password,
      cPass,
      mcode,
      mobile,
      code,
      pin,
      ques,
      answer, nationalId;
  PreRegisterData data;

  ThirdStepSignUpScreen(
      {this.firstName,
      this.lastName,
      this.email,
      this.password,
      this.cPass,
      this.mobile,
      this.mcode,
      this.code,
      this.pin,
      this.ques,
      this.answer,
      this.data,this.nationalId}); // ThirdStepSignUpScreen(this.data);

  @override
  State<StatefulWidget> createState() => new _ThirdStepSignUpScreenState();
}

class _ThirdStepSignUpScreenState extends State<ThirdStepSignUpScreen> {
  String val;
  String phoneNumber;
  String phoneIsoCode;
  bool visible = false;
  String confirmedNumber = '';
  final _scaffoldKey = new GlobalKey<ScaffoldState>();
  static const platform = const MethodChannel("intergration");

  void _callFawryAPI() {
    _openPayment() ;
  }

  void _openPayment() async {
    String result= await platform.invokeMethod("payment",{'cost': '200'});
    print("status ya developer:"+result);
    Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(
            builder: (context) =>
                StartScreen()),
            (Route<dynamic> route) =>
        false);
  }

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
                              Container(
                                child: Text(
                                  'Select the amount of your annual subscription in order to receive the commission money ',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(color: Colors.white),
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
                                    "Choose your currency",
                                    style: TextStyle(color: Colors.white),
                                  ),
                                  value: val,
                                  onChanged: (String value) {
                                    setState(() {
                                      model.selectedSubscription = null;
                                      val = value;
                                    });
                                  },
                                  items: widget.data.currencies1.currencies.keys
                                      .map(
                                    (String question) {
                                      return DropdownMenuItem<String>(
                                        value: question,
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
                                                color: Colors.white,
                                                allowDrawingOutsideViewBox:
                                                    true,
                                              ),
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
                              model.currencyValidate
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
                                padding: EdgeInsets.only(top: 20.0),
                                width: MediaQuery.of(context).size.width,
                                child: DropdownButton<CurrencyData>(
                                  dropdownColor: Colors.grey,
                                  icon: Icon(
                                    Icons.arrow_drop_down,
                                    color: Colors.white,
                                  ),
                                  isExpanded: true,
                                  hint: Text(
                                    "Select an annual subscription",
                                    style: TextStyle(color: Colors.white),
                                  ),
                                  value: model.selectedSubscription,
                                  onChanged: (CurrencyData value) {
                                    setState(() {
                                      model.selectedSubscription = value;
                                    });
                                  },
                                  items: model
                                      .getSubscriptionList(val, widget.data)
                                      .map(
                                    (CurrencyData question) {
                                      return DropdownMenuItem<CurrencyData>(
                                        value: question,
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
                                                'images/subscription.svg',
                                                height: 25.0,
                                                width: 25.0,
                                                color: Colors.white,
                                                allowDrawingOutsideViewBox:
                                                    true,
                                              ),
                                            ),
                                            SizedBox(
                                              width: 10,
                                            ),
                                            Text(
                                              model.getSubscriptionText(
                                                  question, val),
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
                              model.currencySubscriptionValidate
                                  ? Container():Container(
                                      width: double.infinity,
                                      child: Text(
                                        AppLocalizations.of(context)
                                            .translate('list_error'),
                                        style: TextStyle(
                                            color: Colors.red[700],
                                            fontSize: 13),
                                        textAlign: TextAlign.start,
                                      ),
                                    )
                                  ,
                              SizedBox(
                                height: 30,
                              ),
                              model.state == ViewState.Busy
                                  ? CircularProgressIndicator(
                                backgroundColor: Colors.lightBlue,
                              )
                                  :ButtonTheme(
                                minWidth: MediaQuery.of(context).size.width,
                                child: RaisedButton(
                                  elevation: 0.0,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  onPressed: () async{
                                    if(model.thirdSignUpValidation(val)){
                                      LoginResponse loginResponse =
                                          await model.register(
                                          locator<AppLanguage>()
                                              .appLocal
                                              .languageCode,
                                          widget.cPass,
                                          widget.mcode,
                                          widget.code,
                                          model.selectedSubscription.id.toString(),
                                          widget.firstName,
                                          widget.lastName,
                                          widget.email,
                                          widget.password,
                                          widget.mobile,
                                          widget.nationalId,
                                          widget.pin,
                                          widget.ques,
                                          widget.answer);
                                      if (loginResponse == null) {
                                        final snackBar = SnackBar(
                                          content: Text(
                                              AppLocalizations.of(context)
                                                  .translate(
                                                  'check_network')),
                                          backgroundColor: Colors.red,
                                        );
                                        _scaffoldKey.currentState
                                            .showSnackBar(snackBar);
                                      } else if (loginResponse.status ) {
                                        // saveLoginData(json.encode(
                                        //     loginResponse.data.user));
                                        // Globals.userData =
                                        //     loginResponse.data.user;
                                        showToast(
                                            AppLocalizations.of(context)
                                                .translate(
                                                'auth_response_success'),
                                            Colors.green);
                                        _callFawryAPI();
                                        // Navigator.pushAndRemoveUntil(
                                        //     context,
                                        //     MaterialPageRoute(
                                        //         builder: (context) =>
                                        //             HomePage()),
                                        //         (Route<dynamic> route) =>
                                        //     false);
                                      } else if (!loginResponse.status) {
                                        if (loginResponse.errors !=
                                            null &&
                                            loginResponse.errors.length >
                                                0) {
                                          showToast(
                                              model.getRegisterErrors(
                                                  loginResponse.errors),
                                              Colors.red);
                                        }
                                        else
                                          showToast(
                                              AppLocalizations.of(context)
                                                  .translate(
                                                  'something_went_error'),
                                              Colors.red);
                                      } else {
                                        final snackBar = SnackBar(
                                          content: Text(
                                              AppLocalizations.of(context)
                                                  .translate(
                                                  'check_network')),
                                          backgroundColor: Colors.red,
                                        );
                                        _scaffoldKey.currentState
                                            .showSnackBar(snackBar);
                                      }

                                      // Navigator.push(
                                      //     context,
                                      //     new MaterialPageRoute(
                                      //         builder: (context) =>
                                      //         new FourthStepSignUpScreen(
                                      //             firstName: widget.firstName,
                                      //             lastName: widget.lastName,
                                      //             email: widget.email,
                                      //             password: widget.password,
                                      //             cPass: widget.cPass,
                                      //             mobile: widget.mobile,
                                      //             mcode: widget.mcode,
                                      //             code: widget.code,
                                      //             pin: widget.pin,
                                      //             ques: widget.ques,
                                      //             answer: widget.answer,
                                      //             methodSubs: model
                                      //                 .selectedSubscription.id
                                      //                 .toString(),
                                      //             data: widget.data,nationalId: widget.nationalId,)));
                                    }
//
                                  },
                                  padding: EdgeInsets.all(20),
                                  color: Colors.lightBlueAccent,
                                  child: Text('Next',
                                      style: TextStyle(color: Colors.white)),
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
                                                text: 'terms and conditions',
                                                style: new TextStyle(
                                                  decoration:
                                                      TextDecoration.underline,
                                                )),
                                            new TextSpan(text: ' and '),
                                            new TextSpan(
                                              text: 'privacy policy',
                                              style: new TextStyle(
                                                decoration:
                                                    TextDecoration.underline,
                                              ),
                                              recognizer:
                                                  new TapGestureRecognizer()
                                                    ..onTap = () =>
                                                        print('Tap Here onTap'),
                                            ),
                                          ],
                                        ),
                                      )))
                            ],
                          )),
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
