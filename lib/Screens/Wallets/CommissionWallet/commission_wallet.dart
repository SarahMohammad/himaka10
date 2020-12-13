import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:himaka/Models/transition_response.dart';
import 'package:himaka/Screens/Wallets/CommissionWallet/complete_money_transition.dart';
import 'package:himaka/Screens/Wallets/CommissionWallet/view_members.dart';
import 'package:himaka/ViewModels/base_model.dart';
import 'package:himaka/ViewModels/wallet_view_model.dart';
import 'package:himaka/services/base_view.dart';
import 'package:himaka/services/locator.dart';
import 'package:himaka/utils/AppLanguage.dart';
import 'package:himaka/utils/show_toast.dart';

import '../../../utils/app_localizations.dart';
import '../../../utils/globals.dart';

class CommissionWalletScreen extends StatefulWidget {
  @override
  _CommissionWalletScreenState createState() => _CommissionWalletScreenState();
}

class _CommissionWalletScreenState extends State<CommissionWalletScreen> {
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
                                              .translate('commission_wallet'),
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
                                    model.walletResponse != null
                                        ? Column(
                                            children: [
                                              SizedBox(
                                                height: 16,
                                              ),
                                              Container(
                                                height: 130,
                                                color: Color(0xFF58c6ef),
                                                child: Column(
                                                  mainAxisAlignment: MainAxisAlignment.center,
                                                  children: [
                                                    SizedBox(
                                                      height: 8,
                                                    ),
                                                    Padding(
                                                      padding: const EdgeInsets
                                                              .symmetric(
                                                          horizontal: 20.0),
                                                      child: Container(
                                                        width: double.infinity,
                                                        child: Text(
                                                          Globals.userData
                                                                  .first_name +
                                                              ' ' +
                                                              Globals.userData
                                                                  .last_name,
                                                          style: TextStyle(
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                              color:
                                                                  Colors.white,
                                                              fontSize: 20),
                                                          textAlign:
                                                              TextAlign.start,
                                                        ),
                                                      ),
                                                    ),
                                                    SizedBox(
                                                      height: 8,
                                                    ),
                                                    Padding(
                                                      padding:
                                                          const EdgeInsets.all(
                                                              8.0),
                                                      child: Container(
                                                        decoration: BoxDecoration(
                                                            color: Color(
                                                                0xFFa5ddf2),
                                                            borderRadius:
                                                                BorderRadius
                                                                    .all(Radius
                                                                        .circular(
                                                                            50))),
                                                        child: Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                  .all(8.0),
                                                          child: Row(
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
                                                              ),
                                                              SizedBox(
                                                                width: 8,
                                                              ),
                                                              Text(model
                                                                      .walletResponse
                                                                      .data
                                                                      .points +
                                                                  ' ' +
                                                                  AppLocalizations.of(
                                                                          context)
                                                                      .translate(
                                                                          'points')),
                                                              Spacer(),
                                                              InkWell(
                                                                onTap: () {
                                                                  Navigator.push(
                                                                      context,
                                                                      new MaterialPageRoute(
                                                                          builder: (context) => new CompleteMoneyTransitionScreen(
                                                                              model.walletResponse.data.isPoints,
                                                                              model.walletResponse.data.points,model.walletResponse.data.walletHistory)));
                                                                },
                                                                child: Icon(
                                                                  Icons
                                                                      .arrow_forward_ios,
                                                                  color: Color(
                                                                      0xFF595d5d),
                                                                ),
                                                              )
                                                            ],
                                                          ),
                                                        ),
                                                      ),
                                                    )
                                                  ],
                                                ),
                                              ),
                                              SizedBox(
                                                height: 10,
                                              ),
                                              // Container(
                                              //   color: Colors.white,
                                              //   child:
                                              //       model
                                              //                   .walletResponse
                                              //                   .data
                                              //                   .members
                                              //                   .length >
                                              //               0
                                              //           ? ListView.builder(
                                              //               physics:
                                              //                   NeverScrollableScrollPhysics(),
                                              //               shrinkWrap: true,
                                              //               itemCount: model
                                              //                   .walletResponse
                                              //                   .data
                                              //                   .members
                                              //                   .length,
                                              //               scrollDirection:
                                              //                   Axis.vertical,
                                              //               itemBuilder:
                                              //                   (BuildContext
                                              //                           context,
                                              //                       int index) {
                                              //                 return Padding(
                                              //                   padding:
                                              //                       const EdgeInsets
                                              //                               .all(
                                              //                           8.0),
                                              //                   child: Column(
                                              //                     children: [
                                              //                       Row(
                                              //                         children: [
                                              //                           SizedBox(
                                              //                             width:
                                              //                                 8,
                                              //                           ),
                                              //                           SvgPicture
                                              //                               .asset(
                                              //                             'images/commission_member_icon.svg',
                                              //                             height:
                                              //                                 25.0,
                                              //                             width:
                                              //                                 25.0,
                                              //                             allowDrawingOutsideViewBox:
                                              //                                 true,
                                              //                           ),
                                              //                           SizedBox(
                                              //                             width:
                                              //                                 25,
                                              //                           ),
                                              //                           Text(model
                                              //                               .walletResponse
                                              //                               .data
                                              //                               .members[index]
                                              //                               .name),
                                              //                           Spacer(),
                                              //                           InkWell(
                                              //                             onTap:
                                              //                                 () {
                                              //                               Navigator.push(context,
                                              //                                   new MaterialPageRoute(builder: (context) => new ViewTreeMembers(model.walletResponse.data.members[index].id)));
                                              //                             },
                                              //                             child:
                                              //                                 Container(
                                              //                               decoration:
                                              //                                   BoxDecoration(color: Color(0xFF58c6ef), borderRadius: BorderRadius.all(Radius.circular(15))),
                                              //                               child:
                                              //                                   Padding(
                                              //                                 padding: const EdgeInsets.symmetric(vertical: 4.0, horizontal: 32),
                                              //                                 child: Text(
                                              //                                   AppLocalizations.of(context).translate('view'),
                                              //                                   style: TextStyle(color: Colors.white),
                                              //                                 ),
                                              //                               ),
                                              //                             ),
                                              //                           )
                                              //                         ],
                                              //                       ),
                                              //                       SizedBox(
                                              //                         height: 8,
                                              //                       ),
                                              //                       (index ==  (model
                                              //                           .walletResponse
                                              //                           .data
                                              //                           .members
                                              //                           .length-1))
                                              //                           ? Container()
                                              //                           : Divider(
                                              //                               color:
                                              //                                   Colors.grey,
                                              //                             )
                                              //                     ],
                                              //                   ),
                                              //                 );
                                              //               },
                                              //             )
                                              //           : Center(
                                              //               child: Text(
                                              //                   AppLocalizations.of(
                                              //                           context)
                                              //                       .translate(
                                              //                           'no_members_yest')),
                                              //             ),
                                              // ),
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    top: 32.0,
                                                    left: 32,
                                                    right: 32),
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    Text(
                                                      AppLocalizations.of(
                                                              context)
                                                          .translate(
                                                              'wallet_balance'),
                                                      style: TextStyle(
                                                          color:
                                                              Color(0xFF6d6d6d),
                                                          fontSize: 15),
                                                    ),
                                                    Text(
                                                      model.walletResponse.data
                                                          .balance,
                                                      style: TextStyle(
                                                          color: Color(
                                                              0xFF58c6ef)),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              SizedBox(
                                                height: 8,
                                              ),
                                              Divider(
                                                color: Colors.grey,
                                              ),
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    top: 16.0,
                                                    left: 32,
                                                    right: 32),
                                                child: Container(
                                                  width: double.infinity,
                                                  child: Text(
                                                    AppLocalizations.of(context)
                                                        .translate(
                                                            'transition_to_personal'),
                                                    style: TextStyle(
                                                        color:
                                                            Color(0xFF6d6d6d),
                                                        fontSize: 15),
                                                  ),
                                                ),
                                              ),
                                              SizedBox(
                                                height: 8,
                                              ),
                                              TextFormField(
                                                keyboardType:
                                                    TextInputType.number,
                                                autofocus: false,
                                                controller: _amountController,
                                                decoration: InputDecoration(
                                                  fillColor: Colors.white,
                                                  filled: true,
                                                  errorText: model
                                                          .amountValidate
                                                      ? null
                                                      : AppLocalizations.of(
                                                              context)
                                                          .translate(
                                                              'empty_error'),
                                                  prefixIcon: Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            15.0),
                                                    child: SvgPicture.asset(
                                                      'images/icon_money.svg',
                                                      height: 25.0,
                                                      width: 25.0,
                                                      color: Colors.black,
                                                      allowDrawingOutsideViewBox:
                                                          true,
                                                    ),
                                                  ),
                                                  hintText: AppLocalizations.of(
                                                          context)
                                                      .translate(
                                                          'enter_amount_to_load'),
                                                  hintStyle: TextStyle(
                                                      color: Colors.black,
                                                      textBaseline: TextBaseline
                                                          .alphabetic),
                                                  contentPadding:
                                                      EdgeInsets.fromLTRB(20.0,
                                                          20.0, 20.0, 20.0),
                                                ),
                                              ),
                                              // Container(
                                              //   color: Colors.white,
                                              //   child: Padding(
                                              //     padding: const EdgeInsets.all(10.0),
                                              //     child: Row(
                                              //       children: [
                                              //         SizedBox(
                                              //           width: 8,
                                              //         ),
                                              //         SvgPicture.asset(
                                              //           'images/icon_money.svg',
                                              //           height: 25.0,
                                              //           width: 25.0,
                                              //           color: Colors.black,
                                              //           allowDrawingOutsideViewBox:
                                              //               true,
                                              //         ),
                                              //         SizedBox(
                                              //           width: 15,
                                              //         ),
                                              //         Text(
                                              //           AppLocalizations.of(context)
                                              //               .translate(
                                              //                   'enter_amount_to_load'),
                                              //           style: TextStyle(
                                              //               color: Colors.black,
                                              //               fontSize: 15),
                                              //         ),
                                              //       ],
                                              //     ),
                                              //   ),
                                              // ),
                                              Padding(
                                                padding:
                                                    const EdgeInsets.all(8.0),
                                                child: model.state ==
                                                        ViewState.Busy
                                                    ? Center(
                                                        child:
                                                            CircularProgressIndicator(
                                                          backgroundColor:
                                                              Color(0xFF58c6ef),
                                                        ),
                                                      )
                                                    : Container(
                                                        width: double.infinity,
                                                        child: RaisedButton(
                                                          onPressed: () async {
                                                            if(model.walletResponse.data
                                                                .balance!="0"){
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
                                                                  content: Text(AppLocalizations.of(
                                                                          context)
                                                                      .translate(
                                                                          'check_network')),
                                                                  backgroundColor:
                                                                      Colors
                                                                          .red,
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
                                                                    Colors.red);
                                                              }
                                                            }}else{
                                                              showToast(
                                                                  AppLocalizations.of(
                                                                      context)
                                                                      .translate(
                                                                      'balance_not_enough'),
                                                                  Colors.red);
                                                            }
                                                          },
                                                          color:
                                                              Color(0xFF58c6ef),
                                                          child: Text(
                                                            AppLocalizations.of(
                                                                    context)
                                                                .translate(
                                                                    'complete_your_transition'),
                                                            style: TextStyle(
                                                                color: Colors
                                                                    .white),
                                                          ),
                                                        ),
                                                      ),
                                              )
                                            ],
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
    model.commissionWallet();
  }

  Future<TransitionResponse> transitionToPersonal(WalletViewModel model) {
    return model.transitionToPersonal(
        locator<AppLanguage>().appLocal.languageCode,
        _amountController.text.trim(),
        2);
  }
}
