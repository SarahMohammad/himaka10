import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:himaka/Models/add_complaint_pre_response.dart';
import 'package:himaka/ViewModels/complaints_history_view_model.dart';
import 'package:himaka/utils/app_bar.dart';
import 'package:himaka/utils/app_localizations.dart';
import 'package:himaka/utils/show_toast.dart';

import '../Models/home_response.dart';
import '../Models/orders_response.dart';
import '../Models/orders_response.dart';
import '../ViewModels/base_model.dart';
import '../services/base_view.dart';
import '../services/locator.dart';
import '../utils/AppLanguage.dart';

class AddComplainScreen extends StatefulWidget {
  @override
  _AddComplainScreenState createState() => _AddComplainScreenState();
}

class _AddComplainScreenState extends State<AddComplainScreen> {
  TextEditingController _complainController = new TextEditingController();
  final _scaffoldKey = new GlobalKey<ScaffoldState>();

  Order order;
  Offer offer;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: setAppBar(
          AppLocalizations.of(context).translate('complaint_requests'),
          context),
      body: BaseView<ComplaintsHistoryViewModel>(
          onModelReady: (model) {
            refreshScreen(model);
          },
          builder: (context, model, child) => LayoutBuilder(builder:
                  (BuildContext context, BoxConstraints viewportConstraints) {
                return (model.state == ViewState.Busy && model.serviceId == 1)
                    ? Center(
                        child: CircularProgressIndicator(
                          backgroundColor: Colors.lightBlue,
                        ),
                      )
                    : model.addComplaintPreResponse != null
                        ? model.addComplaintPreResponse.data != null
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
                                              'images/plus.svg',
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
                                                    .translate('add_complain'),
                                                style: TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 15)),
                                          ],
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(15.0),
                                      child: Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Icon(
                                            Icons.info,
                                            color: Colors.grey,
                                          ),
                                          SizedBox(
                                            width: 16,
                                          ),
                                          Flexible(
                                            child: Text(
                                                AppLocalizations.of(context)
                                                    .translate(
                                                        'add_complain_text'),
                                                textAlign: TextAlign.justify,
                                                style: TextStyle(
                                                    color: Colors.grey,
                                                    fontSize: 15)),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Container(
                                      padding: EdgeInsets.only(top: 20.0),
                                      width: MediaQuery.of(context).size.width,
                                      child: DropdownButton<Order>(
                                        dropdownColor: Colors.white,
                                        icon: Icon(
                                          Icons.arrow_drop_down,
                                          color: Colors.black,
                                        ),
                                        isExpanded: true,
                                        hint: Padding(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 16.0),
                                          child: Text(
                                            "Select your order",
                                            style:
                                                TextStyle(color: Colors.black),
                                          ),
                                        ),
                                        value: order,
                                        onChanged: (Order value) {
                                          setState(() {
                                            order = value;
                                            offer = null;
                                          });
                                        },
                                        items: model
                                            .addComplaintPreResponse.data.orders
                                            .map(
                                          (Order question) {
                                            return DropdownMenuItem<Order>(
                                              value: question,
                                              child: Row(
                                                children: [
                                                  Padding(
                                                    padding: const EdgeInsets
                                                            .symmetric(
                                                        horizontal: 16.0),
                                                    child: Text(
                                                      "# " +
                                                          question.id
                                                              .toString(),
                                                      style: TextStyle(
                                                          color: Colors.black),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            );
                                          },
                                        ).toList(),
                                      ),
                                    ),
                                    model.orderValidate
                                        ? Container()
                                        : Container(
                                      width: double.infinity,
                                      child: Padding(
                                        padding: const EdgeInsets.symmetric(horizontal:16.0),
                                        child: Text(
                                          AppLocalizations.of(context)
                                              .translate('list_error'),
                                          style: TextStyle(
                                              color: Colors.red[700],
                                              fontSize: 13),
                                          textAlign: TextAlign.start,
                                        ),
                                      ),
                                    ),
                                    Container(
                                      padding: EdgeInsets.only(top: 20.0),
                                      width: MediaQuery.of(context).size.width,
                                      child: DropdownButton<Offer>(
                                        dropdownColor: Colors.white,
                                        icon: Icon(
                                          Icons.arrow_drop_down,
                                          color: Colors.black,
                                        ),
                                        isExpanded: true,
                                        hint: Padding(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 16.0),
                                          child: Text(
                                            "Select item from order",
                                            style:
                                                TextStyle(color: Colors.black),
                                          ),
                                        ),
                                        value: offer,
                                        onChanged: (Offer value) {
                                          setState(() {
                                            offer = value;
                                          });
                                        },
                                        items: model
                                            .getOrderProducts(
                                                order != null ? order.id : null)
                                            .map(
                                          (Offer question) {
                                            return DropdownMenuItem<Offer>(
                                              value: question,
                                              child: Row(
                                                children: [
                                                  Padding(
                                                    padding: const EdgeInsets
                                                            .symmetric(
                                                        horizontal: 16.0),
                                                    child: Text(
                                                      question.name != null
                                                          ? question.name
                                                          : "item name",
                                                      style: TextStyle(
                                                          color: Colors.black),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            );
                                          },
                                        ).toList(),
                                      ),
                                    ),
                                    model.productValidate
                                        ? Container()
                                        : Container(
                                      width: double.infinity,
                                      child: Padding(
                                        padding: const EdgeInsets.symmetric(horizontal:16.0),
                                        child: Text(
                                          AppLocalizations.of(context)
                                              .translate('list_error'),
                                          style: TextStyle(
                                              color: Colors.red[700],
                                              fontSize: 13),
                                          textAlign: TextAlign.start,
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: TextFormField(
                                        autofocus: false,
                                        controller: _complainController,
                                        decoration: InputDecoration(
                                          errorText: model.detailsValidate
                                              ? null
                                              : AppLocalizations.of(context)
                                                  .translate('empty_error'),
                                          hintText: AppLocalizations.of(context)
                                              .translate('explain_complaint'),
                                          hintStyle: TextStyle(
                                              color: Colors.grey,
                                              textBaseline:
                                                  TextBaseline.alphabetic),
                                          contentPadding: EdgeInsets.fromLTRB(
                                              20.0, 20.0, 20.0, 20.0),
                                        ),
                                      ),
                                    ),
                                    model.state == ViewState.Busy
                                        ? Container(
                                            child: Center(
                                              child: Padding(
                                                padding: const EdgeInsets.all(8.0),
                                                child: CircularProgressIndicator(
                                                  backgroundColor:
                                                      Colors.lightBlue,
                                                ),
                                              ),
                                            ),
                                          )
                                        : Container(
                                            width: double.infinity,
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      vertical: 16.0,
                                                      horizontal: 32),
                                              child: RaisedButton(
                                                child: Text(
                                                  AppLocalizations.of(context)
                                                      .translate('submit'),
                                                  style: TextStyle(
                                                      color: Colors.white),
                                                ),
                                                onPressed: () async {
                                                  if (model
                                                      .addComplaintValidation(
                                                          _complainController
                                                              .text,
                                                          order,
                                                          offer)) {
                                                    AddComplaintPreResponse
                                                        response =
                                                        await addComplaint(model);
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
                                                      showToast(
                                                          AppLocalizations.of(
                                                                  context)
                                                              .translate(
                                                                  'sent_successfully'),
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
                                                color: Colors.lightBlueAccent,
                                                shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          5.0),
                                                ),
                                              ),
                                            ),
                                          )
                                  ],
                                ),
                              ])
                            : Container(
                                child: Center(
                                  child: Text(AppLocalizations.of(context)
                                      .translate('empty_orders')),
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
              })),
    );
  }

  void refreshScreen(ComplaintsHistoryViewModel model) {
    model.addComplaintPre(locator<AppLanguage>().appLocal.languageCode);
  }
  Future<AddComplaintPreResponse> addComplaint(ComplaintsHistoryViewModel model) {
    return model.addComplaint(locator<AppLanguage>().appLocal.languageCode,_complainController.text,order.id,offer.id);
  }
}
