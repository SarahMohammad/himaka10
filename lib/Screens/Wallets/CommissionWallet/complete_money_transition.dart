import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:himaka/Models/transition_response.dart';
import 'package:himaka/Models/wallet_history.dart';
import 'package:himaka/ViewModels/base_model.dart';
import 'package:himaka/ViewModels/wallet_view_model.dart';
import 'package:himaka/services/base_view.dart';
import 'package:himaka/services/locator.dart';
import 'package:himaka/utils/AppLanguage.dart';
import 'package:himaka/utils/show_toast.dart';

import '../../../utils/app_localizations.dart';
import '../../../utils/globals.dart';

class CompleteMoneyTransitionScreen extends StatefulWidget {
  final bool canConvert;
  final String points;
  final List<WalletHistory> walletHistory;

  CompleteMoneyTransitionScreen(
      this.canConvert, this.points, this.walletHistory);

  @override
  _CompleteMoneyTransitionScreenState createState() =>
      _CompleteMoneyTransitionScreenState();
}

class _CompleteMoneyTransitionScreenState
    extends State<CompleteMoneyTransitionScreen> {
  final _scaffoldKey = new GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return BaseView<WalletViewModel>(
        builder: (context, model, child) => LayoutBuilder(builder:
                (BuildContext context, BoxConstraints viewportConstraints) {
              return LayoutBuilder(builder:
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
                                    SizedBox(
                                      height: 16,
                                    ),
                                    Container(
                                      height: 130,
                                      color: Color(0xFF58c6ef),
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          SizedBox(
                                            height: 8,
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 20.0),
                                            child: Container(
                                              width: double.infinity,
                                              child: Text(
                                                Globals.userData.first_name +
                                                    ' ' +
                                                    Globals.userData.last_name,
                                                style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    color: Colors.white,
                                                    fontSize: 20),
                                                textAlign: TextAlign.start,
                                              ),
                                            ),
                                          ),
                                          SizedBox(
                                            height: 8,
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Container(
                                              decoration: BoxDecoration(
                                                  color: Color(0xFFa5ddf2),
                                                  borderRadius:
                                                      BorderRadius.all(
                                                          Radius.circular(50))),
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.all(8.0),
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
                                                    Text(widget.points +
                                                        ' ' +
                                                        AppLocalizations.of(
                                                                context)
                                                            .translate(
                                                                'points')),
                                                    Spacer(),
                                                    Icon(
                                                      Icons.keyboard_arrow_down,
                                                      color: Color(0xFF595d5d),
                                                      size: 25,
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
                                    Container(
                                      width: double.infinity,
                                      child: Stack(
                                        children: [
                                          SvgPicture.asset(
                                            'images/commission_convert_img.svg',
                                            // height: 120.0,
                                            allowDrawingOutsideViewBox: true,
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 16.0, vertical: 36),
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                // Text(
                                                //   widget.points +
                                                //       ' ' +
                                                //       AppLocalizations.of(context)
                                                //           .translate('points'),
                                                //   style: TextStyle(
                                                //       color: Colors.white,
                                                //       fontSize: 15),
                                                // ),
                                                SizedBox(
                                                  height: 8,
                                                ),
                                                Text(
                                                  AppLocalizations.of(context)
                                                      .translate(
                                                          'complete_points_conversion'),
                                                  style: TextStyle(
                                                      color: Colors.white,
                                                      fontSize: 18),
                                                )
                                              ],
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    Divider(
                                      color: Colors.grey,
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(10.0),
                                      child: Row(
                                        children: [
                                          SizedBox(
                                            width: 8,
                                          ),
                                          SvgPicture.asset(
                                            'images/icon_money.svg',
                                            height: 25.0,
                                            width: 25.0,
                                            color: Colors.black,
                                            allowDrawingOutsideViewBox: true,
                                          ),
                                          SizedBox(
                                            width: 15,
                                          ),
                                          Text(
                                            AppLocalizations.of(context)
                                                .translate(
                                                    'convert_your_points'),
                                            style: TextStyle(
                                                color: Colors.black,
                                                fontSize: 15),
                                          ),
                                          Spacer(),
                                          Text(
                                            widget.points,
                                            style:
                                                TextStyle(color: Colors.blue),
                                          ),
                                        ],
                                      ),
                                    ),
                                    SizedBox(
                                      height: 8,
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: model.state == ViewState.Busy
                                          ? Center(
                                              child: CircularProgressIndicator(
                                                backgroundColor:
                                                    Colors.lightBlue,
                                              ),
                                            )
                                          : Container(
                                              width: double.infinity,
                                              child: RaisedButton(
                                                onPressed: () async {
                                                  if (widget.canConvert) {
                                                    TransitionResponse
                                                        response =
                                                        await convertCommissionWalletPoints(
                                                            model);
                                                    if (response == null) {
                                                      final snackBar = SnackBar(
                                                        content: Text(
                                                            AppLocalizations.of(
                                                                    context)
                                                                .translate(
                                                                    'check_network')),
                                                        backgroundColor:
                                                            Colors.red,
                                                      );
                                                      _scaffoldKey.currentState
                                                          .showSnackBar(
                                                              snackBar);
                                                    } else if (response
                                                        .status) {
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
                                                },
                                                color: widget.canConvert
                                                    ? Colors.blue
                                                    : Color(0xffd2d2d2),
                                                child: Text(
                                                  AppLocalizations.of(context)
                                                      .translate('convert'),
                                                  style: TextStyle(
                                                      color: Colors.white),
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
                                              .translate(
                                                  'recent_transactions')),
                                        ],
                                      ),
                                    ),
                                    Container(
                                      child: (widget.walletHistory != null &&
                                              widget.walletHistory.length > 0)
                                          ? ListView.separated(
                                              shrinkWrap: true,
                                              physics: ClampingScrollPhysics(),
                                              separatorBuilder:
                                                  (context, index) => Divider(
                                                color: Colors.grey[900],
                                              ),
                                              itemCount:
                                                  widget.walletHistory.length,
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
                                                    title: Padding(
                                                      padding:
                                                          const EdgeInsets.only(
                                                              bottom: 8.0),
                                                      child: Row(
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
                                                            widget
                                                                .walletHistory[
                                                                    index]
                                                                .walletTypeFrom,
                                                          ),
                                                        ],
                                                      ),
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
                                                          widget
                                                              .walletHistory[
                                                                  index]
                                                              .createdAt,
                                                        ),
                                                      ],
                                                    ),
                                                    trailing: Text(
                                                      widget
                                                          .walletHistory[index]
                                                          .amountSpent,
                                                      style: TextStyle(
                                                          color: Colors
                                                              .lightBlueAccent),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            )
                                          : Container(
                                              child:
                                                  Center(child: Text('empty')),
                                            ),
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  );
                });
              });
            }));
  }

  Future<TransitionResponse> convertCommissionWalletPoints(
      WalletViewModel model) {
    return model.convertCommissionWalletPoints(
        locator<AppLanguage>().appLocal.languageCode);
  }
}
