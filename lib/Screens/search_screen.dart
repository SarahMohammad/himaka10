import 'dart:convert';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_svg/svg.dart';
import 'package:himaka/Models/cart.dart';
import 'package:himaka/Models/product_service_details_response.dart';
import 'package:himaka/Screens/DetailsScreen/details_screen.dart';
import 'package:himaka/Screens/filter_screen.dart';
import 'package:himaka/ViewModels/base_model.dart';
import 'package:himaka/ViewModels/search_view_model.dart';
import 'package:himaka/services/base_view.dart';
import 'package:himaka/services/locator.dart';
import 'package:himaka/utils/AppLanguage.dart';
import 'package:himaka/utils/app_localizations.dart';
import 'package:himaka/utils/filter_selections.dart';
import 'package:himaka/utils/show_toast.dart';
import 'package:rect_getter/rect_getter.dart';
import 'package:smooth_star_rating/smooth_star_rating.dart';

class SearchScreen extends StatefulWidget {
  final Function callback;
  final String sKey;
  final int type;
  final int catId;

  SearchScreen(this.callback, this.sKey, this.type, {this.catId});

  @override
  _SearchScreenState createState() => _SearchScreenState(sKey);
}

class _SearchScreenState extends State<SearchScreen> {
  String searchKey;
  int categoryId;
  var _keys = {};
  final _storage = FlutterSecureStorage();
  String key = 'cart';
  final _scrollController = ScrollController();

  _SearchScreenState(this.searchKey);

