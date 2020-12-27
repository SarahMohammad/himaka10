import 'dart:convert';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_pro/carousel_pro.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_svg/svg.dart';
import 'package:himaka/Models/cart.dart';
import 'package:himaka/Models/home_response.dart';
import 'package:himaka/Models/product_service_details_response.dart';
import 'package:himaka/Screens/add_product_service.dart';
import 'package:himaka/ViewModels/add_fav_view_model.dart';
import 'package:himaka/ViewModels/base_model.dart';
import 'package:himaka/ViewModels/filter_view_model.dart';
import 'package:himaka/ViewModels/home_view_model.dart';
import 'package:himaka/services/base_view.dart';
import 'package:himaka/utils/app_localizations.dart';
import 'package:himaka/utils/caching.dart';
import 'package:himaka/utils/show_toast.dart';
import 'package:smooth_star_rating/smooth_star_rating.dart';

import 'BannerDetailsScreen.dart';
import 'DetailsScreen/details_screen.dart';

class FirstHomeScreen extends StatefulWidget {
  final Function callback;
  @override
  _FirstHomeScreenState createState() => _FirstHomeScreenState();

  FirstHomeScreen(this.callback);
}

class _FirstHomeScreenState extends State<FirstHomeScreen> {
  List images = [];
  final _storage = FlutterSecureStorage();
  String key = 'cart';

  Widget imageCarousel(List images) {
    // print("hh" + images.toString());
    return Container(
      height: (MediaQuery.of(context).size.height / 2) - 120,
      child: Container(
        color: Colors.white,
        child: new Carousel(
          boxFit: BoxFit.cover,
//          options: CarouselOptions(
//            autoPlay: true,
//            aspectRatio: 2.0,
//            enlargeCenterPage: true,
//            enlargeStrategy: CenterPageEnlargeStrategy.height,
//          ),
          images: images.map((i) {
            return Builder(
              builder: (BuildContext context) {
                return Container(
                    width: MediaQuery.of(context).size.width,
                    margin: EdgeInsets.symmetric(horizontal: 5.0),
                    decoration: BoxDecoration(color: Colors.white),
                    child: GestureDetector(
                        child: Image.network(i.image, fit: BoxFit.fill),
                        onTap: () {
                          Navigator.push<Widget>(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  BannerDetailsScreen(i.id, widget.callback),
                            ),
                          );
                        }));
              },
            );
          }).toList(),
          autoplay: true,
          animationCurve: Curves.fastOutSlowIn,
          animationDuration: Duration(milliseconds: 500),
          dotSize: 7.0,
          indicatorBgPadding: 2.0,
          dotHorizontalPadding: 0.9,
          dotBgColor: Colors.transparent,
          dotIncreasedColor: Colors.lightBlueAccent,
        ),
      ),
    );
  }

  bool _firstTime = true;
  final _scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
