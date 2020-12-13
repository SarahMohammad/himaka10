import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:himaka/ViewModels/base_model.dart';
import 'package:himaka/ViewModels/wallet_view_model.dart';
import 'package:himaka/services/base_view.dart';
import 'package:himaka/utils/app_localizations.dart';

class ViewTreeMembers extends StatefulWidget {
  final int memberId;

  ViewTreeMembers(this.memberId);

  @override
  _ViewTreeMembersState createState() => _ViewTreeMembersState();
}

class _ViewTreeMembersState extends State<ViewTreeMembers> {
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
                      backgroundColor: Color(0xFFf5f5f5),
                      body: Padding(
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
                                model.walletResponse != null
                                    ? model.walletResponse.data.members.length >
                                            0
                                        ? Expanded(
                                            child: Container(
                                              color: Colors.white,
                                              child: ListView.builder(
                                                itemCount: model.walletResponse
                                                    .data.members.length,
                                                scrollDirection: Axis.vertical,
                                                itemBuilder:
                                                    (BuildContext context,
                                                        int index) {
                                                  return Padding(
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
                                                      'images/commission_member_icon.svg',
                                                      height: 25.0,
                                                      width: 25.0,
                                                      allowDrawingOutsideViewBox: true,
                                                    ),
                                                            SizedBox(
                                                              width: 25,
                                                            ),
                                                            Text(model
                                                                .walletResponse
                                                                .data
                                                                .members[index]
                                                                .name),
                                                            Spacer(),
                                                            InkWell(
                                                              onTap: () {
                                                                Navigator.push(
                                                                    context,
                                                                    new MaterialPageRoute(
                                                                        builder: (context) => new ViewTreeMembers(model
                                                                            .walletResponse
                                                                            .data
                                                                            .members[index]
                                                                            .id)));
                                                              },
                                                              child: Container(
                                                                decoration: BoxDecoration(
                                                                    color: Color(0xFF58c6ef),
                                                                    borderRadius:
                                                                        BorderRadius.all(
                                                                            Radius.circular(15))),
                                                                child: Padding(
                                                                  padding: const EdgeInsets
                                                                          .symmetric(
                                                                      vertical:
                                                                          4.0,
                                                                      horizontal:
                                                                          32),
                                                                  child: Text(
                                                                    AppLocalizations.of(
                                                                            context)
                                                                        .translate(
                                                                            'view'),
                                                                    style: TextStyle(
                                                                        color: Colors
                                                                            .white),
                                                                  ),
                                                                ),
                                                              ),
                                                            )
                                                          ],
                                                        ),
                                                        SizedBox(
                                                          height: 8,
                                                        ),
                                                        (index == 4)
                                                            ? Container()
                                                            : Divider(
                                                                color:
                                                                    Colors.grey,
                                                              )
                                                      ],
                                                    ),
                                                  );
                                                },
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
                                              Container(
                                                  child: Center(
                                                child: Text(
                                                    AppLocalizations.of(context)
                                                        .translate('empty')),
                                              )),
                                            ],
                                          )
                                    : model.state == ViewState.Busy
                                        ? Column(
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
                                          )
                                        : Column(
                                            children: [
                                              SizedBox(
                                                height: (MediaQuery.of(context)
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
                                                          refreshScreen(model);
                                                        },
                                                        color: Color.fromRGBO(
                                                            235, 85, 85, 100),
                                                        child:
                                                            Icon(Icons.refresh),
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
                      )),
                );
              });
            }));
  }

  void refreshScreen(WalletViewModel model) {
    model.getMembers(widget.memberId);
  }
}
