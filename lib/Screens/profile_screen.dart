import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:himaka/Models/login_response.dart';
import 'package:himaka/Screens/change_password_screen.dart';
import 'package:himaka/Screens/change_question_screen.dart';
import 'package:himaka/Screens/start_screen.dart';
import 'package:himaka/ViewModels/base_model.dart';
import 'package:himaka/ViewModels/profile_view_model.dart';
import 'package:himaka/services/base_view.dart';
import 'package:himaka/services/locator.dart';
import 'package:himaka/utils/AppLanguage.dart';
import 'package:himaka/utils/app_localizations.dart';
import 'package:himaka/utils/caching.dart';
import 'package:himaka/utils/globals.dart';
import 'package:himaka/utils/pin_pass_validate_dialog.dart';
import 'package:himaka/utils/show_toast.dart';

import 'SignUp/fourth_step_signup_screen.dart';

class ProfileScreen extends StatefulWidget {
  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  bool textSetInitialVal = false;
  TextEditingController _nameController,
      _emailController,
      _phoneController,
      _nationalIdController,
      _secNameController;
  bool _enabled = false;

  TextEditingController _oldPassController = new TextEditingController();
  TextEditingController _newPasswordController = new TextEditingController();
  final _scaffoldKey = new GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        key: _scaffoldKey,
        appBar: AppBar(
          iconTheme: IconThemeData(
            color: Colors.grey[900], //change your color here
          ),
          centerTitle: true,
          title: Text(
            AppLocalizations.of(context).translate('personal_details'),
            style: TextStyle(color: Colors.black),
          ),
          backgroundColor: Colors.transparent,
          elevation: 0.0,
        ),
        body: BaseView<ProfileViewModel>(
            onModelReady: (model) {
              refreshScreen(model);
            },
            builder: (context, model, child) => LayoutBuilder(builder:
                    (BuildContext context, BoxConstraints viewportConstraints) {
                  if (!textSetInitialVal && model.profileResponse != null) {
                    textSetInitialVal = true;
                    textFormConfiguration(context, model);
                    print(model.profileResponse.data.user.email);
                  }

                  return model.profileResponse != null
                      ? SingleChildScrollView(
                          child: Column(
                            children: [
                              SvgPicture.asset(
                                'images/icon_profile.svg',
                                height: 130.0,
                                width: 130.0,
                                allowDrawingOutsideViewBox: true,
                              ),
                              Text(
                                model.profileResponse.data.user.first_name +
                                    " " +
                                    model.profileResponse.data.user.last_name,
                                style: TextStyle(fontSize: 20),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Container(
                                  decoration: BoxDecoration(
                                      color: Colors.white,
                                      border: Border.all(
                                        color: Colors.lightBlueAccent,
                                      )),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.all(5.0),
                                        child: InkWell(
                                          onTap: () {
                                            setState(() {
                                              _enabled = !_enabled;
                                            });
                                          },
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.end,
                                            children: [
                                              Text(
                                                AppLocalizations.of(context)
                                                    .translate('edit'),
                                                style: TextStyle(
                                                    color: Colors.lightBlue),
                                              ),
                                              SizedBox(
                                                width: 5,
                                              ),
                                              SvgPicture.asset(
                                                'images/icon_edit.svg',
                                                height: 10.0,
                                                width: 10.0,
                                                allowDrawingOutsideViewBox:
                                                    true,
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(13.0),
                                        child: Container(
                                          child: Column(
                                            children: [
                                              TextField(
                                                enabled: _enabled,
                                                controller: _nameController,
                                                keyboardType:
                                                    TextInputType.text,
                                                decoration: new InputDecoration(
                                                  labelText: AppLocalizations
                                                          .of(context)
                                                      .translate('first_name'),
                                                  labelStyle: TextStyle(
                                                      color: Colors.black),
                                                  prefixIcon: Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            15.0),
                                                    child: SvgPicture.asset(
                                                      'images/icon_person_profile.svg',
                                                      height: 5.0,
                                                      width: 5.0,
                                                      color: Colors.black,
                                                      allowDrawingOutsideViewBox:
                                                          true,
                                                    ),
                                                  ),
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
                                              TextField(
                                                enabled: _enabled,
                                                controller: _secNameController,
                                                keyboardType:
                                                    TextInputType.text,
                                                decoration: new InputDecoration(
                                                  labelText: AppLocalizations
                                                          .of(context)
                                                      .translate('last_name'),
                                                  labelStyle: TextStyle(
                                                      color: Colors.black),
                                                  prefixIcon: Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            15.0),
                                                    child: SvgPicture.asset(
                                                      'images/icon_person_profile.svg',
                                                      height: 5.0,
                                                      width: 5.0,
                                                      color: Colors.black,
                                                      allowDrawingOutsideViewBox:
                                                          true,
                                                    ),
                                                  ),
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
                                              TextField(
                                                enabled: _enabled,
                                                controller: _phoneController,
                                                keyboardType:
                                                    TextInputType.phone,
//                                                textDirection:
//                                                    TextDirection.rtl,
                                                decoration: new InputDecoration(
                                                  prefixIcon: Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            15.0),
                                                    child: SvgPicture.asset(
                                                      'images/icon_phone.svg',
                                                      height: 6.0,
                                                      width: 6.0,
                                                      color: Colors.black,
                                                      allowDrawingOutsideViewBox:
                                                          true,
                                                    ),
                                                  ),
                                                  labelText: AppLocalizations
                                                          .of(context)
                                                      .translate('phone_num'),
                                                  labelStyle: TextStyle(
                                                      color: Colors.black),
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
                                              TextField(
                                                controller: _emailController,
                                                keyboardType:
                                                    TextInputType.emailAddress,
                                                enabled: false,
                                                decoration: new InputDecoration(
                                                  labelText:
                                                      AppLocalizations.of(
                                                              context)
                                                          .translate('email'),
                                                  labelStyle: TextStyle(
                                                      color: Colors.black),
                                                  prefixIcon: Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            15.0),
                                                    child: SvgPicture.asset(
                                                      'images/icon_mail.svg',
                                                      height: 5.0,
                                                      width: 5.0,
                                                      color: Colors.black,
                                                      allowDrawingOutsideViewBox:
                                                          true,
                                                    ),
                                                  ),
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
                                              TextField(
                                                controller:
                                                    _nationalIdController,
                                                keyboardType:
                                                    TextInputType.number,
                                                enabled: false,
                                                decoration: new InputDecoration(
                                                  labelText: AppLocalizations
                                                          .of(context)
                                                      .translate('national_id'),
                                                  labelStyle: TextStyle(
                                                      color: Colors.black),
                                                  prefixIcon: Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            15.0),
                                                    child: SvgPicture.asset(
                                                      'images/icon_nationalid.svg',
                                                      height: 5.0,
                                                      width: 5.0,
                                                      color: Colors.black,
                                                      allowDrawingOutsideViewBox:
                                                          true,
                                                    ),
                                                  ),
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
                                              Container(
                                                  width: MediaQuery.of(context)
                                                      .size
                                                      .width,
                                                  child: RaisedButton(
                                                    color:
                                                        Colors.lightBlueAccent,
                                                    child: Text(
                                                      AppLocalizations.of(
                                                              context)
                                                          .translate(
                                                              'change_withdraw'),
                                                      style: TextStyle(
                                                          color: Colors.white),
                                                    ),
                                                    onPressed: () {
                                                      Navigator.push(
                                                          context,
                                                          new MaterialPageRoute(
                                                              builder: (context) =>
                                                                  new FourthStepSignUpScreen()));
                                                    },
                                                  )),
                                              Container(
                                                  width: MediaQuery.of(context)
                                                      .size
                                                      .width,
                                                  child: RaisedButton(
                                                    color:
                                                        Colors.lightBlueAccent,
                                                    child: Text(
                                                      AppLocalizations.of(
                                                              context)
                                                          .translate(
                                                              'change_question'),
                                                      style: TextStyle(
                                                          color: Colors.white),
                                                    ),
                                                    onPressed: () {
                                                      pinPassValidateDialog(
                                                          context);
//                                                      Navigator.push(
//                                                          context,
//                                                          new MaterialPageRoute(
//                                                              builder: (context) =>
//                                                                  new ChangeQuestionScreen()));
                                                    },
                                                  )),
                                              Container(
                                                  width: MediaQuery.of(context)
                                                      .size
                                                      .width,
                                                  child: RaisedButton(
                                                    color:
                                                        Colors.lightBlueAccent,
                                                    child: Text(
                                                      AppLocalizations.of(
                                                              context)
                                                          .translate(
                                                              'change_password'),
                                                      style: TextStyle(
                                                          color: Colors.white),
                                                    ),
                                                    onPressed: () {
                                                      Navigator.push(
                                                          context,
                                                          new MaterialPageRoute(
                                                              builder: (context) =>
                                                                  new ChangePasswordScreen()));
                                                    },
                                                  )),
                                              Container(
                                                  width: MediaQuery.of(context)
                                                      .size
                                                      .width,
                                                  child: (model.state ==
                                                              ViewState.Busy &&
                                                          model.serviceId == 3)
                                                      ? Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                  .all(8.0),
                                                          child: Center(
                                                            child:
                                                                CircularProgressIndicator(
                                                              backgroundColor:
                                                                  Colors
                                                                      .lightBlue,
                                                            ),
                                                          ),
                                                        )
                                                      : RaisedButton(
                                                          color: Colors
                                                              .lightBlueAccent,
                                                          child: Text(
                                                              AppLocalizations.of(
                                                                      context)
                                                                  .translate(
                                                                      'log_out'),
                                                              style: TextStyle(
                                                                  color: Colors
                                                                      .white)),
                                                          onPressed: () async {
                                                            LoginResponse
                                                                response =
                                                                await logOut(
                                                                    model);
                                                            if (response ==
                                                                null) {
                                                              final snackBar =
                                                                  SnackBar(
                                                                content: Text(AppLocalizations.of(
                                                                        context)
                                                                    .translate(
                                                                        'check_network')),
                                                                backgroundColor:
                                                                    Colors.red,
                                                              );
                                                              _scaffoldKey
                                                                  .currentState
                                                                  .showSnackBar(
                                                                      snackBar);
                                                            } else if (response
                                                                .status) {
                                                              removeUserData();
                                                              Globals.userData =
                                                                  null;

                                                              Navigator.pushAndRemoveUntil(
                                                                  context,
                                                                  MaterialPageRoute(
                                                                      builder:
                                                                          (context) =>
                                                                              StartScreen()),
                                                                  (Route<dynamic>
                                                                          route) =>
                                                                      false);
                                                            } else {
                                                              showToast(
                                                                  response
                                                                      .errors
                                                                      .toString(),
                                                                  Colors.red);
                                                            }
                                                          },
                                                        ))
                                            ],
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                    vertical: 10.0, horizontal: 30),
                                child: (model.state == ViewState.Busy &&
                                        model.serviceId == 2)
                                    ? Center(
                                        child: CircularProgressIndicator(
                                          backgroundColor: Colors.lightBlue,
                                        ),
                                      )
                                    : Container(
                                        width:
                                            MediaQuery.of(context).size.width,
                                        child: RaisedButton(
                                          color: Colors.lightBlueAccent,
                                          child: Text(
                                            AppLocalizations.of(context)
                                                .translate('done'),
                                            style:
                                                TextStyle(color: Colors.white),
                                          ),
                                          onPressed: () async {
                                            await model.setProfileDetails(
                                              "",
                                              _nameController.text
                                                  .trim()
                                                  .toString(),
                                              _secNameController.text
                                                  .trim()
                                                  .toString(),
                                              _phoneController.text
                                                  .trim()
                                                  .toString(),
                                              _oldPassController.text
                                                  .trim()
                                                  .toString(),
                                              _newPasswordController.text
                                                  .trim()
                                                  .toString(),
                                            );
                                          },
                                        )),
                              ),
                            ],
                          ),
                        )
                      : (model.state == ViewState.Busy)
                          ? Center(
                              child: CircularProgressIndicator(
                                backgroundColor: Colors.lightBlue,
                              ),
                            )
                          : Container(
                              child: Center(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: <Widget>[
                                    Text(
                                      AppLocalizations.of(context)
                                          .translate('network_failed'),
                                    ),
                                    RaisedButton(
                                      onPressed: () {
                                        refreshScreen(model);
                                      },
                                      color: Color.fromRGBO(235, 85, 85, 100),
                                      child: Icon(Icons.refresh),
                                      shape: new RoundedRectangleBorder(
                                          borderRadius:
                                              new BorderRadius.circular(30),
                                          side: BorderSide(
                                              color: Color.fromRGBO(
                                                  235, 85, 85, 100))),
                                    )
                                  ],
                                ),
                              ),
                            );
                })));
  }

  void textFormConfiguration(BuildContext context, ProfileViewModel model) {
//    model.setWorkTimeInitialData(model.loginResponse.homeResult.centerTimeWork);

    print(model.profileResponse.data.user.email);
    _nameController =
        TextEditingController(text: model.profileResponse.data.user.first_name);

    _nameController.addListener(() {
      final name = _nameController.text;
      _nameController.value = _nameController.value.copyWith(
        text: name,
      );
    });

    _secNameController =
        TextEditingController(text: model.profileResponse.data.user.last_name);

    _secNameController.addListener(() {
      final name = _secNameController.text;
      _secNameController.value = _secNameController.value.copyWith(
        text: name,
      );
    });
    _phoneController = TextEditingController(
        text: model.profileResponse.data.user.mobile.replaceAll("+", "00"));
    _phoneController.addListener(() {
      final mobile = _phoneController.text;
      _phoneController.value = _phoneController.value.copyWith(
        text: mobile,
      );
    });

    _emailController =
        TextEditingController(text: model.profileResponse.data.user.email);
    _emailController.addListener(() {
      final mobile = _emailController.text;
      _emailController.value = _emailController.value.copyWith(
        text: mobile,
      );
    });

    _nationalIdController = TextEditingController(
        text: model.profileResponse.data.user.national_id);
    _nationalIdController.addListener(() {
      final mobile = _nationalIdController.text;
      _nationalIdController.value = _nationalIdController.value.copyWith(
        text: mobile,
      );
    });

//    _descController = model
//            .loginResponse.homeResult.customerInfo.centerDescription.isNotEmpty
//        ? TextEditingController(
//            text: model.loginResponse.homeResult.customerInfo.centerDescription)
//        : TextEditingController();
//    _descController.addListener(() {
//      final mobile = _descController.text;
//      _descController.value = _descController.value.copyWith(
//        text: mobile,
//      );
//    });
  }

  void refreshScreen(ProfileViewModel model) {
    model.getProfileDetails("");
  }

  Future<LoginResponse> logOut(ProfileViewModel model) {
    return model.logOut(locator<AppLanguage>().appLocal.languageCode);
  }
}