//    deleteCart();
    var size = MediaQuery.of(context).size;

    /*24 is for notification bar on Android*/
    final double itemHeight =
        (size.height - kToolbarHeight - 20) / 2.1; //2.1 , 2.2 is the best
    final double itemWidth = size.width / 2;

    return BaseView<HomeViewModel>(
        onModelReady: (model) {
          refreshScreen(model);
        },
        builder:
            (context, model, child) => LayoutBuilder(builder:
                    (BuildContext context, BoxConstraints viewportConstraints) {
                  if (model.homeResponse != null && _firstTime) {
                    if (model.homeResponse.data.offers.length != 0) {
                      if (model.homeResponse.data.offers.length < 5) {
                        for (int i = 0;
                            i < model.homeResponse.data.offers.length;
                            i++) {
                          if (model.homeResponse.data.offers[i].image != null) {
                            images.add(model.homeResponse.data.offers[i]);
                          }
                        }
                      } else {
                        for (int i = 0; i < 5; i++) {
                          if (model.homeResponse.data.offers[i].image != null) {
                            images.add(model.homeResponse.data.offers[i]);
                          }
                        }
                      }
                    }
                    _firstTime = false;
                  }
                  return model.state == ViewState.Busy &&
                          model.productsList == null
                      ? Center(
                          child: CircularProgressIndicator(
                            backgroundColor: Colors.lightBlue,
                          ),
                        )
                      : model.productsList != null
                          ? Container(
                              child: NotificationListener<ScrollNotification>(
                                onNotification:
                                    (ScrollNotification notification) {
                                  if (!model.isLoading &&
                                      notification is ScrollEndNotification &&
                                      _scrollController.position.extentAfter ==
                                          0) {
                                    model.isLoading = true;
                                    refreshScreen(model);
                                  }

                                  return true;
                                },
                                child: ListView(
                                  controller: _scrollController,
                                  children: [
                                    new Column(
                                      children: <Widget>[
                                        //image carousel begins here
                                        imageCarousel(images),

                                        //padding widget
                                        new Padding(
                                          padding: const EdgeInsets.symmetric(
                                              vertical: 10.0, horizontal: 20),
                                          child: InkWell(
                                            onTap: () {
                                              Navigator.push(
                                                  context,
                                                  new MaterialPageRoute(
                                                      builder: (context) =>
                                                          new AddProductService()));
                                            },
                                            child: Container(
                                                decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          22.0),
                                                  color: Colors.white,
                                                  border: Border.all(
                                                    color: Colors.white,
                                                  ),
                                                  boxShadow: [
                                                    BoxShadow(
                                                      color: Colors.grey,
                                                      offset: Offset(
                                                          0.0, 1.0), //(x,y)
                                                      blurRadius: 6.0,
                                                    ),
                                                  ],
                                                ),
                                                alignment: Alignment.center,
                                                child: Padding(
                                                  padding: const EdgeInsets
                                                          .symmetric(
                                                      vertical: 10.0,
                                                      horizontal: 20),
                                                  child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .center,
                                                    children: [
                                                      Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .all(5.0),
                                                        child: SvgPicture.asset(
                                                          'images/plus.svg',
                                                          height: 20.0,
                                                          width: 20.0,
                                                          allowDrawingOutsideViewBox:
                                                              true,
                                                        ),
                                                      ),
                                                      SizedBox(
                                                        width: 5,
                                                      ),
                                                      Text(
                                                        AppLocalizations.of(
                                                                context)
                                                            .translate(
                                                                'add_product'),
                                                        style: TextStyle(
                                                            fontFamily:
                                                                'balance'),
                                                      ),
                                                    ],
                                                  ),
                                                )),
                                          ),
                                        ),

                                        //Horizontal list view begins here
//          HorizontalList(),

                                        //padding widget
                                        new Padding(
                                          padding: const EdgeInsets.symmetric(
                                              vertical: 8.0, horizontal: 25),
                                          child: Container(
                                              width: double.infinity,
                                              child: new Text(
                                                AppLocalizations.of(context)
                                                    .translate(
                                                        'recent_products'),
                                                style: TextStyle(
                                                    fontFamily: 'balance'),
                                              )),
                                        ),

                                        //grid view
//          Flexible(child: Products()),

                                        Padding(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 20),
                                          child: Column(
                                            children: [
                                              GridView.count(
                                                shrinkWrap: true,
                                                childAspectRatio:
                                                    (itemWidth / itemHeight),
                                                physics:
                                                    NeverScrollableScrollPhysics(),
                                                crossAxisCount: 2,
                                                padding: EdgeInsets.only(
                                                    top: 8,
                                                    left: 6,
                                                    right: 6,
                                                    bottom: 12),
                                                children: List.generate(
                                                    model.productsList.length,
                                                    (index) {
                                                  return Container(
                                                    child: Card(
                                                      clipBehavior:
                                                          Clip.antiAlias,
                                                      child: Container(
                                                        width: 160.0,
                                                        child: Card(
                                                          clipBehavior:
                                                              Clip.antiAlias,
                                                          child: InkWell(
                                                            onTap: () {
                                                              Navigator.push(
                                                                  context,
                                                                  new MaterialPageRoute(
                                                                      builder: (context) => new DetailsScreen(
                                                                          widget
                                                                              .callback,
                                                                          model
                                                                              .productsList[index]
                                                                              .id,
                                                                          1)));

//                                    Navigator.pushNamed(
//                                        context, '/products',
//                                        arguments: i);
                                                            },
                                                            child: Column(
                                                              crossAxisAlignment:
                                                                  CrossAxisAlignment
                                                                      .end,
                                                              children: <
                                                                  Widget>[
                                                                InkWell(
                                                                  child: Container(
                                                                      child: model.productsList[index].isWishlist
                                                                          ? SvgPicture.asset(
                                                                              'images/icon_fav_blue.svg',
                                                                              height: 18.0,
                                                                              width: 18.0,
                                                                              allowDrawingOutsideViewBox: true,
                                                                            )
                                                                          : SvgPicture.asset(
                                                                              'images/icon_fav_grey.svg',
                                                                              height: 18.0,
                                                                              width: 18.0,
                                                                              allowDrawingOutsideViewBox: true,
                                                                            )),
                                                                  onTap: () {
                                                                    model
                                                                            .productsList[
                                                                                index]
                                                                            .isWishlist
                                                                        ? model.addFav(
                                                                            AppLocalizations.of(context)
                                                                                .locale
                                                                                .languageCode,
                                                                            model
                                                                                .productsList[
                                                                                    index]
                                                                                .id,
                                                                            0)
                                                                        : model.addFav(
                                                                            AppLocalizations.of(context).locale.languageCode,
                                                                            model.productsList[index].id,
                                                                            1);
                                                                  },
                                                                ),
                                                                SizedBox(
                                                                  height: 120,
                                                                  child: Center(
                                                                    child:
                                                                        CachedNetworkImage(
                                                                      fit: BoxFit
                                                                          .fill,
                                                                      imageUrl: model.productsList[index].mainImage !=
                                                                              null
                                                                          ? model
                                                                              .productsList[index]
                                                                              .mainImage
                                                                          : "images/logo.png",
                                                                      placeholder: (context, url) => Center(
                                                                          child: model.serviceId == 1
                                                                              ? CircularProgressIndicator()
                                                                              : null),
                                                                      errorWidget: (context,
                                                                              url,
                                                                              error) =>
                                                                          new Icon(
                                                                              Icons.error),
                                                                    ),
                                                                  ),
                                                                ),
                                                                Align(
                                                                  alignment:
                                                                      Alignment
                                                                          .centerLeft,
                                                                  child: Column(
                                                                    crossAxisAlignment:
                                                                        CrossAxisAlignment
                                                                            .start,
                                                                    children: [
                                                                      model.productsList[index].name !=
                                                                              null
                                                                          ? Text(
                                                                              model.productsList[index].name,
                                                                              maxLines: 1,
                                                                              overflow: TextOverflow.ellipsis,
                                                                              style: TextStyle(color: Colors.black, fontSize: 14, fontWeight: FontWeight.bold, fontFamily: 'balance'),
                                                                            )
                                                                          : Container(),
                                                                      Text(
                                                                          '#' +
                                                                              model.productsList[index].id
                                                                                  .toString(),
                                                                          style: TextStyle(
                                                                              color: Colors.grey,
                                                                              fontFamily: 'roboto')),
                                                                      Container(
                                                                        child: Row(
                                                                            mainAxisAlignment:
                                                                                MainAxisAlignment.spaceBetween,
                                                                            children: [
                                                                              Container(
                                                                                width: (MediaQuery.of(context).size.width / 4),
                                                                                child: RichText(
                                                                                  maxLines: 1,
                                                                                  overflow: TextOverflow.ellipsis,
                                                                                  text: new TextSpan(
                                                                                    text: (double.parse(model.productsList[index].price.amount).toInt()).toString() + ' ' + model.productsList[index].price.currency,
                                                                                    style: new TextStyle(decoration: model.productsList[index].price.amount != model.productsList[index].sellingPrice.amount ? TextDecoration.lineThrough : TextDecoration.none, fontFamily: 'roboto', color: Colors.black),
                                                                                    children: <TextSpan>[
                                                                                      model.productsList[index].price.amount != model.productsList[index].sellingPrice.amount
                                                                                          ? new TextSpan(
                                                                                              text: (double.parse(model.productsList[index].sellingPrice.amount).toInt()).toString() + ' ' + model.productsList[index].price.currency,
                                                                                              style: new TextStyle(
                                                                                                fontFamily: 'roboto',
                                                                                                color: Colors.black,
                                                                                                decoration: TextDecoration.none,
                                                                                              ))
                                                                                          : TextSpan(text: ""),
                                                                                    ],
                                                                                  ),
                                                                                ),
                                                                              ),
                                                                              model.productsList[index].price.amount != model.productsList[index].sellingPrice.amount
                                                                                  ? model.productsList[index].specialPricePercent != null
                                                                                      ? Align(
                                                                                          alignment: Alignment.centerRight,
                                                                                          child: Container(
                                                                                            width: 35,
                                                                                            height: 35,
                                                                                            decoration: BoxDecoration(
                                                                                              border: Border.all(width: 3, color: Colors.orange),
                                                                                              borderRadius: BorderRadius.all(
                                                                                                Radius.circular(600),
                                                                                              ),
                                                                                              color: Colors.orange,
                                                                                            ),
                                                                                            child: Center(
                                                                                                child: model.productsList[index].price.amount != model.productsList[index].sellingPrice.amount
                                                                                                    ? Text(
                                                                                                        model.productsList[index].specialPricePercent.toString() + ' %',
                                                                                                        style: TextStyle(color: Colors.white, fontSize: 10, fontWeight: FontWeight.bold, fontFamily: 'roboto'),
                                                                                                        overflow: TextOverflow.ellipsis,
                                                                                                      )
                                                                                                    : Text(
                                                                                                        model.productsList[index].specialPricePercent.toString() + ' %',
                                                                                                        style: TextStyle(color: Colors.white, fontSize: 10, fontWeight: FontWeight.bold, fontFamily: 'roboto'),
                                                                                                        overflow: TextOverflow.ellipsis,
                                                                                                      )),
                                                                                          ),
                                                                                        )
                                                                                      : Align(
                                                                                          alignment: Alignment.centerRight,
                                                                                          child: Container(
                                                                                            width: 35,
                                                                                            height: 35,
                                                                                            decoration: BoxDecoration(
                                                                                              border: Border.all(width: 3, color: Colors.white),
                                                                                              borderRadius: BorderRadius.all(
                                                                                                Radius.circular(600),
                                                                                              ),
                                                                                              color: Colors.white,
                                                                                            ),
                                                                                            child: Center(
                                                                                                child: Text(
                                                                                              '77%',
                                                                                              style: TextStyle(color: Colors.white, fontSize: 10, fontWeight: FontWeight.bold),
                                                                                            )),
                                                                                          ),
                                                                                        )
                                                                                  : Align(
                                                                                      alignment: Alignment.centerRight,
                                                                                      child: Container(
                                                                                        width: 35,
                                                                                        height: 35,
                                                                                        decoration: BoxDecoration(
                                                                                          border: Border.all(width: 3, color: Colors.white),
                                                                                          borderRadius: BorderRadius.all(
                                                                                            Radius.circular(600),
                                                                                          ),
                                                                                          color: Colors.white,
                                                                                        ),
                                                                                        child: Center(
                                                                                            child: Text(
                                                                                          '77%',
                                                                                          style: TextStyle(color: Colors.white, fontSize: 10, fontWeight: FontWeight.bold),
                                                                                        )),
                                                                                      ),
                                                                                    )
                                                                            ]),
                                                                      ),
                                                                    ],
                                                                  ),
                                                                ),
                                                                Align(
                                                                  alignment:
                                                                      Alignment
                                                                          .centerLeft,
                                                                  child: SmoothStarRating(
                                                                      allowHalfRating:
                                                                          false,
                                                                      onRated:
                                                                          (value) {},
                                                                      starCount:
                                                                          5,
                                                                      rating: model.productsList[index].ratingPercent ==
                                                                              null
                                                                          ? 0
                                                                          : (model
                                                                              .productsList[
                                                                                  index]
                                                                              .ratingPercent
                                                                              .toDouble()),
                                                                      size:
                                                                          15.0,
                                                                      isReadOnly:
                                                                          true,
                                                                      color: Colors
                                                                          .deepOrangeAccent,
                                                                      borderColor:
                                                                          Colors
                                                                              .deepOrangeAccent,
                                                                      spacing:
                                                                          0.0),
                                                                ),
                                                                SizedBox(
                                                                  height: MediaQuery.of(
                                                                              context)
                                                                          .size
                                                                          .height /
                                                                      182,
                                                                ),
                                                                Expanded(
                                                                  child:
                                                                      InkWell(
                                                                    onTap: () {
                                                                      Item item = new Item(
                                                                          id: model
                                                                              .productsList[
                                                                                  index]
                                                                              .id,
                                                                          name: model
                                                                              .productsList[
                                                                                  index]
                                                                              .name,
                                                                          userId: model
                                                                              .productsList[
                                                                                  index]
                                                                              .userId,
                                                                          brandId: model
                                                                              .productsList[
                                                                                  index]
                                                                              .brandId,
                                                                          slug: model
                                                                              .productsList[
                                                                                  index]
                                                                              .slug,
                                                                          isWishlist: model
                                                                              .productsList[
                                                                                  index]
                                                                              .isWishlist,
                                                                          inStock: model
                                                                              .productsList[
                                                                                  index]
                                                                              .inStock,
                                                                          ratingPercent: model
                                                                              .productsList[
                                                                                  index]
                                                                              .ratingPercent,
                                                                          price: Price(
                                                                              amount: model.productsList[index].price.amount,
                                                                              formatted: model.productsList[index].price.formatted,
                                                                              currency: model.productsList[index].price.currency),
                                                                          oldPrice: model.productsList[index].oldPrice,
                                                                          newPrice: model.productsList[index].newPrice,
                                                                          count: 1,
                                                                          baseImage: new BaseImage(path: model.productsList[index].mainImage));

                                                                      _addToCart(
                                                                          item,
                                                                          context);
                                                                    },
                                                                    child:
                                                                        Container(
                                                                      width: double
                                                                          .infinity,
                                                                      color: Color(
                                                                          0xff45afe2),
                                                                      child: Center(
                                                                          child: Row(
                                                                        mainAxisAlignment:
                                                                            MainAxisAlignment.center,
                                                                        children: [
                                                                          Text(
                                                                            AppLocalizations.of(context).translate('add_to_cart'),
                                                                            style:
                                                                                TextStyle(color: Colors.white, fontFamily: 'balance'),
                                                                          ),
                                                                          SizedBox(
                                                                            width:
                                                                                6,
                                                                          ),
                                                                          SvgPicture
                                                                              .asset(
                                                                            'images/icon_cart_red.svg',
                                                                            height:
                                                                                15.0,
                                                                            width:
                                                                                15.0,
                                                                            allowDrawingOutsideViewBox:
                                                                                true,
                                                                          )
                                                                        ],
                                                                      )),
                                                                    ),
                                                                  ),
                                                                )
                                                              ],
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  );
                                                }),
                                              ),
                                              Container(
                                                height:
                                                    model.isLoading ? 50.0 : 0,
                                                child: Center(
                                                  child:
                                                      new CircularProgressIndicator(),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    )
                                  ],
                                ),
                              ),
                            )
                          : Center(
                              child: Text('empty'),
                            );
                }));
  }

  void refreshScreen(HomeViewModel model) {
    model.getHome(AppLocalizations.of(context)
        .locale
        .languageCode
        .toLowerCase()
        .toString());
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
        widget.callback(cashedCart.items.length);
      } else {
        showToast(AppLocalizations.of(context).translate('already_in_cart'),
            Colors.green);
        // cashedCart.items[index] = item;
      }
    } else {
      List<Item> items = new List<Item>();
      items.add(item);
      cashedCart = new Cart(items: items);
      widget.callback(cashedCart.items.length);
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
