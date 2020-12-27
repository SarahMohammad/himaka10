import 'dart:convert';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_svg/svg.dart';
import 'package:himaka/Models/cart.dart';
import 'package:himaka/Models/product_service_details_response.dart';
import 'package:himaka/ViewModels/banner_products_view_model.dart';
import 'package:himaka/ViewModels/base_model.dart';
import 'package:himaka/services/base_view.dart';
import 'package:himaka/utils/app_localizations.dart';
import 'package:himaka/utils/show_toast.dart';
import 'package:smooth_star_rating/smooth_star_rating.dart';

import 'DetailsScreen/details_screen.dart';

class BannerDetailsScreen extends StatefulWidget {
  int i;
  Function callback;

  @override
  _BannerDetailsScreenState createState() => _BannerDetailsScreenState();

  BannerDetailsScreen(this.i, this.callback);
}

class _BannerDetailsScreenState extends State<BannerDetailsScreen> {
  final _storage = FlutterSecureStorage();
  String key = 'cart';
  @override
  Widget build(BuildContext context) {
//    showToast(widget.i.toString(), Colors.red);
    var size = MediaQuery.of(context).size;

    /*24 is for notification bar on Android*/
    final double itemHeight =
        (size.height - kToolbarHeight - 20) / 2.1; //2.1 , 2.2 is the best
    final double itemWidth = size.width / 2;

    return BaseView<BannerProductsViewModel>(
        onModelReady: (model) {
          refreshScreen(model);
        },
        builder: (context, model, child) => LayoutBuilder(builder:
                (BuildContext context, BoxConstraints viewportConstraints) {
              return Scaffold(
                  appBar: AppBar(
                    backgroundColor: Colors.transparent,
                    elevation: 0.0,
                    centerTitle: true,
                    title: Text(
                      AppLocalizations.of(context).translate('offers'),
                      style: TextStyle(color: Colors.grey[900]),
                    ),
                    leading: IconButton(
                      icon: Icon(Icons.arrow_back_ios, color: Colors.black),
                      onPressed: () => Navigator.of(context).pop(),
                    ),
                  ),
                  body:
                      model.state == ViewState.Busy &&
                              model.bannerProductsResponse == null
                          ? Center(
                              child: CircularProgressIndicator(
                                backgroundColor: Colors.lightBlue,
                              ),
                            )
                          : model.bannerProductsResponse != null
                              ? GridView.count(
//          shrinkWrap: true,
                                  childAspectRatio: (itemWidth / itemHeight),
//          physics: NeverScrollableScrollPhysics(),
                                  crossAxisCount: 2,
                                  padding: EdgeInsets.only(
                                      top: 8, left: 6, right: 6, bottom: 12),
                                  children: List.generate(
                                      model.bannerProductsResponse.data.products
                                          .length, (index) {
                                    print('bi ' +
                                        model.bannerProductsResponse.data
                                            .products[index].baseImage.length
                                            .toString());
                                    return Container(
                                      child: Card(
                                        clipBehavior: Clip.antiAlias,
                                        child: InkWell(
                                          onTap: () {
                                            print('Card tapped.');
                                          },
                                          child: Container(
                                            width: 160.0,
                                            child: Card(
                                              clipBehavior: Clip.antiAlias,
                                              child: InkWell(
                                                onTap: () {
                                                  Navigator.push(
                                                      context,
                                                      new MaterialPageRoute(
                                                          builder: (context) =>
                                                              new DetailsScreen(
                                                                  widget
                                                                      .callback,
                                                                  model
                                                                      .bannerProductsResponse
                                                                      .data
                                                                      .products[
                                                                          index]
                                                                      .id,
                                                                  1)));

//                                                      Navigator.pushNamed(
//                                                          context, '/products',
//                                                          arguments: i);
                                                },
                                                child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.end,
                                                  children: <Widget>[
                                                    SvgPicture.asset(
                                                      'images/icon_fav_blue.svg',
                                                      height: 18.0,
                                                      width: 18.0,
                                                      color: Colors.white,
                                                      allowDrawingOutsideViewBox:
                                                          true,
                                                    ),
//                                                InkWell(
//                                                  child: Container(
//                                                      child: model
//                                                              .bannerProductsResponse
//                                                              .data
//                                                              .products[index]
//                                                              .isWishlist
//                                                          ? SvgPicture.asset(
//                                                              'images/icon_fav_blue.svg',
//                                                              height: 18.0,
//                                                              width: 18.0,
//                                                              allowDrawingOutsideViewBox:
//                                                                  true,
//                                                            )
//                                                          : SvgPicture.asset(
//                                                              'images/icon_fav_grey.svg',
//                                                              height: 18.0,
//                                                              width: 18.0,
//                                                              allowDrawingOutsideViewBox:
//                                                                  true,
//                                                            )),
//                                                  onTap: () {
//                                                    model
//                                                            .bannerProductsResponse
//                                                            .data
//                                                            .products[index]
//                                                            .isWishlist
//                                                        ? model.addFav(
//                                                            AppLocalizations.of(
//                                                                    context)
//                                                                .locale
//                                                                .languageCode,
//                                                            model
//                                                                .bannerProductsResponse
//                                                                .data
//                                                                .products[index]
//                                                                .id,
//                                                            0)
//                                                        : model.addFav(
//                                                            AppLocalizations.of(
//                                                                    context)
//                                                                .locale
//                                                                .languageCode,
//                                                            model
//                                                                .bannerProductsResponse
//                                                                .data
//                                                                .products[index]
//                                                                .id,
//                                                            1);
//                                                  },
//                                                ),
                                                    SizedBox(
                                                      height: 160,
                                                      child: Center(
                                                        child:
                                                            CachedNetworkImage(
                                                          fit: BoxFit.fill,
                                                          imageUrl: model
                                                                      .bannerProductsResponse
                                                                      .data
                                                                      .products[
                                                                          index]
                                                                      .baseImage
                                                                      .length !=
                                                                  0
                                                              ? model
                                                                  .bannerProductsResponse
                                                                  .data
                                                                  .products[
                                                                      index]
                                                                  .baseImage['path']
                                                              : "images/logo.png",
//                                  placeholder:
//                                      (context, url) =>
//                                      Center(child: model.serviceId == 1 ? CircularProgressIndicator() : null),
                                                          errorWidget: (context,
                                                                  url, error) =>
                                                              new Image.asset(
                                                                  "images/logo.png"),
                                                        ),
                                                      ),
                                                    ),
                                                    Align(
                                                      alignment:
                                                          Alignment.centerLeft,
                                                      child: Column(
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        children: [
                                                          Text(
                                                            model
                                                                .bannerProductsResponse
                                                                .data
                                                                .products[index]
                                                                .name,
                                                            maxLines: 1,
                                                            overflow:
                                                                TextOverflow
                                                                    .ellipsis,
                                                            style: TextStyle(
                                                                color: Colors
                                                                    .black,
                                                                fontSize: 14,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold),
                                                          ),
                                                          Text(
                                                              "# " +
                                                                  model
                                                                      .bannerProductsResponse
                                                                      .data
                                                                      .products[
                                                                          index]
                                                                      .id
                                                                      .toString(),
                                                              style: TextStyle(
                                                                color:
                                                                    Colors.grey,
                                                              )),
                                                          Container(
                                                            child: Row(
                                                                mainAxisAlignment:
                                                                    MainAxisAlignment
                                                                        .spaceBetween,
                                                                children: [
                                                                  Container(
                                                                    width: (MediaQuery.of(context)
                                                                            .size
                                                                            .width /
                                                                        4),
                                                                    child:
                                                                        RichText(
                                                                      maxLines:
                                                                          1,
                                                                      overflow:
                                                                          TextOverflow
                                                                              .ellipsis,
                                                                      text:
                                                                          new TextSpan(
                                                                        text: (double.parse(model.bannerProductsResponse.data.products[index].price.amount).toInt()).toString() +
                                                                            ' ' +
                                                                            model.bannerProductsResponse.data.products[index].price.currency,
                                                                        style: new TextStyle(
                                                                            decoration: model.bannerProductsResponse.data.products[index].price.amount != model.bannerProductsResponse.data.products[index].sellingPrice.amount ? TextDecoration.lineThrough : TextDecoration.none,
//                                                                                        fontWeight: FontWeight.bold,
                                                                            color: Colors.black),
                                                                        children: <
                                                                            TextSpan>[
                                                                          model.bannerProductsResponse.data.products[index].price.amount != model.bannerProductsResponse.data.products[index].sellingPrice.amount
                                                                              ? new TextSpan(
                                                                                  text: (double.parse(model.bannerProductsResponse.data.products[index].sellingPrice.amount).toInt()).toString() + ' ' + model.bannerProductsResponse.data.products[index].price.currency,
                                                                                  style: new TextStyle(
//                                                                                                fontWeight: FontWeight.bold,
                                                                                    color: Colors.black,
                                                                                    decoration: TextDecoration.none,
                                                                                  ))
                                                                              : TextSpan(text: ""),
                                                                        ],
                                                                      ),
                                                                    ),
                                                                  ),
                                                                  model.bannerProductsResponse.data.products[index].price.amount !=
                                                                          model
                                                                              .bannerProductsResponse
                                                                              .data
                                                                              .products[
                                                                                  index]
                                                                              .sellingPrice
                                                                              .amount
                                                                      ? model.bannerProductsResponse.data.products[index].specialPricePercent !=
                                                                              null
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
                                                                                    child: model.bannerProductsResponse.data.products[index].price.amount != model.bannerProductsResponse.data.products[index].sellingPrice.amount
                                                                                        ? Text(
                                                                                            model.bannerProductsResponse.data.products[index].specialPricePercent.toString() + ' %',
                                                                                            style: TextStyle(color: Colors.white, fontSize: 10, fontWeight: FontWeight.bold),
                                                                                            overflow: TextOverflow.ellipsis,
                                                                                          )
                                                                                        : Text(
                                                                                            model.bannerProductsResponse.data.products[index].specialPricePercent.toString() + ' %',
                                                                                            style: TextStyle(color: Colors.white, fontSize: 10, fontWeight: FontWeight.bold),
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
                                                                          alignment:
                                                                              Alignment.centerRight,
                                                                          child:
                                                                              Container(
                                                                            width:
                                                                                35,
                                                                            height:
                                                                                35,
                                                                            decoration:
                                                                                BoxDecoration(
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
                                                          Alignment.centerLeft,
                                                      child: SmoothStarRating(
                                                          allowHalfRating:
                                                              false,
                                                          onRated: (value) {
//                                            _rating = value;
                                                          },
                                                          starCount: 5,
                                                          rating: model
                                                                      .bannerProductsResponse
                                                                      .data
                                                                      .products[
                                                                          index]
                                                                      .ratingPercent !=
                                                                  null
                                                              ? model
                                                                  .bannerProductsResponse
                                                                  .data
                                                                  .products[
                                                                      index]
                                                                  .ratingPercent
                                                              : 0,
                                                          size: 15.0,
                                                          isReadOnly: true,
                                                          color: Colors
                                                              .deepOrangeAccent,
                                                          borderColor: Colors
                                                              .deepOrangeAccent,
                                                          spacing: 0.0),
                                                    ),
                                                    SizedBox(
                                                      height:
                                                          MediaQuery.of(context)
                                                                  .size
                                                                  .height /
                                                              182,
                                                    ),
                                                    Expanded(
                                                      child: InkWell(
                                                        onTap: () {
                                                          print('price');
                                                          print(model
                                                              .bannerProductsResponse
                                                              .data
                                                              .products[index]
                                                              .oldPrice
                                                              .toString());
                                                          Item item = new Item(
                                                              id: model
                                                                  .bannerProductsResponse
                                                                  .data
                                                                  .products[
                                                                      index]
                                                                  .id,
                                                              name: model
                                                                  .bannerProductsResponse
                                                                  .data
                                                                  .products[
                                                                      index]
                                                                  .name,
                                                              userId: model
                                                                  .bannerProductsResponse
                                                                  .data
                                                                  .products[
                                                                      index]
                                                                  .userId,
                                                              brandId: model
                                                                  .bannerProductsResponse
                                                                  .data
                                                                  .products[
                                                                      index]
                                                                  .brandId,
                                                              slug: model
                                                                  .bannerProductsResponse
                                                                  .data
                                                                  .products[
                                                                      index]
                                                                  .slug,
                                                              isWishlist: model
                                                                  .bannerProductsResponse
                                                                  .data
                                                                  .products[
                                                                      index]
                                                                  .isWishlist,
                                                              inStock: model
                                                                  .bannerProductsResponse
                                                                  .data
                                                                  .products[
                                                                      index]
                                                                  .inStock,
                                                              ratingPercent: model
                                                                  .bannerProductsResponse
                                                                  .data
                                                                  .products[
                                                                      index]
                                                                  .ratingPercent,
                                                              price: Price(
                                                                  amount: model
                                                                      .bannerProductsResponse
                                                                      .data
                                                                      .products[index]
                                                                      .price
                                                                      .amount,
                                                                  formatted: model.bannerProductsResponse.data.products[index].price.formatted,
                                                                  currency: model.bannerProductsResponse.data.products[index].price.currency),
                                                              oldPrice: model.bannerProductsResponse.data.products[index].price.amount,
                                                              newPrice: model.bannerProductsResponse.data.products[index].sellingPrice.amount,
                                                              count: 1,
                                                              baseImage: new BaseImage(path: model.bannerProductsResponse.data.products[index].baseImage.length != 0 ? model.bannerProductsResponse.data.products[index].baseImage['path'] : null));

                                                          _addToCart(
                                                              item, context);
                                                        },
                                                        child: Container(
                                                          width:
                                                              double.infinity,
                                                          color:
                                                              Color(0xff45afe2),
                                                          child: Center(
                                                              child: Row(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .center,
                                                            children: [
                                                              Text(
                                                                AppLocalizations.of(
                                                                        context)
                                                                    .translate(
                                                                        'add_to_cart'),
                                                                style: TextStyle(
                                                                    color: Colors
                                                                        .white),
                                                              ),
                                                              SizedBox(
                                                                width: 6,
                                                              ),
                                                              SvgPicture.asset(
                                                                'images/icon_cart_red.svg',
                                                                height: 15.0,
                                                                width: 15.0,
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
                                      ),
                                    );
                                  }),
                                )
                              : Center(
                                  child: Text('empty'),
                                ));
            }));
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

  void refreshScreen(BannerProductsViewModel model) {
    model.getProductsBanner(
        AppLocalizations.of(context)
            .locale
            .languageCode
            .toLowerCase()
            .toString(),
        widget.i);
  }
}
