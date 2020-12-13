import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:himaka/Models/transition_response.dart';
import 'package:himaka/ViewModels/base_model.dart';
import 'package:himaka/ViewModels/wallet_view_model.dart';
import 'package:himaka/services/base_view.dart';
import 'package:himaka/services/locator.dart';
import 'package:himaka/utils/AppLanguage.dart';
import 'package:himaka/utils/show_toast.dart';

import '../../../utils/app_bar.dart';
import '../../../utils/app_localizations.dart';

class EarningCashOutScreen extends StatefulWidget {
  @override
  _EarningCashOutScreenState createState() => _EarningCashOutScreenState();
}

class _EarningCashOutScreenState extends State<EarningCashOutScreen> {
  TextEditingController _amountController = new TextEditingController();
  final _scaffoldKey = new GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return BaseView<WalletViewModel>(
        onModelReady: (model) {
          refreshScreen(model);
        },
        builder: (context, model, child) => LayoutBuilder(builder:
                (BuildContext context, BoxConstraints viewportConstraints) {
              return LayoutBuilder(builder:
                  (BuildContext context, BoxConstraints viewportConstraints) {
                return Scaffold(
                  key: _scaffoldKey,
                  appBar: setAppBar(
                      AppLocalizations.of(context).translate('earning_wallet'),
                      context),
                  body: model.walletResponse != null
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
                                        'images/cash_out.svg',
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
                                              .translate('cash_out'),
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 15)),
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
                                        .translate('wallet_balance')),
                                    Text(model.walletResponse.data.balance,
                                        style: TextStyle(
                                            color: Colors.lightBlueAccent))
                                  ],
                                ),
                              )),
                              SizedBox(
                                height: 15,
                              ),
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 20.0, vertical: 8),
                                child: Text(AppLocalizations.of(context)
                                    .translate('transition_to_personal')),
                              ),
                              TextFormField(
                                keyboardType: TextInputType.number,
                                autofocus: false,
                                controller: _amountController,
                                decoration: InputDecoration(
                                  fillColor: Colors.white,
                                  filled: true,
                                  errorText: model.amountValidate
                                      ? null
                                      : AppLocalizations.of(context)
                                          .translate('empty_error'),
                                  prefixIcon: Padding(
                                    padding: const EdgeInsets.all(15.0),
                                    child: SvgPicture.asset(
                                      'images/icon_money.svg',
                                      height: 25.0,
                                      width: 25.0,
                                      color: Colors.black,
                                      allowDrawingOutsideViewBox: true,
                                    ),
                                  ),
                                  hintText: AppLocalizations.of(context)
                                      .translate('enter_amount_to_load'),
                                  hintStyle: TextStyle(
                                      color: Colors.black,
                                      textBaseline: TextBaseline.alphabetic),
                                  contentPadding: EdgeInsets.fromLTRB(
                                      20.0, 20.0, 20.0, 20.0),
                                ),
                              ),
                              SizedBox(
                                height: 15,
                              ),
                              model.state == ViewState.Busy
                                  ? Container(
                                      child: Center(
                                        child: CircularProgressIndicator(
                                          backgroundColor: Colors.lightBlue,
                                        ),
                                      ),
                                    )
                                  : Container(
                                      width: double.infinity,
                                      child: Padding(
                                        padding: const EdgeInsets.symmetric(
                                            vertical: 16.0, horizontal: 32),
                                        child: RaisedButton(
                                          child: Text(
                                            AppLocalizations.of(context)
                                                .translate(
                                                    'complete_your_transition'),
                                            style:
                                                TextStyle(color: Colors.white),
                                          ),
                                          onPressed: () async {
                                            if (model.walletResponse.data
                                                    .balance !=
                                                "0") {
                                              if (model.transitionValidation(
                                                  _amountController.text
                                                      .trim())) {
                                                TransitionResponse response =
                                                    await transitionToPersonal(
                                                        model);
                                                if (response == null) {
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
                                                } else if (response.status) {
                                                  showToast(response.msg,
                                                      Colors.green);
                                                  Navigator.pop(context);
                                                } else {
                                                  showToast(
                                                      response.errors
                                                          .toString(),
                                                      Colors.red);
                                                }
                                              }
                                            } else {
                                              showToast(
                                                  AppLocalizations.of(context)
                                                      .translate(
                                                          'balance_not_enough'),
                                                  Colors.red);
                                            }
                                          },
                                          color: Colors.lightBlueAccent,
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(5.0),
                                          ),
                                        ),
                                      ),
                                    ),
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 15.0),
                                child: Row(
                                  children: [
                                    SvgPicture.asset(
                                      'images/personal_recent.svg',
                                      height: 25.0,
                                      width: 25.0,
                                      allowDrawingOutsideViewBox: true,
                                    ),
                                    SizedBox(
                                      width: 14,
                                    ),
                                    Text(AppLocalizations.of(context)
                                        .translate('recent_transactions')),
                                  ],
                                ),
                              ),
                              Container(
                                child: (model.walletResponse.data
                                                .walletHistory !=
                                            null &&
                                        model.walletResponse.data.walletHistory
                                                .length >
                                            0)
                                    ? ListView.separated(
                                        shrinkWrap: true,
                                        physics: ClampingScrollPhysics(),
                                        separatorBuilder: (context, index) =>
                                            Divider(
                                          color: Colors.black,
                                        ),
                                        itemCount: model.walletResponse.data
                                            .walletHistory.length,
                                        itemBuilder: (context, index) =>
                                            Padding(
                                          padding: EdgeInsets.all(1.0),
                                          child: InkWell(
                                            onTap: () {},
                                            child: ListTile(
//                                            leading: Padding(
//                                              padding: const EdgeInsets.only(
//                                                  top: 8.0),
//                                              child: Padding(
//                                                padding: const EdgeInsets.only(
//                                                    top: 8.0),
//                                                child: SvgPicture.asset(
//                                                  'images/personal_recent_wrong.svg',
//                                                  height: 20.0,
//                                                  width: 20.0,
//                                                  allowDrawingOutsideViewBox:
//                                                      true,
//                                                ),
//                                              ),
//                                            ),
                                              title: Row(
                                                children: [
                                                  SvgPicture.asset(
                                                    'images/personal_wallet_history.svg',
                                                    height: 20.0,
                                                    width: 20.0,
                                                    allowDrawingOutsideViewBox:
                                                    true,
                                                  ),
                                                  SizedBox(
                                                    width: 8,
                                                  ),
                                                  Text(
                                                    model
                                                        .walletResponse
                                                        .data
                                                        .walletHistory[index]
                                                        .walletTypeFrom,
                                                  ),
                                                ],
                                              ),
                                              subtitle: Row(
                                                children: [
                                                  SvgPicture.asset(
                                                    'images/arrow_up_right.svg',
                                                    height: 18.0,
                                                    width: 18.0,
                                                    allowDrawingOutsideViewBox:
                                                    true,
                                                  ),
                                                  SizedBox(
                                                    width: 8,
                                                  ),
                                                  Text(
                                                    model
                                                        .walletResponse
                                                        .data
                                                        .walletHistory[index]
                                                        .createdAt,
                                                  ),
                                                ],
                                              ),
                                              trailing: Text(
                                                model
                                                    .walletResponse
                                                    .data
                                                    .walletHistory[index]
                                                    .amountSpent,
                                                style: TextStyle(
                                                    color:
                                                        Colors.lightBlueAccent),
                                              ),
                                            ),
                                          ),
                                        ),
                                      )
                                    : Container(
                                        child: Center(child: Text('empty')),
                                      ),
                              )
                            ],
                          ),
                        ])
                      : model.state == ViewState.Busy
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
                            ),
                );
              });
            }));
  }

  void refreshScreen(WalletViewModel model) {
    model.earningWallet();
  }

  Future<TransitionResponse> transitionToPersonal(WalletViewModel model) {
    return model.transitionToPersonal(
        locator<AppLanguage>().appLocal.languageCode,
        _amountController.text.trim(),
        4);
  }
}
