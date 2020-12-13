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

import '../../../utils/app_localizations.dart';

class RewardsWalletScreen extends StatefulWidget {
  @override
  _RewardsWalletScreenState createState() => _RewardsWalletScreenState();
}

class _RewardsWalletScreenState extends State<RewardsWalletScreen> {
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
                return SafeArea(
                  child: Scaffold(
                      key: _scaffoldKey,
                      backgroundColor: Color(0xFFf5f5f5),
                      body: SingleChildScrollView(
                        child: ConstrainedBox(
                          constraints: BoxConstraints(
                            minHeight: viewportConstraints.maxHeight,
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Container(
                              color: Color(0xFFf5f5f5),
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                    vertical: 16.0, horizontal: 8.0),
                                child: Column(
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        InkWell(
                                          onTap: () {
                                            Navigator.of(context).pop();
                                          },
                                          child: Icon(
                                            Icons.arrow_back_ios,
                                            color: Colors.black,
                                          ),
                                        ),
                                        Text(
                                          AppLocalizations.of(context)
                                              .translate('rewards_wallet'),
                                          style: TextStyle(
                                              fontSize: 20,
                                              fontWeight: FontWeight.bold),
                                        ),
                                        Icon(
                                          Icons.cancel,
                                          color: Color(0xFFf5f5f5),
                                        ),
                                      ],
                                    ),
                                    SizedBox(
                                      height: 16,
                                    ),
                                    model.walletResponse != null
                                        ? model.walletResponse.data.balance !=
                                                "0"
                                            ? Container(
                                                color: Colors.white,
                                                child: Column(
                                                  children: [
                                                    Container(
                                                      color: Color(0xFF58c6ef),
                                                      child: Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .all(16.0),
                                                        child: Row(
                                                          children: [
                                                            SvgPicture.asset(
                                                              'images/cash_out.svg',
                                                              height: 25.0,
                                                              width: 25.0,
                                                              allowDrawingOutsideViewBox:
                                                                  true,
                                                              color:
                                                                  Colors.white,
                                                            ),
                                                            SizedBox(
                                                              width: 15,
                                                            ),
                                                            Text(
                                                              AppLocalizations.of(
                                                                      context)
                                                                  .translate(
                                                                      'your_rewards'),
                                                              style: TextStyle(
                                                                  color: Colors
                                                                      .white,
                                                                  fontSize: 20),
                                                            )
                                                          ],
                                                        ),
                                                      ),
                                                    ),
                                                    SizedBox(
                                                      height: 10,
                                                    ),
                                                    Padding(
                                                      padding:
                                                          const EdgeInsets.all(
                                                              8.0),
                                                      child: Column(
                                                        children: [
                                                          Row(
                                                            children: [
                                                              SizedBox(
                                                                width: 8,
                                                              ),
                                                              SvgPicture.asset(
                                                                'images/commission_gift.svg',
                                                                height: 25.0,
                                                                width: 25.0,
                                                                allowDrawingOutsideViewBox:
                                                                    true,
                                                                color: Colors
                                                                    .orange,
                                                              ),
                                                              SizedBox(
                                                                width: 25,
                                                              ),
                                                              Column(
                                                                crossAxisAlignment:
                                                                    CrossAxisAlignment
                                                                        .start,
                                                                children: [
                                                                  Text(
                                                                      'You have a reward'),
                                                                  Text(
                                                                    'From 5himaka',
                                                                    style: TextStyle(
                                                                        color: Colors
                                                                            .grey),
                                                                  ),
                                                                ],
                                                              ),
                                                              Spacer(),
                                                              Padding(
                                                                padding:
                                                                    const EdgeInsets
                                                                            .all(
                                                                        8.0),
                                                                child: Column(
                                                                  children: [
                                                                    Text(
                                                                      model
                                                                          .walletResponse
                                                                          .data
                                                                          .balance,
                                                                      style: TextStyle(
                                                                          color: Colors
                                                                              .blue,
                                                                          decoration:
                                                                              TextDecoration.lineThrough),
                                                                    ),
                                                                    // Text('02/03/2019',
                                                                    //     style: TextStyle(
                                                                    //         color: Colors
                                                                    //             .grey))
                                                                  ],
                                                                ),
                                                              )
                                                            ],
                                                          ),
                                                          SizedBox(
                                                            height: 8,
                                                          ),
                                                          Divider(
                                                            color: Colors.black,
                                                          )
                                                        ],
                                                      ),
                                                    ),
                                                    SizedBox(
                                                      height: 10,
                                                    ),
                                                    Padding(
                                                      padding: const EdgeInsets
                                                              .symmetric(
                                                          horizontal: 20.0,
                                                          vertical: 8),
                                                      child: Container(
                                                        width: double.infinity,
                                                        child: Text(
                                                            AppLocalizations.of(
                                                                    context)
                                                                .translate(
                                                                    'transition_to_personal')),
                                                      ),
                                                    ),
                                                    TextFormField(
                                                      keyboardType:
                                                          TextInputType.number,
                                                      autofocus: false,
                                                      controller:
                                                          _amountController,
                                                      decoration:
                                                          InputDecoration(
                                                        fillColor: Colors.white,
                                                        filled: true,
                                                        errorText: model
                                                                .amountValidate
                                                            ? null
                                                            : AppLocalizations
                                                                    .of(context)
                                                                .translate(
                                                                    'empty_error'),
                                                        prefixIcon: Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                  .all(15.0),
                                                          child:
                                                              SvgPicture.asset(
                                                            'images/icon_money.svg',
                                                            height: 25.0,
                                                            width: 25.0,
                                                            color: Colors.black,
                                                            allowDrawingOutsideViewBox:
                                                                true,
                                                          ),
                                                        ),
                                                        hintText: AppLocalizations
                                                                .of(context)
                                                            .translate(
                                                                'enter_amount_to_load'),
                                                        hintStyle: TextStyle(
                                                            color: Colors.black,
                                                            textBaseline:
                                                                TextBaseline
                                                                    .alphabetic),
                                                        contentPadding:
                                                            EdgeInsets.fromLTRB(
                                                                20.0,
                                                                20.0,
                                                                20.0,
                                                                20.0),
                                                      ),
                                                    ),
                                                    SizedBox(
                                                      height: 15,
                                                    ),
                                                    model.state ==
                                                            ViewState.Busy
                                                        ? Container(
                                                            child: Center(
                                                              child:
                                                                  CircularProgressIndicator(
                                                                backgroundColor:
                                                                    Colors
                                                                        .lightBlue,
                                                              ),
                                                            ),
                                                          )
                                                        : Container(
                                                            width:
                                                                double.infinity,
                                                            child: Padding(
                                                              padding: const EdgeInsets
                                                                      .symmetric(
                                                                  vertical:
                                                                      16.0,
                                                                  horizontal:
                                                                      32),
                                                              child:
                                                                  RaisedButton(
                                                                child: Text(
                                                                  AppLocalizations.of(
                                                                          context)
                                                                      .translate(
                                                                          'transition_to_personal'),
                                                                  style: TextStyle(
                                                                      color: Colors
                                                                          .white),
                                                                ),
                                                                onPressed:
                                                                    () async {
                                                                  if(model.walletResponse.data.balance!="0"){
                                                                  if (model.transitionValidation(
                                                                      _amountController
                                                                          .text
                                                                          .trim())) {
                                                                    TransitionResponse
                                                                        response =
                                                                        await transitionToPersonal(
                                                                            model);
                                                                    if (response ==
                                                                        null) {
                                                                      final snackBar =
                                                                          SnackBar(
                                                                        content:
                                                                            Text(AppLocalizations.of(context).translate('check_network')),
                                                                        backgroundColor:
                                                                            Colors.red,
                                                                      );
                                                                      _scaffoldKey
                                                                          .currentState
                                                                          .showSnackBar(
                                                                              snackBar);
                                                                    } else if (response
                                                                        .status) {
                                                                      showToast(
                                                                          response
                                                                              .msg,
                                                                          Colors
                                                                              .green);
                                                                      Navigator.pop(
                                                                          context);
                                                                    } else {
                                                                      showToast(
                                                                          response
                                                                              .errors
                                                                              .toString(),
                                                                          Colors
                                                                              .red);
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
                                                                color: Colors
                                                                    .lightBlueAccent,
                                                                shape:
                                                                    RoundedRectangleBorder(
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                              5.0),
                                                                ),
                                                              ),
                                                            ),
                                                          ),
                                                    SizedBox(
                                                      height: 10,
                                                    ),
                                                    Padding(
                                                      padding: const EdgeInsets
                                                              .symmetric(
                                                          horizontal: 15.0),
                                                      child: Row(
                                                        children: [
                                                          SvgPicture.asset(
                                                            'images/personal_recent.svg',
                                                            height: 25.0,
                                                            width: 25.0,
                                                            allowDrawingOutsideViewBox:
                                                                true,
                                                          ),
                                                          SizedBox(
                                                            width: 14,
                                                          ),
                                                          Text(AppLocalizations
                                                                  .of(context)
                                                              .translate(
                                                                  'recent_transactions')),
                                                        ],
                                                      ),
                                                    ),
                                                    Container(
                                                      child:  (model.walletResponse.data.walletHistory != null &&
                                                          model.walletResponse.data.walletHistory
                                                              .length >
                                                              0)
                                                          ?  ListView.separated(
                                                              shrinkWrap: true,
                                                              physics:
                                                                  ClampingScrollPhysics(),
                                                              separatorBuilder:
                                                                  (context,
                                                                          index) =>
                                                                      Divider(
                                                                color: Colors
                                                                    .black,
                                                              ),
                                                              itemCount:  model.walletResponse.data.walletHistory
                                                                  .length,
                                                              itemBuilder:
                                                                  (context,
                                                                          index) =>
                                                                      Padding(
                                                                padding:
                                                                    EdgeInsets
                                                                        .all(
                                                                            1.0),
                                                                child: InkWell(
                                                                  onTap: () {},
                                                                  child:
                                                                      ListTile(
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
                                                                    subtitle:
                                                                        Row(
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
                                                                    trailing:
                                                                        Text(
                                                                          model
                                                                              .walletResponse
                                                                              .data
                                                                              .walletHistory[index]
                                                                              .amountSpent,                                                                      style: TextStyle(
                                                                          color:
                                                                              Colors.lightBlueAccent),
                                                                    ),
                                                                  ),
                                                                ),
                                                              ),
                                                            ):
                                                      Container(
                                                        child: Center(
                                                            child: Text(
                                                                'empty')),
                                                      )
                                                          ,
                                                    )
                                                  ],
                                                ))
                                            : Container(
                                                height: 600,
                                                child: Column(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  children: [
                                                    Stack(
                                                      children: [
                                                        Align(
                                                          alignment:
                                                              Alignment.center,
                                                          child:
                                                              SvgPicture.asset(
                                                            'images/no_rewards.svg',
                                                            // height: 300.0,
                                                            allowDrawingOutsideViewBox:
                                                                true,
                                                          ),
                                                        ),
                                                        Align(
                                                          alignment:
                                                              Alignment.center,
                                                          child: Container(
                                                            height: MediaQuery.of(
                                                                        context)
                                                                    .size
                                                                    .height /
                                                                2.7,
                                                            child: Column(
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .center,
                                                              crossAxisAlignment:
                                                                  CrossAxisAlignment
                                                                      .center,
                                                              children: [
                                                                Text(
                                                                  AppLocalizations.of(
                                                                          context)
                                                                      .translate(
                                                                          'empty_reward_msg'),
                                                                  textAlign:
                                                                      TextAlign
                                                                          .center,
                                                                  style: TextStyle(
                                                                      fontSize:
                                                                          20,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .bold,
                                                                      color: Color(
                                                                          0xff555555)),
                                                                ),
                                                                SizedBox(
                                                                  height: 2,
                                                                ),
                                                                Text(
                                                                  AppLocalizations.of(
                                                                          context)
                                                                      .translate(
                                                                          'empty_reward_2_msg'),
                                                                  textAlign:
                                                                      TextAlign
                                                                          .center,
                                                                  style: TextStyle(
                                                                      color: Color(
                                                                          0xffa2a2a2),
                                                                      fontSize:
                                                                          18),
                                                                ),
                                                              ],
                                                            ),
                                                          ),
                                                        )
                                                      ],
                                                    ),
                                                  ],
                                                ),
                                              )
                                        : model.state == ViewState.Busy
                                            ? Column(
                                                children: [
                                                  SizedBox(
                                                    height:
                                                        (MediaQuery.of(context)
                                                                .size
                                                                .height /
                                                            2.4),
                                                  ),
                                                  Center(
                                                    child:
                                                        CircularProgressIndicator(
                                                      backgroundColor:
                                                          Colors.lightBlue,
                                                    ),
                                                  ),
                                                ],
                                              )
                                            : Column(
                                                children: [
                                                  SizedBox(
                                                    height:
                                                        (MediaQuery.of(context)
                                                                .size
                                                                .height /
                                                            2.4),
                                                  ),
                                                  Container(
                                                    child: Center(
                                                      child: Column(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .center,
                                                        children: <Widget>[
                                                          Text(
                                                            AppLocalizations.of(
                                                                    context)
                                                                .translate(
                                                                    'network_failed'),
                                                          ),
                                                          RaisedButton(
                                                            onPressed: () {
                                                              refreshScreen(
                                                                  model);
                                                            },
                                                            color:
                                                                Color.fromRGBO(
                                                                    235,
                                                                    85,
                                                                    85,
                                                                    100),
                                                            child: Icon(
                                                                Icons.refresh),
                                                            shape: new RoundedRectangleBorder(
                                                                borderRadius:
                                                                    new BorderRadius
                                                                            .circular(
                                                                        30),
                                                                side: BorderSide(
                                                                    color: Color
                                                                        .fromRGBO(
                                                                            235,
                                                                            85,
                                                                            85,
                                                                            100))),
                                                          )
                                                        ],
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                      )),
                );
              });
            }));
  }

  void refreshScreen(WalletViewModel model) {
    model.rewardWallet();
  }

  Future<TransitionResponse> transitionToPersonal(WalletViewModel model) {
    return model.transitionToPersonal(
        locator<AppLanguage>().appLocal.languageCode,
        _amountController.text.trim(),
        3);
  }
}
