import 'dart:convert';

import 'package:badges/badges.dart';
import 'package:carousel_pro/carousel_pro.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_svg/svg.dart';
import 'package:himaka/Models/cart.dart';
import 'package:himaka/Screens/Chat/chatlist.dart';
import 'package:himaka/Screens/DetailsScreen/delivery_container.dart';

import 'package:himaka/Screens/DetailsScreen/reviews_container.dart';
import 'package:himaka/Screens/cart_screen.dart';
import 'package:himaka/Screens/special_offer_screen.dart';
import 'package:himaka/Screens/wish_list_screen.dart';
import 'package:himaka/ViewModels/base_model.dart';
import 'package:himaka/ViewModels/product_service_details_view_model.dart';
import 'package:himaka/services/base_view.dart';
import 'package:himaka/utils/app_localizations.dart';
import 'package:himaka/utils/globals.dart';
import 'package:himaka/utils/show_toast.dart';
import 'package:smooth_star_rating/smooth_star_rating.dart';

import '../../Models/product_service_details_response.dart';
import 'desciption_container.dart';

class DetailsScreen extends StatefulWidget {
  int id;
  final Function callback;
  int type; // 1 for products , 2 for services

  @override
  _DetailsScreenState createState() => _DetailsScreenState();

  DetailsScreen(this.callback, this.id, this.type);
}

