import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:himaka/Screens/congratulation_order_details.dart';
import 'package:himaka/ViewModels/base_model.dart';
import 'package:himaka/ViewModels/orders_view_model.dart';
import 'package:himaka/services/base_view.dart';
import 'package:himaka/services/locator.dart';
import 'package:himaka/utils/AppLanguage.dart';
import 'package:himaka/utils/app_localizations.dart';
import 'package:smooth_star_rating/smooth_star_rating.dart';

class OrderDetailsScreen extends StatefulWidget {
  final int orderId;

  OrderDetailsScreen(this.orderId);

  @override
  _OrderDetailsScreenState createState() => _OrderDetailsScreenState();
}

class _OrderDetailsScreenState extends State<OrderDetailsScreen> {
  double rating = 5.0;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
        builder: (BuildContext context, BoxConstraints viewportConstraints) {
      return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.lightBlue,
          elevation: 0,
          iconTheme: IconThemeData(color: Colors.white),
          title: Text(AppLocalizations.of(context).translate('your_order')),
          centerTitle: true,
        ),
        backgroundColor: Color(0xFFeeeeee),
        body: BaseView<OrdersViewModel>(
            onModelReady: (model) {
              refreshScreen(model);
            },
            builder: (context, model, child) => LayoutBuilder(builder:
                    (BuildContext context, BoxConstraints viewportConstraints) {
                  return model.state == ViewState.Busy
                      ? Center(
                          child: CircularProgressIndicator(
                            backgroundColor: Colors.lightBlue,
                          ),
                        )
                      : model.orderDetailsResponse != null
                          ? SingleChildScrollView(
                              child: ConstrainedBox(
                                constraints: BoxConstraints(
                                  minHeight: viewportConstraints.maxHeight,
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Column(
                                    children: [
                                      Container(
                                        color: Colors.white,
                                        child: Column(
                                          children: [
                                            // Row(
                                            //   mainAxisAlignment:
                                            //       MainAxisAlignment.center,
                                            //   children: [
                                            //     SmoothStarRating(
                                            //         allowHalfRating: false,
                                            //         onRated: (v) {
                                            //           rating = v;
                                            //         },
                                            //         starCount: 5,
                                            //         rating: rating,
                                            //         size: 25.0,
                                            //         isReadOnly: true,
                                            //         color: Colors.orange,
                                            //         borderColor: Colors.orange,
                                            //         spacing: 0.0),
                                            //   ],
                                            // ),
                                            SizedBox(
                                              height: 8,
                                            ),
                                            Text(
                                              model
                                                          .orderDetailsResponse
                                                          .data
                                                          .orderDetails
                                                          .shippingAddress1 !=
                                                      null
                                                  ? model
                                                      .orderDetailsResponse
                                                      .data
                                                      .orderDetails
                                                      .shippingAddress1
                                                  : model
                                                              .orderDetailsResponse
                                                              .data
                                                              .orderDetails
                                                              .shippingAddress2 !=
                                                          null
                                                      ? model
                                                          .orderDetailsResponse
                                                          .data
                                                          .orderDetails
                                                          .shippingAddress2
                                                      : model
                                                                  .orderDetailsResponse
                                                                  .data
                                                                  .orderDetails
                                                                  .billingAddress1 !=
                                                              null
                                                          ? model
                                                              .orderDetailsResponse
                                                              .data
                                                              .orderDetails
                                                              .billingAddress1
                                                          : model
                                                              .orderDetailsResponse
                                                              .data
                                                              .orderDetails
                                                              .billingAddress2,
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold),
                                            ),
                                            SizedBox(
                                              height: 8,
                                            ),
                                            Text(AppLocalizations.of(context)
                                                    .translate('order') +
                                                '#' +
                                                model.orderDetailsResponse.data
                                                    .orderDetails.id
                                                    .toString()),
                                            Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      vertical: 8.0,
                                                      horizontal: 20),
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Row(
                                                    children: [
                                                      Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .all(5.0),
                                                        child: SvgPicture.asset(
                                                          'images/Component6.svg',
                                                          height: 25.0,
                                                          width: 25.0,
                                                          color:
                                                              Colors.lightBlue,
                                                          allowDrawingOutsideViewBox:
                                                              true,
                                                        ),
                                                      ),
                                                      SizedBox(
                                                        width: 4,
                                                      ),
                                                      Text(model
                                                              .orderDetailsResponse
                                                              .data
                                                              .orderDetails
                                                              .createdAt
                                                              .day
                                                              .toString() +
                                                          '/' +
                                                          model
                                                              .orderDetailsResponse
                                                              .data
                                                              .orderDetails
                                                              .createdAt
                                                              .month
                                                              .toString() +
                                                          '/' +
                                                          model
                                                              .orderDetailsResponse
                                                              .data
                                                              .orderDetails
                                                              .createdAt
                                                              .year
                                                              .toString())
                                                    ],
                                                  ),
                                                  Row(
                                                    children: [
                                                      Icon(
                                                        Icons.timer,
                                                        color: Colors.blue,
                                                      ),
                                                      SizedBox(
                                                        width: 4,
                                                      ),
                                                      Text(model
                                                              .orderDetailsResponse
                                                              .data
                                                              .orderDetails
                                                              .createdAt
                                                              .hour
                                                              .toString() +
                                                          ':' +
                                                          model
                                                              .orderDetailsResponse
                                                              .data
                                                              .orderDetails
                                                              .createdAt
                                                              .minute
                                                              .toString())
                                                    ],
                                                  ),
                                                  Row(
                                                    children: [
                                                      Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .all(5.0),
                                                        child: SvgPicture.asset(
                                                          'images/icon_money.svg',
                                                          height: 25.0,
                                                          width: 25.0,
                                                          color:
                                                              Colors.lightBlue,
                                                          allowDrawingOutsideViewBox:
                                                              true,
                                                        ),
                                                      ),
                                                      SizedBox(
                                                        width: 4,
                                                      ),
                                                      Text(model
                                                              .orderDetailsResponse
                                                              .data
                                                              .orderDetails
                                                              .subTotal
                                                              .inCurrentCurrency
                                                              .amount
                                                              .toString() +
                                                          ' ' +
                                                          model
                                                              .orderDetailsResponse
                                                              .data
                                                              .orderDetails
                                                              .subTotal
                                                              .inCurrentCurrency
                                                              .currency)
                                                    ],
                                                  )
                                                ],
                                              ),
                                            ),
                                            Divider(color: Colors.black),
                                            SizedBox(
                                              height: 4,
                                            ),
                                            Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: Row(
                                                children: [
                                                  Text(
                                                    AppLocalizations.of(context)
                                                        .translate('total'),
                                                    style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.bold),
                                                  ),
                                                  Spacer(),
                                                  model
                                                              .orderDetailsResponse
                                                              .data
                                                              .orderDetails
                                                              .discount
                                                              .inCurrentCurrency
                                                              .amount !=
                                                          0
                                                      ? Text(
                                                          model
                                                                  .orderDetailsResponse
                                                                  .data
                                                                  .orderDetails
                                                                  .total
                                                                  .inCurrentCurrency
                                                                  .amount
                                                                  .toString() +
                                                              ' ' +
                                                              model
                                                                  .orderDetailsResponse
                                                                  .data
                                                                  .orderDetails
                                                                  .total
                                                                  .inCurrentCurrency
                                                                  .currency,
                                                          style: TextStyle(
                                                              decoration:
                                                                  TextDecoration
                                                                      .lineThrough))
                                                      : Container(),
                                                  Text(model
                                                          .orderDetailsResponse
                                                          .data
                                                          .orderDetails
                                                          .subTotal
                                                          .inCurrentCurrency
                                                          .amount
                                                          .toString() +
                                                      ' ' +
                                                      model
                                                          .orderDetailsResponse
                                                          .data
                                                          .orderDetails
                                                          .subTotal
                                                          .inCurrentCurrency
                                                          .currency),
                                                ],
                                              ),
                                            ),
                                            Divider(color: Colors.black),
                                            // SizedBox(
                                            //   height: 4,
                                            // ),
                                            // Padding(
                                            //   padding:
                                            //       const EdgeInsets.all(8.0),
                                            //   child: Container(
                                            //     width: double.infinity,
                                            //     child: Text(
                                            //       AppLocalizations.of(context)
                                            //           .translate(
                                            //               'pricing_details'),
                                            //       style: TextStyle(
                                            //           fontWeight:
                                            //               FontWeight.bold),
                                            //       textAlign: TextAlign.start,
                                            //     ),
                                            //   ),
                                            // ),
                                            // Padding(
                                            //   padding:
                                            //       const EdgeInsets.symmetric(
                                            //           horizontal: 8.0),
                                            //   child: Row(
                                            //     children: [
                                            //       Text(AppLocalizations.of(
                                            //               context)
                                            //           .translate(
                                            //               'to_be_paid_now')),
                                            //       Spacer(),
                                            //       Text('(\$0)'),
                                            //     ],
                                            //   ),
                                            // ),
                                            // Padding(
                                            //   padding:
                                            //       const EdgeInsets.symmetric(
                                            //           horizontal: 8.0),
                                            //   child: Row(
                                            //     children: [
                                            //       Text(AppLocalizations.of(
                                            //               context)
                                            //           .translate(
                                            //               'to_be_paid_at_hotel')),
                                            //       Spacer(),
                                            //       Text('(\$192)',
                                            //           style: TextStyle(
                                            //               decoration:
                                            //                   TextDecoration
                                            //                       .lineThrough)),
                                            //       Text(' \$95'),
                                            //     ],
                                            //   ),
                                            // ),
                                            // Divider(color: Colors.black),
                                            SizedBox(
                                              height: 4,
                                            ),
                                            Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: Container(
                                                width: double.infinity,
                                                child: Text(
                                                  AppLocalizations.of(context)
                                                      .translate(
                                                          'additional_taxes_and_fees_for_information_only'),
                                                  style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold),
                                                  textAlign: TextAlign.start,
                                                ),
                                              ),
                                            ),
                                            Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 8.0),
                                              child: Row(
                                                children: [
                                                  Text(AppLocalizations.of(
                                                          context)
                                                      .translate('city_taxes')),
                                                  Spacer(),
                                                  Text('(' +
                                                      model
                                                          .orderDetailsResponse
                                                          .data
                                                          .orderDetails
                                                          .shippingCost
                                                          .inCurrentCurrency
                                                          .amount
                                                          .toString() +
                                                      ' ' +
                                                      model
                                                          .orderDetailsResponse
                                                          .data
                                                          .orderDetails
                                                          .shippingCost
                                                          .inCurrentCurrency
                                                          .currency +
                                                      ')'),
                                                ],
                                              ),
                                            ),
                                            Divider(color: Colors.black),
                                            SizedBox(
                                              height: 4,
                                            ),
                                            Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: Container(
                                                width: double.infinity,
                                                child: Text(
                                                  AppLocalizations.of(context)
                                                      .translate(
                                                          'terms_and_conditions'),
                                                  style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      color: Colors.red,
                                                      fontSize: 15),
                                                  textAlign: TextAlign.start,
                                                ),
                                              ),
                                            ),
                                            Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: Container(
                                                width: double.infinity,
                                                child: Text(
                                                  AppLocalizations.of(context)
                                                      .translate(
                                                          'pay_directly_at_app'),
                                                  style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold),
                                                  textAlign: TextAlign.start,
                                                ),
                                              ),
                                            ),
                                            Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: Container(
                                                width: double.infinity,
                                                child: Text(
                                                  'booked are displayed \nexclusive of taxes or surcharges applied by the\nhotelier. Any additional taxes should be paid directly\nat the app',
                                                  textAlign: TextAlign.start,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      SizedBox(
                                        height: 15,
                                      ),
                                      Container(
                                        child: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Row(
                                            children: [
                                              Text(
                                                AppLocalizations.of(context)
                                                    .translate('total'),
                                                style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 20),
                                              ),
                                              SizedBox(
                                                width: 4,
                                              ),
                                              Text(
                                                model
                                                        .orderDetailsResponse
                                                        .data
                                                        .orderDetails
                                                        .subTotal
                                                        .inCurrentCurrency
                                                        .amount
                                                        .toString() +
                                                    ' ' +
                                                    model
                                                        .orderDetailsResponse
                                                        .data
                                                        .orderDetails
                                                        .subTotal
                                                        .inCurrentCurrency
                                                        .currency,
                                                style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 20),
                                              ),
                                              Spacer(),
                                              RaisedButton(
                                                onPressed: () {
                                                  Navigator.push(
                                                      context,
                                                      new MaterialPageRoute(
                                                          builder: (context) =>
                                                              new CongratulationOrderDetailsScreen(model
                                                                  .orderDetailsResponse
                                                                  .data
                                                                  .orderDetails)));
                                                },
                                                color: Colors.lightBlue,
                                                child: Text(
                                                  AppLocalizations.of(context)
                                                      .translate('next'),
                                                  style: TextStyle(
                                                      color: Colors.white),
                                                ),
                                              )
                                            ],
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                ),
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
    });
  }

  void refreshScreen(OrdersViewModel model) {
    model.getOrderDetails(
        locator<AppLanguage>().appLocal.languageCode, widget.orderId);
  }
}
