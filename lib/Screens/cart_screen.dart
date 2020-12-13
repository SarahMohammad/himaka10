import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_svg/svg.dart';
import 'package:himaka/Models/cart.dart';
import 'package:himaka/Models/product_service_details_response.dart';
import 'package:himaka/Screens/cart_item.dart';
import 'package:himaka/utils/app_localizations.dart';
import 'package:himaka/utils/caching.dart';
import 'package:himaka/utils/show_toast.dart';

class CartScreen extends StatefulWidget {
  @override
  _CartScreenState createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  final _storage = FlutterSecureStorage();
  List<Item> items;
  final _scaffoldKey = new GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    // deleteCart();
    readFromCash();
  }

  callback(newItems) {
    setState(() {
      items = newItems;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          leading: InkWell(
            child: Icon(Icons.arrow_back_ios),
            onTap: () {
              Navigator.of(context).pop();
            },
          ),
          title: Text(
            AppLocalizations.of(context).translate('my_cart'),
            style: TextStyle(color: Colors.grey[900]),
          ),
          elevation: 0.0,
          iconTheme: IconThemeData(
            color: Colors.grey[900], //change your color here
          ),
          backgroundColor: Color(0xFFf5f5f5),
        ),
        backgroundColor: Color(0xFFf5f5f5),
        body: (items != null && items.length != 0)
            ? LayoutBuilder(
                builder:
                    (BuildContext context, BoxConstraints viewportConstraints) {
                  return SingleChildScrollView(
                    child: ConstrainedBox(
                      constraints: BoxConstraints(
                        minHeight: viewportConstraints.minHeight,
                      ),
                      child: Column(
                        children: [
                          ListView.separated(
                            separatorBuilder: (context, index) => SizedBox(
                              height: 5,
                            ),
                            key: _scaffoldKey,
                            itemCount: items.length,
                            shrinkWrap: true,
                            physics: NeverScrollableScrollPhysics(),
                            itemBuilder: (context, index) => Padding(
                              padding: EdgeInsets.all(1.0),
                              child: new CartItem(items[index], callback,
                                  removeListItem, index),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(5.0),
                                color: Colors.white,
                                border: Border.all(
                                  color: Colors.white,
                                ),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.grey,
                                    offset: Offset(0.0, 1.0), //(x,y)
                                    blurRadius: 6.0,
                                  ),
                                ],
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(10.0),
                                child: Column(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.all(2.0),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            AppLocalizations.of(context)
                                                .translate('sub_total'),
                                            style: TextStyle(
                                                color: Colors.black,
                                                fontWeight: FontWeight.bold),
                                          ),
                                          Text(getTotalCost().toString() +
                                              items[0].price.currency)
                                        ],
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 8.0),
                                      child: Container(
                                        height: 1.0,
                                        // width: 30.0,
                                        color: Colors.grey,
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(2.0),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            AppLocalizations.of(context)
                                                .translate('total'),
                                            style: TextStyle(
                                                color: Colors.black,
                                                fontWeight: FontWeight.bold),
                                          ),
                                          Text(
                                            getTotalCost().toString() +
                                                items[0].price.currency,
                                            style: TextStyle(
                                                color: Colors.blue,
                                                fontWeight: FontWeight.bold),
                                          )
                                        ],
                                      ),
                                    ),
                                    Container(
                                      width: double.infinity,
                                      child: Padding(
                                        padding: const EdgeInsets.symmetric(
                                            vertical: 4.0, horizontal: 8),
                                        child: RaisedButton(
                                          child: Text(
                                            AppLocalizations.of(context)
                                                .translate(
                                                    'complete_your_order'),
                                            style:
                                                TextStyle(color: Colors.white),
                                          ),
                                          onPressed: () {
                                            showToast(
                                                AppLocalizations.of(context)
                                                    .translate('in_progress'),
                                                Colors.red);
                                          },
                                          color: Colors.lightBlueAccent,
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(5.0),
                                          ),
                                        ),
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
                  );
                },
              )
            : Center(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SvgPicture.asset(
                        'images/no_items_cart.svg',
                        height: 300.0,
                        width: 200.0,
                        allowDrawingOutsideViewBox: true,
                      ),
                      Text(
                        AppLocalizations.of(context)
                            .translate('empty_cart_msg'),
                        style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Color(0xff555555)),
                      ),
                      SizedBox(
                        height: 4,
                      ),
                      Text(
                        AppLocalizations.of(context)
                            .translate('empty_cart_s_msg'),
                        style:
                            TextStyle(color: Color(0xffa2a2a2), fontSize: 18),
                      ),
                      Container(
                        width: double.infinity,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: 32.0, horizontal: 32),
                          child: RaisedButton(
                            child: Padding(
                              padding: const EdgeInsets.all(16.0),
                              child: Text(
                                AppLocalizations.of(context)
                                    .translate('continue_shopping'),
                                style: TextStyle(color: Colors.white),
                              ),
                            ),
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                            color: Color(0xff45afe2),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(5.0),
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ));
  }

  removeListItem(int index) {
    setState(() {
      if (items != null) {
        items.removeAt(index);
        _updateItem();
      }
    });
  }

  void _updateItem() async {
    String value = await _storage.read(key: "cart");
    if (value != null) {
      Cart cashedCart = Cart.fromJson(json.decode(value));
      if (cashedCart != null) {
        cashedCart.items.clear();
        cashedCart.items = items;
        await _storage.write(key: "cart", value: json.encode(cashedCart));
      }
    }
  }

  double getTotalCost() {
    double _totalCost = 0.0;
    for (int i = 0; i < items.length; i++) {
      _totalCost += (((items[i].newPrice is String
              ? double.parse(items[i].newPrice)
              : items[i].newPrice.toDouble()) *
          items[i].count));
    }
    return _totalCost;
  }

  readFromCash() async {
    String value = await _storage.read(key: "cart");
    if (value != null) {
      Cart cashedItems = Cart.fromJson(json.decode(value));
      if (cashedItems != null) {
        setState(() {
          items = cashedItems.items;
        });
      }
    }
  }
}