class _DetailsScreenState extends State<DetailsScreen>
    with TickerProviderStateMixin {
  List<Tab> tabList = List();
  TabController _tabController;
  final _storage = FlutterSecureStorage();
  String key = 'cart';
  bool _started = true;
  int _counter = 0;

  Widget imageCarousel(List images, String userID, String name) {
    print("hh" + images.toString());
    return Stack(
      children: [
        Container(
          height: 200.0,
          child: Container(
            color: Colors.white,
            child: new Carousel(
              boxFit: BoxFit.cover,
              images: images,
              autoplay: true,
              animationCurve: Curves.fastOutSlowIn,
              animationDuration: Duration(milliseconds: 500),
              dotSize: 5.0,
              indicatorBgPadding: 5.0,
              dotBgColor: Colors.transparent,
              dotIncreasedColor: Colors.lightBlueAccent,
            ),
          ),
        ),
//         widget.type == 2
//             ? Positioned.fill(
//                 child: InkWell(
//                   child: Align(
//                       alignment: Alignment.bottomLeft,
//                       child: Padding(
//                         padding: const EdgeInsets.all(10.0),
//                         child: Icon(Icons.chat, color: Colors.lightBlue),
//                       )),
//                   onTap: () {
//
// // _moveTochatRoom("", userID, userID);
//                   },
//                 ),
//               )
//             : Container()
      ],
    );
  }

  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  List images = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    readFromCash();
  }

  @override
  Widget build(BuildContext context) {
    if (_started) {
      tabList.add(new Tab(
        text: AppLocalizations.of(context).translate('description'),
      ));

      tabList.add(new Tab(
        text: AppLocalizations.of(context).translate('reviews'),
      ));

      tabList.add(new Tab(
        text: AppLocalizations.of(context).translate('delivery_info'),
      ));

      _started = false;
    }
    _tabController = new TabController(vsync: this, length: tabList.length);

    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        centerTitle: true,
        title: Text(
          AppLocalizations.of(context).translate('details'),
          style: TextStyle(color: Colors.grey[900]),
        ),
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios, color: Colors.black),
          onPressed: () => Navigator.of(context).pop(),
        ),
        actions: [
          IconButton(
            icon: SvgPicture.asset(
              'images/icon_fav_appbar.svg',
              height: 20.0,
              width: 20.0,
              allowDrawingOutsideViewBox: true,
            ),

//              Icon(
//                Icons.favorite,
//                color: Colors.black,
//              ),
            onPressed: () {
              Navigator.push(
                  context,
                  new MaterialPageRoute(
                      builder: (context) => new WishListScreen()));
            },
          ),
          _shoppingCartBadge()
        ],
      ),
      body: BaseView<ProductServiceDetailsViewModel>(
          onModelReady: (model) {
            refreshScreen(model);
          },
          builder: (context, model, child) => LayoutBuilder(builder:
                  (BuildContext context, BoxConstraints viewportConstraints) {
                if (model.productOrServiceDetailsResponse != null &&
                    images.length == 0) {
                  if (model.productOrServiceDetailsResponse.data.item.images
                          .length !=
                      0) {
                    for (int i = 0;
                        i <
                            model.productOrServiceDetailsResponse.data.item
                                .images.length;
                        i++) {
                      images.add(Image.network(model
                          .productOrServiceDetailsResponse
                          .data
                          .item
                          .images[i]));
                    }
                  }
                }

                return model.state == ViewState.Busy
                    ? Center(
                        child: CircularProgressIndicator(
                          backgroundColor: Colors.lightBlue,
                        ),
                      )
                    : model.productOrServiceDetailsResponse != null
                        ? ListView(
                            children: [
                              new Column(
                                children: <Widget>[
                                  //image carousel begins here
                                  imageCarousel(
                                      images,
                                      model.productOrServiceDetailsResponse.data
                                          .item.userId,
                                      model.productOrServiceDetailsResponse.data
                                          .item.userName),

                                  //padding widget
                                  new Padding(
                                    padding: const EdgeInsets.all(10.0),
                                    child: InkWell(
                                      onTap: () {
//                    Navigator.push(
//                        context,
//                        new MaterialPageRoute(
//                            builder: (
//                                context) => new AddProductService()));
                                      },
                                      child: Container(
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(13.0),
                                            color: Colors.white,
                                            border: Border.all(
                                              color: Colors.white,
                                            ),
                                            boxShadow: [
                                              BoxShadow(
                                                color: Colors.grey[400],
                                                offset:
                                                    Offset(0.0, 1.0), //(x,y)
                                                blurRadius: 6.0,
                                              ),
                                            ],
                                          ),
                                          alignment: Alignment.center,
                                          child: Padding(
                                            padding: const EdgeInsets.all(10.0),
                                            child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              children: [
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    Flexible(
                                                      child: Text(
                                                        model
                                                            .productOrServiceDetailsResponse
                                                            .data
                                                            .item
                                                            .name,
                                                        style: TextStyle(
                                                            fontSize: 24,
                                                            fontWeight:
                                                                FontWeight
                                                                    .bold),
                                                      ),
                                                    ),
                                                    InkWell(
                                                      onTap: () {
                                                        model
                                                                .productOrServiceDetailsResponse
                                                                .data
                                                                .item
                                                                .isWishlist
                                                            ? model.addFav(
                                                                AppLocalizations.of(
                                                                        context)
                                                                    .locale
                                                                    .languageCode,
                                                                model
                                                                    .productOrServiceDetailsResponse
                                                                    .data
                                                                    .item
                                                                    .id,
                                                                0)
                                                            : model.addFav(
                                                                AppLocalizations.of(
                                                                        context)
                                                                    .locale
                                                                    .languageCode,
                                                                model
                                                                    .productOrServiceDetailsResponse
                                                                    .data
                                                                    .item
                                                                    .id,
                                                                1);
                                                      },
                                                      child: model
                                                              .productOrServiceDetailsResponse
                                                              .data
                                                              .item
                                                              .isWishlist
                                                          ? SvgPicture.asset(
                                                              'images/icon_fav_blue.svg',
                                                              height: 20.0,
                                                              width: 20.0,
                                                              allowDrawingOutsideViewBox:
                                                                  true,
                                                            )
                                                          : SvgPicture.asset(
                                                              'images/icon_fav_grey.svg',
                                                              height: 20.0,
                                                              width: 20.0,
                                                              allowDrawingOutsideViewBox:
                                                                  true,
                                                            ),
                                                    ),
                                                  ],
                                                ),
                                                Container(
                                                  width: MediaQuery.of(context)
                                                      .size
                                                      .width,
                                                  child: Text(
                                                    '#' +
                                                        model
                                                            .productOrServiceDetailsResponse
                                                            .data
                                                            .item
                                                            .id
                                                            .toString(),
                                                    style: TextStyle(
                                                        color: Colors.grey,
                                                        fontSize: 13),
                                                  ),
                                                ),
                                                SizedBox(
                                                  height: 6,
                                                ),
                                                Row(
                                                  children: [
                                                    Text(
                                                        model.productOrServiceDetailsResponse
                                                                .data.item.oldPrice
                                                                .toString() +
                                                            " " +
                                                            model
                                                                .productOrServiceDetailsResponse
                                                                .data
                                                                .item
                                                                .price
                                                                .currency,
                                                        style: new TextStyle(
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          color: Colors.black,
                                                          decoration: model
                                                                      .productOrServiceDetailsResponse
                                                                      .data
                                                                      .item
                                                                      .oldPrice !=
                                                                  model
                                                                      .productOrServiceDetailsResponse
                                                                      .data
                                                                      .item
                                                                      .newPrice
                                                              ? TextDecoration
                                                                  .lineThrough
                                                              : TextDecoration
                                                                  .none,
                                                        )),
                                                    SizedBox(
                                                      width: 10,
                                                    ),
                                                    model.productOrServiceDetailsResponse.data
                                                                .item.oldPrice !=
                                                            model
                                                                .productOrServiceDetailsResponse
                                                                .data
                                                                .item
                                                                .newPrice
                                                        ? Text(
                                                            model
                                                                    .productOrServiceDetailsResponse
                                                                    .data
                                                                    .item
                                                                    .newPrice
                                                                    .toString() +
                                                                " " +
                                                                model
                                                                    .productOrServiceDetailsResponse
                                                                    .data
                                                                    .item
                                                                    .price
                                                                    .currency,
                                                            style: new TextStyle(
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                                color: Colors
                                                                    .black))
                                                        : Container(),
                                                    SizedBox(
                                                      width: 10,
                                                    ),
                                                    model.productOrServiceDetailsResponse.data
                                                                .item.oldPrice !=
                                                            model
                                                                .productOrServiceDetailsResponse
                                                                .data
                                                                .item
                                                                .newPrice
                                                        ? model
                                                                    .productOrServiceDetailsResponse
                                                                    .data
                                                                    .item
                                                                    .specialPricePercent !=
                                                                null
                                                            ? Container(
                                                                decoration: BoxDecoration(
                                                                    shape: BoxShape
                                                                        .circle,
                                                                    color: Colors
                                                                        .lightBlue),
                                                                child: Padding(
                                                                  padding:
                                                                      const EdgeInsets
                                                                              .all(
                                                                          10.0),
                                                                  child: Text(
                                                                    model
                                                                            .productOrServiceDetailsResponse
                                                                            .data
                                                                            .item
                                                                            .specialPricePercent
                                                                            .toString() +
                                                                        "%",
                                                                    style: TextStyle(
                                                                        color: Colors
                                                                            .white),
                                                                  ),
                                                                ))
                                                            : Container()
                                                        : Container(),
                                                    Expanded(
                                                        child: Container()),
                                                    InkWell(
                                                      child: SvgPicture.asset(
                                                        'images/icon_pricetag.svg',
                                                        height: 30.0,
                                                        width: 30.0,
                                                        allowDrawingOutsideViewBox:
                                                            true,
                                                      ),
                                                      onTap: () {
                                                        if (int.parse(Globals
                                                                .userData
                                                                .commission_acount) >
                                                            model
                                                                .productOrServiceDetailsResponse
                                                                .data
                                                                .item
                                                                .newPrice) {
                                                          Navigator.push(
                                                              context,
                                                              new MaterialPageRoute(
                                                                  builder: (context) => new SpecialOfferScreen(
                                                                      item: model
                                                                          .productOrServiceDetailsResponse
                                                                          .data
                                                                          .item)));
                                                        } else {
                                                          showToast(
                                                              AppLocalizations.of(
                                                                      context)
                                                                  .translate(
                                                                      'special_offer_not_valid'),
                                                              Colors.red);
                                                        }
                                                      },
                                                    ),
                                                  ],
                                                ),
                                                SizedBox(
                                                  height: 6,
                                                ),
//                                                Container(
//                                                    width:
//                                                        MediaQuery.of(context)
//                                                            .size
//                                                            .width,
//                                                    child: Text(
//                                                        'brand name : NIKE')),
                                                SizedBox(
                                                  height: 6,
                                                ),
                                                Container(
                                                  width: MediaQuery.of(context)
                                                      .size
                                                      .width,
                                                  child: Row(
                                                    children: [
                                                      SmoothStarRating(
                                                          allowHalfRating:
                                                              false,
                                                          onRated: (value) {
//                                            _rating = value;
                                                          },
                                                          starCount: 5,
                                                          rating: double.parse(model
                                                              .productOrServiceDetailsResponse
                                                              .data
                                                              .item
                                                              .ratingPercent
                                                              .toString()),
                                                          size: 19.0,
                                                          isReadOnly: true,
                                                          color: Colors
                                                              .deepOrangeAccent,
                                                          borderColor: Colors
                                                              .deepOrangeAccent,
                                                          spacing: 0.0),
                                                      SizedBox(
                                                        width: 5,
                                                      ),
                                                      Text('Rating ' +
                                                          model
                                                              .productOrServiceDetailsResponse
                                                              .data
                                                              .item
                                                              .ratingPercent
                                                              .toString()),
                                                      Spacer(),
                                                      widget.type == 2
                                                          ? InkWell(
                                                              onTap: () {
                                                                Navigator.push(
                                                                    context,
                                                                    MaterialPageRoute(
                                                                        builder: (context) => ChatList(
                                                                            Globals.userData.id.toString(),
                                                                            model.productOrServiceDetailsResponse.data.item.userId,
                                                                            model.productOrServiceDetailsResponse.data.item.userName)));
                                                              },
                                                              child: SvgPicture
                                                                  .asset(
                                                                'images/chat.svg',
                                                                height: 50.0,
                                                                width: 50.0,
                                                                allowDrawingOutsideViewBox:
                                                                    true,
                                                              ),
                                                            )
                                                          : Container()
                                                    ],
                                                  ),
                                                ),
                                                SizedBox(
                                                  width: 5,
                                                ),
                                              ],
                                            ),
                                          )),
                                    ),
                                  ),

                                  Padding(
                                    padding: const EdgeInsets.all(10.0),
                                    child: Container(
                                      decoration: BoxDecoration(
                                        borderRadius:
                                            BorderRadius.circular(19.0),
                                        color: Colors.white,
                                        border: Border.all(
                                          color: Colors.white,
                                        ),
                                      ),
                                      child: Padding(
                                        padding: const EdgeInsets.all(5.0),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            InkWell(
                                              onTap: () {
                                                setState(() {
                                                  model.minus();
                                                });
                                              },
                                              child: SvgPicture.asset(
                                                'images/icon_minus.svg',
                                                height: 20.0,
                                                width: 20.0,
                                                allowDrawingOutsideViewBox:
                                                    true,
                                              ),
                                            ),
                                            Text(model.count.toString()),
                                            InkWell(
                                              onTap: () {
                                                setState(() {
                                                  model.add();
                                                });
                                              },
                                              child: SvgPicture.asset(
                                                'images/icon_add.svg',
                                                height: 20.0,
                                                width: 20.0,
                                                allowDrawingOutsideViewBox:
                                                    true,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),

                                  Container(
                                    decoration:
                                        new BoxDecoration(color: Colors.white),
                                    child: new TabBar(
                                      labelColor: Colors.lightBlue,
                                      controller: _tabController,
                                      unselectedLabelColor: Colors.grey[800],
                                      indicatorColor: Colors.lightBlue,
                                      indicatorSize: TabBarIndicatorSize.tab,
                                      tabs: tabList,
                                      labelStyle: TextStyle(fontSize: 12),
                                    ),
                                  ),

                                  new Container(
                                    height: MediaQuery.of(context).size.height /
                                        1.6,
                                    child: Padding(
                                      padding: const EdgeInsets.all(10.0),
                                      child: new TabBarView(
                                        controller: _tabController,
                                        children: <Widget>[
                                          DescriptionContainer(
                                              desc: model
                                                  .productOrServiceDetailsResponse
                                                  .data
                                                  .item
                                                  .description,
                                              related_products: model
                                                  .productOrServiceDetailsResponse
                                                  .data
                                                  .item
                                                  .relatedProducts),
                                          ReviewsContainer(
                                              id: model
                                                  .productOrServiceDetailsResponse
                                                  .data
                                                  .item
                                                  .id,
                                              reviews: model
                                                  .productOrServiceDetailsResponse
                                                  .data
                                                  .item
                                                  .reviews),
                                          DeliveryContainer(model
                                              .productOrServiceDetailsResponse
                                              .data
                                              .deliveryInfo)
                                        ],
                                      ),
                                    ),
                                  ),
                                  RaisedButton(
                                    onPressed: () async {
                                      var item = model
                                          .productOrServiceDetailsResponse
                                          .data
                                          .item;
                                      item.count = model.count;

                                      setState(() {
                                        _addToCart(item, context);
                                      });
                                    },
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Text(
                                            AppLocalizations.of(context)
                                                .translate('add_to_cart'),
                                            style: TextStyle(
                                              fontSize: 23,
                                              color: Colors.white,
                                            ),
                                          ),
                                          SizedBox(width: 4),
                                          SvgPicture.asset(
                                            'images/icon_cart_red.svg',
                                            height: 25.0,
                                            width: 25.0,
                                            allowDrawingOutsideViewBox: true,
                                          )
                                        ],
                                      ),
                                    ),
                                    color: Colors.lightBlue,
                                  )
                                ],
                              )
                            ],
                          )
                        : Center(
                            child: Text('empty'),
                          );
              })),
    );
  }

  String makeChatId(myID, selectedUserID) {
    String chatID;
    if (myID.hashCode > selectedUserID.hashCode) {
      chatID = '$selectedUserID-$myID';
    } else {
      chatID = '$myID-$selectedUserID';
    }
    return chatID;
  }

  void refreshScreen(ProductServiceDetailsViewModel model) {
    model.getProductOrServiceDetails(
        widget.id, AppLocalizations.of(context).locale.languageCode);
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
        cashedCart.items[index] = item;
      }
    } else {
      List<Item> items = new List<Item>();
      items.add(item);
      cashedCart = new Cart(items: items);
      widget.callback(cashedCart.items.length);

      showToast(AppLocalizations.of(context).translate('added_successfully'),
          Colors.green);
    }

    setState(() {
      _counter = cashedCart.items.length;
    });
    await _storage.write(key: key, value: json.encode(cashedCart));
  }

  Future<Cart> readFromCash() async {
    String value = await _storage.read(key: "cart");

    if (value != null) {
      Cart cashedCart = Cart.fromJson(json.decode(value));
      if (cashedCart != null && cashedCart.items != null) {
        setState(() {
          _counter = cashedCart.items.length;
        });
      }
      return cashedCart;
    }

    return null;
  }

  Widget _shoppingCartBadge() {
    return Badge(
      position: BadgePosition.topEnd(top: 0, end: 3),
      animationDuration: Duration(milliseconds: 300),
      animationType: BadgeAnimationType.slide,
      badgeColor: Colors.lightBlue,
      badgeContent: Text(
        _counter.toString(),
        style: TextStyle(color: Colors.white),
      ),
      child: IconButton(
          icon: Icon(Icons.shopping_cart, color: Colors.grey[700], size: 25),
//        SvgPicture.asset(
//            'images/icon_cart_appbar.svg',
//            height: 22.0,
//            width: 22.0,
//            allowDrawingOutsideViewBox: true,
//          ),
          onPressed: () {
            Navigator.push(context,
                new MaterialPageRoute(builder: (context) => new CartScreen()));
          }),
    );
  }
}
