import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_svg/svg.dart';
import 'package:himaka/Models/cart.dart';
import 'package:himaka/Models/product_service_details_response.dart';
import 'package:himaka/utils/app_localizations.dart';
import 'package:smooth_star_rating/smooth_star_rating.dart';

class CartItem extends StatefulWidget {
  final Item item;
  final int index;
  final Function callback;
  final Function removeCallback;

  CartItem(this.item, this.callback, this.removeCallback, this.index);

  @override
  _CartItemState createState() => _CartItemState();
}

class _CartItemState extends State<CartItem> {
  final _storage = FlutterSecureStorage();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white,
      elevation: 3.0,
      child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 9.0, vertical: 1),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              widget.item.baseImage.path == null
                  ? Image.asset("images/logo.png")
                  : Image.network(
                      widget.item.baseImage.path,
                      width: 120,
                      height: 80,
                    ),
              SizedBox(
                width: 20,
              ),
              Expanded(
                child: Container(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      SizedBox(
                        height: 8,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Flexible(
                            child: Text(
                              widget.item.name,
                              style: TextStyle(fontSize: 20),
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
//                          widget.item.isWishlist
//                              ? SvgPicture.asset(
//                                  'images/icon_fav_blue.svg',
//                                  height: 20.0,
//                                  width: 20.0,
//                                  allowDrawingOutsideViewBox: true,
//                                )
//                              : SvgPicture.asset(
//                                  'images/icon_fav_grey.svg',
//                                  height: 20.0,
//                                  width: 20.0,
//                                  allowDrawingOutsideViewBox: true,
//                                )
                        ],
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Text(
                        "# " + widget.item.id.toString(),
                        style: TextStyle(fontSize: 12, color: Colors.grey[400]),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Row(
                        children: <Widget>[
                          RichText(
                            text: new TextSpan(
                              text: widget.item.newPrice.toString() +
                                  ' ' +
                                  widget.item.price.currency +
                                  '  ',
                              style: new TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black),
                              children: <TextSpan>[
                                widget.item.oldPrice == widget.item.newPrice
                                    ? TextSpan()
                                    : TextSpan(
                                        text: widget.item.oldPrice.toString() +
                                            ' ' +
                                            widget.item.price.currency,
                                        style: new TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: Colors.black,
                                          decoration:
                                              TextDecoration.lineThrough,
                                        )),
                              ],
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          SmoothStarRating(
                              allowHalfRating: false,
                              onRated: (value) {
//                                            _rating = value;
                              },
                              starCount: 5,
                              rating: widget.item.ratingPercent != null
                                  ? widget.item.ratingPercent.toDouble()
                                  : 0,
                              size: 15.0,
                              isReadOnly: true,
                              color: Colors.deepOrangeAccent,
                              borderColor: Colors.deepOrangeAccent,
                              spacing: 0.0),
                          // Icon(
                          //   Icons.home,
                          //   color: Colors.red[700],
                          // )
                        ],
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Row(
                        children: [
                          InkWell(
                            onTap: () {
                              widget.removeCallback(widget.index);
                            },
                            child: SvgPicture.asset(
                              'images/cart_remove_icon.svg',
                              height: 30.0,
                              width: 30.0,
                              allowDrawingOutsideViewBox: true,
                            ),
                          ),
                          SizedBox(
                            width: 4,
                          ),
                          InkWell(
                            onTap: () {
                              widget.removeCallback(widget.index);
                            },
                            child: Text(
                              AppLocalizations.of(context).translate('remove'),
                              style: TextStyle(fontSize: 12),
                            ),
                          ),
                          SizedBox(
                            width: 6,
                          ),
                          Container(
                            height: 30.0,
                            width: 1.0,
                            color: Colors.grey,
                            margin:
                                const EdgeInsets.only(left: 10.0, right: 10.0),
                          ),
                          Spacer(),
                          InkWell(
                            onTap: () {
                              setState(() {
                                if (widget.item.count != 1) {
                                  widget.item.count--;
                                  _updateItem(widget.item);
                                }
                              });
                            },
                            child: SvgPicture.asset(
                              'images/icon_minus.svg',
                              height: 23.0,
                              width: 23.0,
                              allowDrawingOutsideViewBox: true,
                            ),
                          ),
//                                            Icon(
//                                              Icons.remove,
//                                              color: Colors.blue,
//                                            ),
                          SizedBox(
                            width: 8,
                          ),
                          Column(
                            children: [
                              Text(
                                widget.item.count.toString(),
                                style: TextStyle(color: Colors.black),
                              ),
                              SizedBox(
                                height: 2,
                              ),
                              Container(
                                height: 1.0,
                                width: 30.0,
                                color: Colors.grey,
                              ),
                            ],
                          ),
                          SizedBox(
                            width: 8,
                          ),
                          InkWell(
                            onTap: () {
                              setState(() {
                                widget.item.count++;
                                _updateItem(widget.item);
                              });
                            },
                            child: SvgPicture.asset(
                              'images/icon_add.svg',
                              height: 23.0,
                              width: 23.0,
                              allowDrawingOutsideViewBox: true,
                            ),
                          ),
                          SizedBox(
                            width: 4,
                          ),
//                                            Icon(
//                                              Icons.add,
//                                              color: Colors.blue,
//                                            )
                        ],
                      ),
                      SizedBox(
                        height: 8,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          )),
    );
  }

  void _updateItem(updatedItem) async {
    Cart cashedCart = await readFromCash();
    if (cashedCart != null && cashedCart.items != null) {
      for (int i = 0; i < cashedCart.items.length; i++) {
        if (cashedCart.items[i].id == updatedItem.id) {
          cashedCart.items[i] = updatedItem;
          break;
        }
      }
      widget.callback(cashedCart.items);
      await _storage.write(key: "cart", value: json.encode(cashedCart));
    }
  }

  Future<Cart> readFromCash() async {
    String value = await _storage.read(key: "cart");
    if (value != null) return Cart.fromJson(json.decode(value));
    return null;
  }
}
