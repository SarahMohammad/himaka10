import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:himaka/Screens/order_details.dart';
import 'package:himaka/ViewModels/base_model.dart';
import 'package:himaka/ViewModels/orders_view_model.dart';
import 'package:himaka/services/base_view.dart';
import 'package:himaka/services/locator.dart';
import 'package:himaka/utils/AppLanguage.dart';
import 'package:himaka/utils/app_localizations.dart';

class BookingsScreen extends StatefulWidget {
  final int pathId;

  BookingsScreen(this.pathId);

  @override
  _BookingsScreenState createState() => _BookingsScreenState();
}

class _BookingsScreenState extends State<BookingsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(
          color: Colors.grey[900], //change your color here
        ),
        centerTitle: true,
        title: Text(
          AppLocalizations.of(context).translate(widget.pathId == 1
              ? 'my_bookings'
              : widget.pathId == 2
                  ? 'my_orders'
                      : 'order_client'),
          style: TextStyle(color: Colors.black),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0.0,
      ),
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
                    : model.ordersResponse != null
                        ? Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                                Padding(
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 6),
                                  child: Container(
                                    width: MediaQuery.of(context).size.width,
                                    color: Colors.lightBlueAccent,
                                    child: Row(
                                      children: [
                                        widget.pathId == 1
                                            ? Icon(
                                                Icons.markunread_mailbox,
                                                color: Colors.white,
                                              )
                                            : widget.pathId == 2
                                                ? SvgPicture.asset(
                                                    'images/personal_wallet_order.svg',
                                                    height: 25.0,
                                                    width: 25.0,
                                                    allowDrawingOutsideViewBox:
                                                        true,
                                                    color: Colors.white,
                                                  )
                                                    : SvgPicture.asset(
                                                        'images/or_client.svg',
                                                        height: 25.0,
                                                        width: 25.0,
                                                        allowDrawingOutsideViewBox:
                                                            true,
                                                        color: Colors.white,
                                                      ),
                                        SizedBox(
                                          width: 15,
                                        ),
                                        Text(
                                          AppLocalizations.of(context)
                                              .translate(widget.pathId == 1
                                                  ? 'my_bookings'
                                                  : widget.pathId == 2
                                                      ? 'my_orders'
                                                          : 'order_client'),
                                          style: TextStyle(color: Colors.white),
                                        ),
                                      ],
                                    ),
                                    padding: EdgeInsets.all(20),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 15.0, vertical: 6),
                                  child: Container(
                                      width: MediaQuery.of(context).size.width,
                                      child: Text(model
                                              .ordersResponse.data.orders.length
                                              .toString() +
                                          AppLocalizations.of(context)
                                              .translate('items'))),
                                ),
                                Expanded(
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: ListView.builder(
                                        itemCount: model
                                            .ordersResponse.data.orders.length,
                                        itemBuilder:
                                            (BuildContext context, int index) {
                                          return InkWell(
                                            child: Card(
                                              child: ListTile(
                                                title: Text(AppLocalizations.of(
                                                            context)
                                                        .translate('order') +
                                                    ' ' +
                                                    model.ordersResponse.data
                                                        .orders[index].id
                                                        .toString()),
                                                subtitle: Row(
                                                  children: [
                                                    Expanded(
                                                        child: Text(
                                                      AppLocalizations.of(
                                                              context)
                                                          .translate(
                                                              'view_order'),
                                                      style: TextStyle(
                                                          color: Colors.red),
                                                    )),
                                                    Icon(
                                                      Icons.brightness_1,
                                                      size: 10,
                                                      color: Colors.green,
                                                    ),
                                                    SizedBox(
                                                      width: 4,
                                                    ),
                                                    Text(model
                                                        .ordersResponse
                                                        .data
                                                        .orders[index]
                                                        .status)
                                                  ],
                                                ),
                                                // trailing: Icon(Icons.phone),
                                              ),
                                            ),
                                            onTap: () {
                                              Navigator.push(
                                                  context,
                                                  new MaterialPageRoute(
                                                      builder: (context) =>
                                                          new OrderDetailsScreen(
                                                              model
                                                                  .ordersResponse
                                                                  .data
                                                                  .orders[index]
                                                                  .id)));
                                            },
                                          );
                                        }),
                                  ),
                                )
                              ])
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

  void refreshScreen(OrdersViewModel model) {
    model.getOrders(locator<AppLanguage>().appLocal.languageCode,widget.pathId);
  }
}
