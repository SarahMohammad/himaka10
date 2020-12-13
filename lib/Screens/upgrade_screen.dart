import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:himaka/Models/pre_upgrade_response.dart';
import 'package:himaka/ViewModels/base_model.dart';
import 'package:himaka/ViewModels/upgrade_view_model.dart';
import 'package:himaka/services/base_view.dart';
import 'package:himaka/services/locator.dart';
import 'package:himaka/utils/AppLanguage.dart';
import 'package:himaka/utils/app_localizations.dart';
import 'package:himaka/utils/show_toast.dart';

class UpgradeScreen extends StatefulWidget {
  @override
  _UpgradeScreenState createState() => _UpgradeScreenState();
}

class _UpgradeScreenState extends State<UpgradeScreen> {
  final _scaffoldKey = new GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return BaseView<UpgradeViewModel>(
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
                    backgroundColor: Color(0xFFeeeeee),
                    body: SingleChildScrollView(
                      child: ConstrainedBox(
                        constraints: BoxConstraints(
                          minHeight: viewportConstraints.maxHeight,
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                            color: Colors.white,
                            child: Column(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 16.0, horizontal: 8.0),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Icon(
                                        Icons.clear,
                                        color: Colors.white,
                                      ),
                                      Text(
                                        AppLocalizations.of(context)
                                            .translate('personal_wallet'),
                                        style: TextStyle(
                                            fontSize: 20,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      InkWell(
                                        onTap: () {
                                          Navigator.of(context).pop();
                                        },
                                        child: SvgPicture.asset(
                                          'images/close.svg',
                                          height: 25.0,
                                          width: 25.0,
                                          allowDrawingOutsideViewBox: true,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                model.preUpgradeResponse != null
                                    ? Column(
                                        children: [
                                          Stack(
                                            children: [
                                              Container(
                                                child: Image.asset(
                                                  'images/upgrade.png',
                                                  fit: BoxFit.fill,
                                                ),
                                              ),
                                              Padding(
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        horizontal: 16.0,
                                                        vertical: 16),
                                                child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Padding(
                                                      padding:
                                                          const EdgeInsets.all(
                                                              8.0),
                                                      child: Text(
                                                        AppLocalizations.of(
                                                                context)
                                                            .translate(
                                                                'upgrade'),
                                                        style: TextStyle(
                                                            color: Colors.white,
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            fontSize: 20),
                                                      ),
                                                    ),
                                                    SizedBox(
                                                      height: 16,
                                                    ),
                                                    Row(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        Icon(
                                                          Icons.info,
                                                          color: Colors.white,
                                                          size: 18,
                                                        ),
                                                        SizedBox(
                                                          width: 2,
                                                        ),
                                                        Text(
                                                          AppLocalizations.of(
                                                                  context)
                                                              .translate(
                                                                  'upgrade_img_text'),
                                                          style: TextStyle(
                                                              color:
                                                                  Colors.white,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                              fontSize: 12),
                                                        ),
                                                      ],
                                                    )
                                                  ],
                                                ),
                                              )
                                            ],
                                          ),
                                          SizedBox(
                                            height: 8,
                                          ),
                                          Container(
                                            height: 250,
                                            child: ListView.builder(
                                              itemCount: model
                                                  .preUpgradeResponse
                                                  .data
                                                  .cards
                                                  .length,
                                              scrollDirection: Axis.horizontal,
                                              itemBuilder:
                                                  (BuildContext context,
                                                      int index) {
                                                return Padding(
                                                  padding:
                                                      const EdgeInsets.all(8.0),
                                                  child: Container(
                                                    decoration: BoxDecoration(
                                                        color:
                                                            Color(0xFFf4f4f4),
                                                        borderRadius:
                                                            BorderRadius.all(
                                                                Radius.circular(
                                                                    30))),
                                                    width: 210.0,
                                                    child: Column(
                                                      children: [
                                                        Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                      .only(
                                                                  top: 16.0,
                                                                  left: 16.0,
                                                                  right: 16.0,
                                                                  bottom: 4),
                                                          child: Row(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .center,
                                                            children: [
                                                              SvgPicture.asset(
                                                                'images/upgrade_calender.svg',
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
                                                                    .preUpgradeResponse
                                                                    .data
                                                                    .cards[
                                                                        index]
                                                                    .duration,
                                                                style: TextStyle(
                                                                    color: Color(
                                                                        0xFFa8a8a8),
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .bold),
                                                              ),
                                                              // Text(
                                                              //   '-',
                                                              //   style: TextStyle(
                                                              //       color: Color(
                                                              //           0xFFaeaeae),
                                                              //       fontWeight:
                                                              //           FontWeight.bold),
                                                              // ),
                                                              // Text(
                                                              //   '360 Days',
                                                              //   style: TextStyle(
                                                              //       color: Color(
                                                              //           0xFFaeaeae),
                                                              //       fontWeight:
                                                              //           FontWeight.bold),
                                                              // ),
                                                            ],
                                                          ),
                                                        ),
                                                        Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                      .symmetric(
                                                                  horizontal:
                                                                      4.0),
                                                          child: Divider(
                                                              color:
                                                                  Colors.grey),
                                                        ),
                                                        Text(
                                                          model
                                                                      .preUpgradeResponse
                                                                      .data
                                                                      .cards[
                                                                          index]
                                                                      .status ==
                                                                  2
                                                              ? 'Standard'
                                                              : model
                                                                          .preUpgradeResponse
                                                                          .data
                                                                          .cards[
                                                                              index]
                                                                          .status ==
                                                                      3
                                                                  ? 'Second Upgrade'
                                                                  : 'First Upgrade',
                                                          style: TextStyle(
                                                              color: Color(
                                                                  0xFF727272),
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                              fontSize: 20),
                                                        ),
                                                        SizedBox(
                                                          height: 4,
                                                        ),
                                                        Text(
                                                          model
                                                                  .preUpgradeResponse
                                                                  .data
                                                                  .cards[index]
                                                                  .cost +
                                                              ' ' +
                                                              model
                                                                  .preUpgradeResponse
                                                                  .data
                                                                  .cards[index]
                                                                  .currency,
                                                          style: TextStyle(
                                                              color: Color(
                                                                  0xFF727272),
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                              fontSize: 20),
                                                        ),
                                                        SizedBox(
                                                          height: 10,
                                                        ),
                                                        Container(
                                                          width:
                                                              double.infinity,
                                                          decoration:
                                                              BoxDecoration(
                                                                  color: Color(
                                                                      0xFFbcd8e3),
                                                                  borderRadius:
                                                                      new BorderRadius
                                                                          .only(
                                                                    topLeft: const Radius
                                                                            .circular(
                                                                        30.0),
                                                                    topRight:
                                                                        const Radius.circular(
                                                                            30.0),
                                                                  )),
                                                          child: Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                    .all(16.0),
                                                            child: Center(
                                                              child: Text(
                                                                'The Commission can be\navailed by five people',
                                                                style: TextStyle(
                                                                    color: Colors
                                                                        .black,
                                                                    fontSize:
                                                                        15),
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                        InkWell(
                                                          onTap: () async {
                                                            if (model
                                                                    .preUpgradeResponse
                                                                    .data
                                                                    .cards[
                                                                        index]
                                                                    .status ==
                                                                3) {
                                                              PreUpgradeResponse
                                                                  response =
                                                                  await upgrade(
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
                                                                Navigator.pop(
                                                                    context);
                                                              }
                                                            }
                                                          },
                                                          child: Container(
                                                            width:
                                                                double.infinity,
                                                            decoration:
                                                                BoxDecoration(
                                                                    color: model.preUpgradeResponse.data.cards[index].status ==
                                                                            2
                                                                        ? Color(
                                                                            0xFF45e16a)
                                                                        : model.preUpgradeResponse.data.cards[index].status ==
                                                                                3
                                                                            ? Color(
                                                                                0xFFd2d2d2)
                                                                            : Colors
                                                                                .red,
                                                                    borderRadius:
                                                                        new BorderRadius
                                                                            .only(
                                                                      bottomLeft:
                                                                          const Radius.circular(
                                                                              30.0),
                                                                      bottomRight:
                                                                          const Radius.circular(
                                                                              30.0),
                                                                    )),
                                                            child: Padding(
                                                              padding:
                                                                  const EdgeInsets
                                                                          .all(
                                                                      16.0),
                                                              child: Center(
                                                                child: Text(
                                                                  'Upgrade now',
                                                                  style: TextStyle(
                                                                      color: Colors
                                                                          .white,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .bold,
                                                                      fontSize:
                                                                          15),
                                                                ),
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                );
                                              },
                                            ),
                                          ),
                                        ],
                                      )
                                    : model.state == ViewState.Idle
                                        ? Container(
                                            child: Center(
                                              child: Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: <Widget>[
                                                  SizedBox(
                                                    height:
                                                        (MediaQuery.of(context)
                                                                .size
                                                                .height /
                                                            2.4),
                                                  ),
                                                  Text(
                                                    AppLocalizations.of(context)
                                                        .translate(
                                                            'network_failed'),
                                                  ),
                                                  RaisedButton(
                                                    onPressed: () {
                                                      refreshScreen(model);
                                                    },
                                                    color: Color.fromRGBO(
                                                        235, 85, 85, 100),
                                                    child: Icon(Icons.refresh),
                                                    shape:
                                                        new RoundedRectangleBorder(
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
                                          )
                                        : Column(
                                            children: [
                                              SizedBox(
                                                height: (MediaQuery.of(context)
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
                                          ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                );
              });
            }));
  }

  refreshScreen(UpgradeViewModel model) {
    model.preUpgrade(locator<AppLanguage>().appLocal.languageCode);
  }

  Future<PreUpgradeResponse> upgrade(UpgradeViewModel model) {
    return model.upgrade(locator<AppLanguage>().appLocal.languageCode);
  }
}
