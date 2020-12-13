import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:himaka/Models/login_response.dart';
import 'package:himaka/ViewModels/base_model.dart';
import 'package:himaka/ViewModels/profile_view_model.dart';
import 'package:himaka/services/base_view.dart';
import 'package:himaka/services/locator.dart';
import 'package:himaka/utils/AppLanguage.dart';
import 'package:himaka/utils/app_localizations.dart';
import 'package:himaka/utils/show_toast.dart';

class ChangePasswordScreen extends StatefulWidget {
  @override
  _ChangePasswordScreenState createState() => _ChangePasswordScreenState();
}

class _ChangePasswordScreenState extends State<ChangePasswordScreen> {
  bool textSetInitialVal = false;

  TextEditingController _oldPassController = new TextEditingController();
  TextEditingController _newPasswordController = new TextEditingController();
  TextEditingController _repeatPassController = new TextEditingController();
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
            AppLocalizations.of(context).translate('change_password'),
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
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.end,
                                          children: [
                                            Text(
                                              'Edit',
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
                                              allowDrawingOutsideViewBox: true,
                                            ),
                                          ],
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(13.0),
                                        child: Container(
                                          child: Column(
                                            children: [
                                              TextField(
                                                controller: _oldPassController,
                                                keyboardType:
                                                    TextInputType.text,
                                                obscureText: true,
                                                decoration: new InputDecoration(
                                                  labelText: AppLocalizations
                                                          .of(context)
                                                      .translate('old_pass'),
                                                  labelStyle: TextStyle(
                                                      color: Colors.black),
                                                  prefixIcon: Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            15.0),
                                                    child: SvgPicture.asset(
                                                      'images/icon_padlock.svg',
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
                                                    _newPasswordController,
                                                keyboardType:
                                                    TextInputType.text,
                                                obscureText: true,
                                                decoration: new InputDecoration(
                                                  labelText: AppLocalizations
                                                          .of(context)
                                                      .translate('new_pass'),
                                                  labelStyle: TextStyle(
                                                      color: Colors.black),
                                                  prefixIcon: Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            15.0),
                                                    child: SvgPicture.asset(
                                                      'images/icon_padlock.svg',
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
                                                    _repeatPassController,
                                                keyboardType:
                                                    TextInputType.text,
                                                obscureText: true,
                                                decoration: new InputDecoration(
                                                  labelText: AppLocalizations
                                                          .of(context)
                                                      .translate(
                                                          're_enter_password'),
                                                  labelStyle: TextStyle(
                                                      color: Colors.black),
                                                  prefixIcon: Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            15.0),
                                                    child: SvgPicture.asset(
                                                      'images/icon_padlock.svg',
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
                                            if (_newPasswordController.text ==
                                                _repeatPassController.text) {
                                              await model.setProfileDetails(
                                                "",
                                                "",
                                                "",
                                                "",
                                                _oldPassController.text
                                                    .trim()
                                                    .toString(),
                                                _newPasswordController.text
                                                    .trim()
                                                    .toString(),
                                              );
                                            } else {
                                              showToast(
                                                  "Mismatch Password input",
                                                  Colors.red);
                                            }
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

  void refreshScreen(ProfileViewModel model) {
    model.getProfileDetails("");
  }

  Future<LoginResponse> logOut(ProfileViewModel model) {
    return model.logOut(locator<AppLanguage>().appLocal.languageCode);
  }
}
