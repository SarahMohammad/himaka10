import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:himaka/Models/login_response.dart';
import 'package:himaka/Models/pre_register_response.dart';
import 'package:himaka/ViewModels/base_model.dart';
import 'package:himaka/ViewModels/personal_wallet_view_model.dart';
import 'package:himaka/services/base_view.dart';
import 'package:himaka/services/locator.dart';
import 'package:himaka/utils/AppLanguage.dart';
import 'package:himaka/utils/app_bar.dart';
import 'package:himaka/utils/app_localizations.dart';
import 'package:himaka/utils/caching.dart';
import 'package:himaka/utils/globals.dart';
import 'package:himaka/utils/show_toast.dart';

class MethodOfCashOutScreen extends StatefulWidget {
  @override
  _MethodOfCashOutScreenState createState() => _MethodOfCashOutScreenState();
}

class _MethodOfCashOutScreenState extends State<MethodOfCashOutScreen> {
  bool _change = false;
  TextEditingController _methodController;
  TextEditingController _amountController = new TextEditingController();
  final _scaffoldKey = new GlobalKey<ScaffoldState>();

  TextEditingController _descController;

  bool initializeMethods = false;
  WithdrawMethod val;

  @override
  Widget build(BuildContext context) {
    return BaseView<PersonalWalletViewModel>(
        onModelReady: (model) {
          refreshScreen(model);
        },
        builder: (context, model, child) => LayoutBuilder(builder:
                (BuildContext context, BoxConstraints viewportConstraints) {
              if (!initializeMethods &&
                  model.personalWalletCashOutResponse != null) {
                initializeMethods = true;
                val = model.personalWalletCashOutResponse.data
                    .withdraws_methods[model.getUserWithdrawMethodIndex(model
                            .personalWalletCashOutResponse
                            .data
                            .user_method
                            .id !=
                        -1
                    ? model.personalWalletCashOutResponse.data.user_method.id
                    : 0)];
                _methodController = new TextEditingController(
                    text: model.personalWalletCashOutResponse.data.user_method
                        .field_name);
                _descController = new TextEditingController();
              }
              return Scaffold(
                key: _scaffoldKey,
                appBar: setAppBar(
                    AppLocalizations.of(context).translate('personal_wallet'),
                    context),
                body: model.personalWalletCashOutResponse != null
                    ? ListView(children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              color: Colors.lightBlueAccent,
                              child: Padding(
                                padding: const EdgeInsets.all(15.0),
                                child: Row(
                                  children: [
                                    SvgPicture.asset(
                                      'images/earning_wallet_cash_out.svg',
                                      height: 25.0,
                                      width: 25.0,
                                      allowDrawingOutsideViewBox: true,
                                      color: Colors.white,
                                    ),
                                    SizedBox(
                                      width: 16,
                                    ),
                                    Text(
                                        AppLocalizations.of(context)
                                            .translate('method_cash_out'),
                                        style: TextStyle(
                                            color: Colors.white, fontSize: 15)),
                                  ],
                                ),
                              ),
                            ),
                            Card(
                                child: Padding(
                              padding: const EdgeInsets.all(20.0),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(AppLocalizations.of(context)
                                      .translate('method_cash_out')),
                                  Text(
                                      model.personalWalletCashOutResponse.data
                                          .user_method.name,
                                      style: TextStyle(
                                          color: Colors.lightBlueAccent))
                                ],
                              ),
                            )),
                            SizedBox(
                              height: 8,
                            ),
                            _change
                                ? Column(
                                    children: [
                                      Container(
                                        padding: EdgeInsets.only(top: 20.0),
                                        width:
                                            MediaQuery.of(context).size.width,
                                        child: DropdownButton<WithdrawMethod>(
                                          dropdownColor: Colors.white,
                                          icon: Icon(
                                            Icons.arrow_drop_down,
                                            color: Colors.white,
                                          ),
                                          isExpanded: true,
                                          hint: Text(
                                            "Select the method",
                                            style:
                                                TextStyle(color: Colors.white),
                                          ),
                                          value: val,
                                          onChanged: (WithdrawMethod value) {
                                            setState(() {
                                              // model.methodIdValidate = true;
                                              val = value;
                                            });
                                          },
                                          items: model
                                              .personalWalletCashOutResponse
                                              .data
                                              .withdraws_methods
                                              .map(
                                            (WithdrawMethod method) {
                                              return DropdownMenuItem<
                                                  WithdrawMethod>(
                                                value: method,
                                                child: Row(
                                                  children: [
                                                    SizedBox(
                                                      width: 10,
                                                    ),
                                                    Padding(
                                                      padding: const EdgeInsets
                                                              .symmetric(
                                                          vertical: 10.0),
                                                      child: SvgPicture.asset(
                                                        'images/icon_money.svg',
                                                        height: 25.0,
                                                        width: 25.0,
                                                        color: Colors.blue,
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
                                                          color: Colors.blue),
                                                    ),
                                                  ],
                                                ),
                                              );
                                            },
                                          ).toList(),
                                        ),
                                      ),
                                      Column(
                                        children: [
                                          new Container(
                                            child: new TextField(
                                              cursorColor: Colors.blue,
                                              controller: _methodController,
                                              decoration: new InputDecoration(
                                                contentPadding:
                                                    EdgeInsets.symmetric(
                                                        horizontal: 16),
                                                labelStyle: TextStyle(
                                                    color: Colors.black87),
                                                labelText: val.field_name,
                                                hintStyle: TextStyle(
                                                    fontSize: 20.0,
                                                    color: Colors.blue),
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
                                                      color: Colors.black87),
                                                ),
                                                focusedBorder:
                                                    UnderlineInputBorder(
                                                  borderSide: BorderSide(
                                                      color: Colors.black87),
                                                ),
                                              ),
                                            ),
                                          ),
                                          new Container(
                                            child: new TextField(
                                              cursorColor: Colors.blue,
                                              controller: _descController,
                                              decoration: new InputDecoration(
                                                labelStyle: TextStyle(
                                                    color: Colors.black87),
                                                labelText:
                                                    'Description the method',
                                                hintStyle: TextStyle(
                                                    fontSize: 20.0,
                                                    color: Colors.blue),
                                                prefixIcon: Padding(
                                                  padding: const EdgeInsets.all(
                                                      15.0),
                                                  child: SvgPicture.asset(
                                                    'images/icon_desc.svg',
                                                    height: 5.0,
                                                    width: 5.0,
                                                    color: Colors.blue,
                                                    allowDrawingOutsideViewBox:
                                                        true,
                                                  ),
                                                ),
                                                // errorText: model.descValidate
                                                //     ? null
                                                //     : AppLocalizations.of(context)
                                                //     .translate('empty_error'),
                                                enabledBorder:
                                                    UnderlineInputBorder(
                                                  borderSide: BorderSide(
                                                      color: Colors.black87),
                                                ),
                                                focusedBorder:
                                                    UnderlineInputBorder(
                                                  borderSide: BorderSide(
                                                      color: Colors.black87),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  )
                                : Container(),
                            SizedBox(
                              height: 15,
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 25.0),
                              child: Container(
                                width: MediaQuery.of(context).size.width,
                                child: RaisedButton(
                                  child: Padding(
                                    padding: const EdgeInsets.all(15.0),
                                    child: Text(
                                      AppLocalizations.of(context)
                                          .translate('change'),
                                      style: TextStyle(color: Colors.white),
                                    ),
                                  ),
                                  onPressed: () {
                                    setState(() {
                                      _change = !_change;
                                    });
                                  },
                                  color: Colors.lightBlueAccent,
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 12,
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 25.0),
                              child: model.state == ViewState.Busy
                                  ? Container(
                                      child: Center(
                                        child: CircularProgressIndicator(
                                          backgroundColor: Colors.lightBlue,
                                        ),
                                      ),
                                    )
                                  : Container(
                                      width: MediaQuery.of(context).size.width,
                                      child: RaisedButton(
                                        child: Padding(
                                          padding: const EdgeInsets.all(15.0),
                                          child: Text(
                                            AppLocalizations.of(context)
                                                .translate('done'),
                                            style:
                                                TextStyle(color: Colors.white),
                                          ),
                                        ),
                                        onPressed: () async {
                                          if (model
                                              .changeMethodCashOutValidation(
                                                  val,
                                                  _methodController.text
                                                      .trim())) {
                                            LoginResponse response =
                                                await changeMethod(model);
                                            if (response == null) {
                                              final snackBar = SnackBar(
                                                content: Text(
                                                    AppLocalizations.of(context)
                                                        .translate(
                                                            'check_network')),
                                                backgroundColor: Colors.red,
                                              );
                                              _scaffoldKey.currentState
                                                  .showSnackBar(snackBar);
                                            } else if (response.status) {
                                              if (response.data.user != null) {
                                                saveLoginData(json.encode(
                                                    response.data.user));
                                                Globals.userData =
                                                    response.data.user;
                                              }
                                              showToast(
                                                  AppLocalizations.of(context)
                                                      .translate(
                                                          'done_successfully'),
                                                  Colors.green);
                                              Navigator.pop(context);
                                            } else {
                                              showToast(
                                                  response.errors.toString(),
                                                  Colors.red);
                                              Navigator.pop(context);
                                            }
                                          }
                                        },
                                        color: Colors.lightBlueAccent,
                                      ),
                                    ),
                            ),
                          ],
                        ),
                      ])
                    : model.state == ViewState.Idle
                        ? Scaffold(
                            backgroundColor: Colors.transparent,
                            body: Container(
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
                            ),
                          )
                        : Center(
                            child: CircularProgressIndicator(
                              backgroundColor: Colors.lightBlue,
                            ),
                          ),
              );
            }));
  }

  refreshScreen(PersonalWalletViewModel model) {
    model.getCashOutMethods(locator<AppLanguage>().appLocal.languageCode);
  }

  Future<LoginResponse> changeMethod(PersonalWalletViewModel model) {
    return model.changeCashOutMethod(
        locator<AppLanguage>().appLocal.languageCode,
        val.id,
        _methodController.text.trim(),
        _descController.text.trim());
  }
}