  TextEditingController searchKeyController;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    categoryId = widget.catId;
    print("caat" + categoryId.toString());
    searchKey = widget.sKey;
    searchKeyController = new TextEditingController(text: searchKey);
  }

  @override
  Widget build(BuildContext context) {
    var listViewKey = RectGetter.createGlobalKey();
    List<int> getVisible() {
      /// First, get the rect of ListView, and then traver the _keys
      /// get rect of each item by keys in _keys, and if this rect in the range of ListView's rect,
      /// add the index into result list.
      var rect = RectGetter.getRectFromKey(listViewKey);
      var _items = <int>[];
      _keys.forEach((index, key) {
        var itemRect = RectGetter.getRectFromKey(key);
        if (itemRect != null &&
            !(itemRect.top > rect.bottom || itemRect.bottom < rect.top))
          _items.add(index);
      });

      /// so all visible item's index are in this _items.
      return _items;
    }

    var size = MediaQuery.of(context).size;

    /*24 is for notification bar on Android*/
    final double itemHeight = (size.height - kToolbarHeight - 20) / 2.1;
    final double itemWidth = size.width / 2;

    return BaseView<SearchViewModel>(
        onModelReady: (model) {
          model.type = widget.type;
          if (categoryId == null)
            refreshScreen(model);
          else
            refresh2Screen(model);
        },
        builder:
            (context, model, child) => LayoutBuilder(builder:
                    (BuildContext context, BoxConstraints viewportConstraints) {
                  return Scaffold(
                    appBar: AppBar(
                      backgroundColor: Color(0xFFf5f5f5),
                      iconTheme: IconThemeData(
                        color: Colors.grey[900], //change your color here
                      ),
                      elevation: 0.0,
                      title: Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          shape: BoxShape.rectangle,
                          borderRadius:
                              new BorderRadius.all(Radius.circular(30)),
                        ),
                        child: TextFormField(
                          controller: searchKeyController,
                          decoration: InputDecoration(
                            fillColor: Colors.white,
                            contentPadding: EdgeInsets.symmetric(
                                horizontal: 16.0, vertical: 16),
                            suffixIcon: InkWell(
                              onTap: () {
                                //clear page, total, list make it null and call api
                                if (searchKeyController.text.isNotEmpty) {
                                  categoryId = null;
                                  model.pullToRefresh();
                                  searchKey = searchKeyController.text;
                                  refreshScreen(model);
                                }
                              },
                              child: Icon(
                                Icons.search,
                                color: Colors.black38,
                              ),
                            ),
                            enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.white)),
                            hintStyle:
                                TextStyle(color: Colors.black38, fontSize: 13),
                            hintText: AppLocalizations.of(context)
                                .translate('search_hint'),
                          ),
                        ),
                      ),
                    ),
                    body: model.productOrService != null
                        ? model.productOrService.length > 0
                            ? Stack(
                                children: [
                                  NotificationListener<ScrollNotification>(
                                    onNotification: (notification) {
                                      if (notification
                                          is ScrollUpdateNotification) {
                                        List<int> x = getVisible();
                                        print(x);
                                        if (x != null && x.length > 0) {
                                          model.visibleItemsCount =
                                              (x[x.length - 1] + 1).toString();
                                        }
                                      }
                                      if (!model.isLoading &&
                                          notification
                                              is ScrollEndNotification &&
                                          _scrollController
                                                  .position.extentAfter ==
                                              0) {
                                        model.isLoading = true;
                                        if (categoryId == null)
                                          refreshScreen(model);
                                        else
                                          refresh2Screen(model);
                                      }

                                      return true;
                                    },
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 16.0, vertical: 8),
                                          child: InkWell(
                                            onTap: () async {
                                              var result = await Navigator.push(
                                                  context,
                                                  new MaterialPageRoute(
                                                      builder: (context) =>
                                                          new FilterScreen(
                                                              widget.type)));
                                              if (result != null &&
                                                  result is FilterSelections) {
                                                filter(model, result);
                                              }
                                            },
                                            child: Container(
                                              width: MediaQuery.of(context)
                                                      .size
                                                      .width *
                                                  .35,
                                              // width: 130,
                                              height: 50,
                                              decoration: BoxDecoration(
                                                  color: Color(0xFF45afe1),
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          5.0)),
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        horizontal: 16.0,
                                                        vertical: 8),
                                                child: Row(
                                                  children: [
                                                    SvgPicture.asset(
                                                      'images/filter.svg',
                                                      height: 25.0,
                                                      width: 25.0,
                                                      allowDrawingOutsideViewBox:
                                                          true,
                                                    ),
                                                    SizedBox(
                                                      width: 4,
                                                    ),
                                                    Text(
                                                      AppLocalizations.of(
                                                              context)
                                                          .translate('filter'),
                                                      style: TextStyle(
                                                          color: Colors.white,
                                                          fontSize: 20,
                                                          fontWeight:
                                                              FontWeight.bold),
                                                    )
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                        Expanded(
                                          child: Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: RectGetter(
                                              key: listViewKey,
                                              child: GridView.count(
                                                shrinkWrap: true,
                                                controller: _scrollController,
                                                childAspectRatio:
                                                    (itemWidth / itemHeight),
                                                crossAxisCount: 2,
                                                padding: EdgeInsets.only(
                                                    top: 8,
                                                    left: 6,
                                                    right: 6,
                                                    bottom: 12),
                                                children: List.generate(
                                                    model.productOrService
                                                        .length, (index) {
                                                  _keys[index] = RectGetter
                                                      .createGlobalKey();
                                                  return RectGetter(
                                                    key: _keys[index],
                                                    child: Container(
                                                      child: Card(
                                                        clipBehavior:
                                                            Clip.antiAlias,
                                                        child: InkWell(
                                                          onTap: () {
                                                            print(
                                                                'Card tapped.');
                                                          },
                                                          child: Container(
                                                            width: 160.0,
                                                            child: Card(
                                                              clipBehavior: Clip
                                                                  .antiAlias,
                                                              child: InkWell(
                                                                onTap: () {
                                                                  Navigator.push(
                                                                      context,
                                                                      new MaterialPageRoute(
                                                                          builder: (context) => new DetailsScreen(
                                                                              widget.callback,
                                                                              model.productOrService[index].id,
                                                                              widget.type)));
                                                                },
                                                                child: Column(
                                                                  crossAxisAlignment:
                                                                      CrossAxisAlignment
                                                                          .end,
                                                                  children: <
                                                                      Widget>[
                                                                    InkWell(
                                                                      child: Container(
                                                                          child: model.productOrService[index].isFav
                                                                              ? SvgPicture.asset(
                                                                                  'images/icon_fav_blue.svg',
                                                                                  height: 20.0,
                                                                                  width: 20.0,
                                                                                  allowDrawingOutsideViewBox: true,
                                                                                )
                                                                              : SvgPicture.asset(
                                                                                  'images/icon_fav_grey.svg',
                                                                                  height: 20.0,
                                                                                  width: 20.0,
                                                                                  allowDrawingOutsideViewBox: true,
                                                                                )),
                                                                      onTap:
                                                                          () {
                                                                        model.productOrService[index].isFav
                                                                            ? model.addFav(
                                                                                AppLocalizations.of(context).locale.languageCode,
                                                                                model.productOrService[index].id,
                                                                                0,
                                                                                searchKey)
                                                                            : model.addFav(AppLocalizations.of(context).locale.languageCode, model.productOrService[index].id, 1, searchKey);
                                                                      },
                                                                    ),
                                                                    SizedBox(
                                                                      height:
                                                                          130,
                                                                      child:
                                                                          CachedNetworkImage(
                                                                        fit: BoxFit
                                                                            .fill,
                                                                        imageUrl: model
                                                                            .productOrService[index]
                                                                            .image
                                                                            .path,
                                                                        placeholder:
                                                                            (context, url) =>
                                                                                Center(child: CircularProgressIndicator()),
                                                                        errorWidget: (context,
                                                                                url,
                                                                                error) =>
                                                                            new Icon(Icons.error),
                                                                      ),
                                                                    ),
                                                                    Align(
                                                                      alignment:
                                                                          Alignment
                                                                              .centerLeft,
                                                                      child:
                                                                          Column(
                                                                        crossAxisAlignment:
                                                                            CrossAxisAlignment.start,
                                                                        children: [
                                                                          Text(
                                                                            model.productOrService[index].name,
                                                                            style: TextStyle(
                                                                                color: Colors.black,
                                                                                fontSize: 14,
                                                                                fontWeight: FontWeight.bold),
                                                                            overflow:
                                                                                TextOverflow.ellipsis,
                                                                            maxLines:
                                                                                1,
                                                                          ),
                                                                          Text(
                                                                              '#' + model.productOrService[index].id.toString(),
                                                                              style: TextStyle(
                                                                                color: Colors.grey,
                                                                              ))
                                                                        ],
                                                                      ),
                                                                    ),
                                                                    Align(
                                                                      alignment:
                                                                          Alignment
                                                                              .centerLeft,
                                                                      child:
                                                                          RichText(
                                                                        text:
                                                                            new TextSpan(
                                                                          text: model.productOrService[index].oldPrice.toString() +
                                                                              ' ' +
                                                                              model.productOrService[index].price.currency,
                                                                          style: new TextStyle(
                                                                              decoration: model.productOrService[index].oldPrice != model.productOrService[index].newPrice ? TextDecoration.lineThrough : TextDecoration.none,
                                                                              fontWeight: FontWeight.bold,
                                                                              color: Colors.black),
                                                                          children: <
                                                                              TextSpan>[
                                                                            model.productOrService[index].oldPrice != model.productOrService[index].newPrice
                                                                                ? new TextSpan(
                                                                                    text: model.productOrService[index].newPrice.toString() + ' ' + model.productOrService[index].price.currency,
                                                                                    style: new TextStyle(
                                                                                      fontWeight: FontWeight.bold,
                                                                                      color: Colors.black,
                                                                                      decoration: TextDecoration.none,
                                                                                    ))
                                                                                : TextSpan(text: ""),
                                                                          ],
                                                                        ),
                                                                      ),

//                                                                          RichText(
//                                                                        text:
//                                                                            new TextSpan(
//                                                                          text: model.productOrService[index].oldPrice.toString() +
//                                                                              ' ' +
//                                                                              model.productOrService[index].price.currency,
//                                                                          style: new TextStyle(
//                                                                              decoration: TextDecoration.lineThrough,
//                                                                              fontWeight: FontWeight.bold,
//                                                                              color: Colors.black),
//                                                                          children: <
//                                                                              TextSpan>[
//                                                                            model.productOrService[index].oldPrice == model.productOrService[index].newPrice
//                                                                                ? TextSpan()
//                                                                                : TextSpan(
//                                                                                    text: model.productOrService[index].newPrice.toString() + ' ' + model.productOrService[index].price.currency,
//                                                                                    style: new TextStyle(
//                                                                                      fontWeight: FontWeight.bold,
//                                                                                      color: Colors.black,
//                                                                                    )),
//                                                                          ],
//                                                                        ),
//                                                                      ),
                                                                    ),
                                                                    Row(
                                                                        children: [
                                                                          SmoothStarRating(
                                                                              allowHalfRating: false,
                                                                              starCount: 5,
                                                                              rating: model.productOrService[index].rating != null ? model.productOrService[index].rating.toDouble() : 0,
                                                                              size: 15.0,
                                                                              isReadOnly: true,
                                                                              color: Colors.deepOrangeAccent,
                                                                              borderColor: Colors.deepOrangeAccent,
                                                                              spacing: 0.0),
                                                                          model.productOrService[index].offerType == "fixed"
                                                                              ? Expanded(
                                                                                  child: Align(
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
                                                                                        '10%',
                                                                                        style: TextStyle(color: Colors.white, fontSize: 11, fontWeight: FontWeight.bold),
                                                                                      )),
                                                                                    ),
                                                                                  ),
                                                                                )
                                                                              : model.productOrService[index].offerPercent == null
                                                                                  ? Expanded(
                                                                                      child: Align(
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
                                                                                            '10%',
                                                                                            style: TextStyle(color: Colors.white, fontSize: 11, fontWeight: FontWeight.bold),
                                                                                          )),
                                                                                        ),
                                                                                      ),
                                                                                    )
                                                                                  : Expanded(
                                                                                      child: Align(
                                                                                        alignment: Alignment.centerRight,
                                                                                        child: Container(
                                                                                          width: 41,
                                                                                          height: 41,
                                                                                          decoration: BoxDecoration(
                                                                                            border: Border.all(width: 3, color: Colors.orange),
                                                                                            borderRadius: BorderRadius.all(
                                                                                              Radius.circular(600),
                                                                                            ),
                                                                                            color: Colors.orange,
                                                                                          ),
                                                                                          child: Center(
                                                                                              child: Text(
                                                                                            model.productOrService[index].offerPercent.toString() + '%',
                                                                                            overflow: TextOverflow.ellipsis,
                                                                                            maxLines: 1,
                                                                                            style: TextStyle(color: Colors.white, fontSize: 11, fontWeight: FontWeight.bold),
                                                                                          )),
                                                                                        ),
                                                                                      ),
                                                                                    )
                                                                        ]),
                                                                    SizedBox(
                                                                      height: MediaQuery.of(context)
                                                                              .size
                                                                              .height /
                                                                          182,
                                                                    ),
                                                                    Expanded(
                                                                      child:
                                                                          InkWell(
                                                                        onTap:
                                                                            () {
                                                                          Item item = new Item(
                                                                              id: model.productOrService[index].id,
                                                                              name: model.productOrService[index].name,
                                                                              isWishlist: model.productOrService[index].isFav,
                                                                              ratingPercent: model.productOrService[index].rating,
                                                                              price: new Price(amount: model.productOrService[index].price.amount, currency: model.productOrService[index].price.currency),
                                                                              oldPrice: model.productOrService[index].oldPrice,
                                                                              newPrice: model.productOrService[index].newPrice,
                                                                              count: 1,
                                                                              baseImage: new BaseImage(path: model.productOrService[index].image.path));

                                                                          _addToCart(
                                                                              item,
                                                                              context);
                                                                        },
                                                                        child:
                                                                            Container(
                                                                          width:
                                                                              double.infinity,
                                                                          color:
                                                                              Color(0xff45afe2),
                                                                          child: Center(
                                                                              child: Row(
                                                                            mainAxisAlignment:
                                                                                MainAxisAlignment.center,
                                                                            children: [
                                                                              Text(
                                                                                AppLocalizations.of(context).translate('add_to_cart'),
                                                                                style: TextStyle(color: Colors.white),
                                                                              ),
                                                                              SizedBox(
                                                                                width: 6,
                                                                              ),
                                                                              SvgPicture.asset(
                                                                                'images/icon_cart_red.svg',
                                                                                height: 15.0,
                                                                                width: 15.0,
                                                                                allowDrawingOutsideViewBox: true,
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
                                                    ),
                                                  );
                                                }),
                                              ),
                                            ),
                                          ),
                                        ),
                                        Container(
                                          height: model.isLoading ? 50.0 : 0,
                                          child: Center(
                                            child:
                                                new CircularProgressIndicator(),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  model.visibleItemsCount.isNotEmpty
                                      ? Align(
                                          alignment: Alignment.bottomCenter,
                                          child: Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Container(
                                              decoration: BoxDecoration(
                                                shape: BoxShape.rectangle,
                                                borderRadius:
                                                    new BorderRadius.all(
                                                        Radius.circular(15)),
                                                color: Color(0xFF45afe1),
                                              ),
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        horizontal: 16.0,
                                                        vertical: 8),
                                                child: Text(
                                                  model.total.toString() +
                                                      ' / ' +
                                                      model.visibleItemsCount,
                                                  style: TextStyle(
                                                      color: Colors.white),
                                                ),
                                              ),
                                            ),
                                          ))
                                      : Container()
                                ],
                              )
                            : Center(
                                child: Text(AppLocalizations.of(context)
                                    .translate('no_data')),
                              )
                        : model.state == ViewState.Idle
                            ? Scaffold(
                                backgroundColor: Colors.transparent,
                                body: Container(
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
                                            if (categoryId == null)
                                              refreshScreen(model);
                                            else
                                              refresh2Screen(model);
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
                                ),
                              )
                            : Center(
                                child: CircularProgressIndicator(
                                  backgroundColor: Colors.lightBlue,
                                ),
                              ),
                  );
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

  refreshScreen(SearchViewModel model) {
    model.search(locator<AppLanguage>().appLocal.languageCode, searchKey);
  }

  refresh2Screen(SearchViewModel model) {
    model.getProducts(
        locator<AppLanguage>().appLocal.languageCode, widget.catId);
  }

  filter(SearchViewModel model, FilterSelections filterSelections) {
    model.pullToRefresh();
    model.filter(
        locator<AppLanguage>().appLocal.languageCode,
        searchKey,
        filterSelections.lowerPrice,
        filterSelections.upperPrice,
        filterSelections.catId,
        filterSelections.ratings,
        filterSelections.isUsed);
  }
}
