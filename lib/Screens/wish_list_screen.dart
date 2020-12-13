import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_svg/svg.dart';
import 'package:himaka/Models/cart.dart';
import 'package:himaka/Models/product_service_details_response.dart';
import 'package:himaka/ViewModels/base_model.dart';
import 'package:himaka/ViewModels/wish_list_view_model.dart';
import 'package:himaka/services/base_view.dart';
import 'package:himaka/utils/show_toast.dart';
import 'package:smooth_star_rating/smooth_star_rating.dart';

import '../utils/app_localizations.dart';

class WishListScreen extends StatefulWidget {
  @override
  _WishListScreenState createState() => _WishListScreenState();
}

class _WishListScreenState extends State<WishListScreen> {
  final _storage = FlutterSecureStorage();
  String key = 'cart';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          iconTheme: IconThemeData(
            color: Colors.grey[900], //change your color here
          ),
          title: Text(
            AppLocalizations.of(context).translate('my_wishlist'),
            style: TextStyle(color: Colors.grey[900]),
          ),
          leading: InkWell(
            child: Icon(Icons.arrow_back_ios),
            onTap: () {
              Navigator.of(context).pop();
            },
          ),
          backgroundColor: Colors.transparent,
          elevation: 0.0,
        ),
        body: BaseView<WishListViewModel>(
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
                      : (model.wishListResponse != null &&
                              model.wishListResponse.data.wishlist.length > 0)
                          ? ListView.separated(
                              separatorBuilder: (context, index) => SizedBox(
                                height: 5,
                              ),
                              itemCount:
                                  model.wishListResponse.data.wishlist.length,
                              itemBuilder: (context, index) => Padding(
                                padding: EdgeInsets.all(1.0),
                                child: InkWell(
                                  onTap: () {},
                                  child: Card(
                                    color: Colors.white,
                                    elevation: 3.0,
                                    child: Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 9.0, vertical: 1),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          children: <Widget>[
                                            Image.network(
                                              model
                                                  .wishListResponse
                                                  .data
                                                  .wishlist[index]
                                                  .baseImage
                                                  .path,
                                              width: 80,
                                              height: 80,
                                            ),
                                            SizedBox(
                                              width: 20,
                                            ),
                                            Expanded(
                                              child: Container(
                                                child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: <Widget>[
                                                    Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceBetween,
                                                      children: [
                                                        Container(
                                                          width: MediaQuery.of(
                                                                      context)
                                                                  .size
                                                                  .width /
                                                              1.8,
                                                          child: Text(
                                                            model
                                                                .wishListResponse
                                                                .data
                                                                .wishlist[index]
                                                                .name,
                                                            overflow:
                                                                TextOverflow
                                                                    .ellipsis,
                                                            maxLines: 1,
                                                            style: TextStyle(
                                                                fontSize: 16),
                                                          ),
                                                        ),
                                                        InkWell(
                                                          child:
                                                              SvgPicture.asset(
                                                            'images/icon_fav_blue.svg',
                                                            height: 25.0,
                                                            width: 25.0,
                                                            allowDrawingOutsideViewBox:
                                                                true,
                                                          ),
                                                          onTap: () {
                                                            model.addFav(
                                                                AppLocalizations.of(
                                                                        context)
                                                                    .locale
                                                                    .languageCode,
                                                                model
                                                                    .wishListResponse
                                                                    .data
                                                                    .wishlist[
                                                                        index]
                                                                    .id,
                                                                0);
                                                          },
                                                        )
                                                      ],
                                                    ),
                                                    SizedBox(
                                                      height: 5,
                                                    ),
                                                    Text(
                                                      "# " +
                                                          model
                                                              .wishListResponse
                                                              .data
                                                              .wishlist[index]
                                                              .id
                                                              .toString(),
                                                      style: TextStyle(
                                                          fontSize: 12,
                                                          color:
                                                              Colors.grey[400]),
                                                    ),
                                                    SizedBox(
                                                      height: 5,
                                                    ),
                                                    Row(
                                                      children: <Widget>[
                                                        Text(
                                                          model
                                                              .wishListResponse
                                                              .data
                                                              .wishlist[index]
                                                              .price
                                                              .amount
                                                              .toString(),
                                                          style: TextStyle(
                                                              color:
                                                                  Colors.black,
                                                              decoration:
                                                                  TextDecoration
                                                                      .lineThrough),
                                                        ),
                                                        SizedBox(
                                                          width: 8,
                                                        ),
                                                        Text(
                                                          model
                                                              .wishListResponse
                                                              .data
                                                              .wishlist[index]
                                                              .sellingPrice
                                                              .amount
                                                              .toString(),
                                                          style: TextStyle(
                                                              color:
                                                                  Colors.black),
                                                        ),
                                                      ],
                                                    ),
                                                    SizedBox(
                                                      height: 10,
                                                    ),
                                                    Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceBetween,
                                                      children: [
                                                        SmoothStarRating(
                                                            allowHalfRating:
                                                                false,
                                                            onRated: (value) {
//                                            _rating = value;
                                                            },
                                                            starCount: 5,
                                                            rating: 4,
                                                            size: 15.0,
                                                            isReadOnly: true,
                                                            color: Colors
                                                                .deepOrangeAccent,
                                                            borderColor: Colors
                                                                .deepOrangeAccent,
                                                            spacing: 0.0),
                                                        SvgPicture.asset(
                                                          'images/icon_pricetag.svg',
                                                          height: 25.0,
                                                          width: 25.0,
                                                          allowDrawingOutsideViewBox:
                                                              true,
                                                        )
                                                      ],
                                                    ),
                                                    Divider(),
                                                    SizedBox(
                                                      height: 3,
                                                    ),
                                                    Center(
                                                      child: Container(
                                                        width: MediaQuery.of(
                                                                        context)
                                                                    .size
                                                                    .width /
                                                                2 -
                                                            30,
                                                        child: FlatButton(
                                                          color:
                                                              Colors.lightBlue,
                                                          onPressed: () {
                                                            //add to cart
                                                            Item item = new Item(
                                                                id: model
                                                                    .wishListResponse
                                                                    .data
                                                                    .wishlist[
                                                                        index]
                                                                    .id,
                                                                name: model
                                                                    .wishListResponse
                                                                    .data
                                                                    .wishlist[
                                                                        index]
                                                                    .name,
                                                                userId: model
                                                                    .wishListResponse
                                                                    .data
                                                                    .wishlist[
                                                                        index]
                                                                    .userId,
                                                                brandId: model
                                                                    .wishListResponse
                                                                    .data
                                                                    .wishlist[
                                                                        index]
                                                                    .brandId,
                                                                slug: model
                                                                    .wishListResponse
                                                                    .data
                                                                    .wishlist[
                                                                        index]
                                                                    .slug,
                                                                isWishlist:
                                                                    true,
                                                                inStock: model
                                                                    .wishListResponse
                                                                    .data
                                                                    .wishlist[
                                                                        index]
                                                                    .inStock,
                                                                ratingPercent: model
                                                                    .wishListResponse
                                                                    .data
                                                                    .wishlist[
                                                                        index]
                                                                    .ratingPercent,
                                                                price: new Price(
                                                                    amount: model
                                                                        .wishListResponse
                                                                        .data
                                                                        .wishlist[
                                                                            index]
                                                                        .price
                                                                        .amount,
                                                                    formatted:
                                                                        model.wishListResponse.data.wishlist[index].price.formatted,
                                                                    currency: model.wishListResponse.data.wishlist[index].price.currency),
                                                                oldPrice: model.wishListResponse.data.wishlist[index].price.amount,
                                                                newPrice: model.wishListResponse.data.wishlist[index].sellingPrice.amount,
                                                                count: 1,
                                                                baseImage: new BaseImage(path: model.wishListResponse.data.wishlist[index].baseImage.path));

                                                            _addToCart(
                                                                item, context);
                                                          },
                                                          child: Row(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .center,
                                                            children: [
                                                              Text(
                                                                AppLocalizations.of(
                                                                        context)
                                                                    .translate(
                                                                        'buy_now'),
                                                                style: TextStyle(
                                                                    color: Colors
                                                                        .white),
                                                              ),
                                                              SizedBox(
                                                                width: 5,
                                                              ),
                                                              SvgPicture.asset(
                                                                'images/icon_cart_red.svg',
                                                                height: 20.0,
                                                                width: 20.0,
                                                                allowDrawingOutsideViewBox:
                                                                    true,
                                                              )
                                                            ],
                                                          ),
                                                        ),
                                                      ),
                                                    )
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ],
                                        )),
                                  ),
                                ),
                              ),
                            )
                          : model.wishListResponse == null
                              ? Container(
                                  child: Center(
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: <Widget>[
                                        Text(
                                          AppLocalizations.of(context)
                                              .translate('network_failed'),
                                        ),
                                        RaisedButton(
                                          onPressed: () {
                                            refreshScreen(model);
                                          },
                                          color:
                                              Color.fromRGBO(235, 85, 85, 100),
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
                                )
                              : Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Expanded(
                                      child: Stack(
                                        children: [
                                          Align(
                                            alignment: Alignment.center,
                                            child: SvgPicture.asset(
                                              'images/no_fav.svg',
                                              // height: 300.0,
                                              allowDrawingOutsideViewBox: true,
                                            ),
                                          ),
                                          Align(
                                            alignment: Alignment.center,
                                            child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                Text(
                                                  AppLocalizations.of(context)
                                                      .translate(
                                                          'empty_wishlist_msg'),
                                                  textAlign: TextAlign.center,
                                                  style: TextStyle(
                                                      fontSize: 20,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      color: Color(0xff555555)),
                                                ),
                                                SizedBox(
                                                  height: 2,
                                                ),
                                                Text(
                                                  AppLocalizations.of(context)
                                                      .translate(
                                                          'empty_wishlist_2_msg'),
                                                  textAlign: TextAlign.center,
                                                  style: TextStyle(
                                                      color: Color(0xffa2a2a2),
                                                      fontSize: 18),
                                                ),
                                              ],
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                  ],
                                );
                })));
  }

  void refreshScreen(WishListViewModel model) {
    model.getWishList(AppLocalizations.of(context).locale.languageCode);
  }

  void _addToCart(item, context) async {
    Cart cashedCart = await readFromCash();
    if (cashedCart != null) {
      int index = -1;
      for (int i = 0; i < cashedCart.items.length; i++) {
        if (cashedCart.items[i].id == item.id) {
          index = i;
          break;
        }
      }
      if (index == -1) {
        showToast(AppLocalizations.of(context).translate('added_successfully'),
            Colors.green);
        cashedCart.items.add(item);
      } else {
        showToast(AppLocalizations.of(context).translate('already_in_cart'),
            Colors.green);
        // cashedCart.items[index] = item;
      }
    } else {
      List<Item> items = new List<Item>();
      items.add(item);
      cashedCart = new Cart(items: items);
      showToast(AppLocalizations.of(context).translate('added_successfully'),
          Colors.green);
    }
    await _storage.write(key: key, value: json.encode(cashedCart));
  }

  Future<Cart> readFromCash() async {
    String value = await _storage.read(key: "cart");
    if (value != null) return Cart.fromJson(json.decode(value));
    return null;
  }
}
