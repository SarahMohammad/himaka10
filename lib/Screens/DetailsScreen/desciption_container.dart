import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:himaka/Models/product_service_details_response.dart';
import 'package:himaka/utils/app_localizations.dart';
import 'package:smooth_star_rating/smooth_star_rating.dart';

class DescriptionContainer extends StatefulWidget {
  String desc;
  List<Item> related_products;

  @override
  _DescriptionContainerState createState() => _DescriptionContainerState();

  DescriptionContainer({this.desc, this.related_products});
}

class _DescriptionContainerState extends State<DescriptionContainer> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          flex: 3,
          child: ListView(
            children: [
              Card(
                color: Colors.white,
                elevation: 3.2,
                child: Text(widget.desc),
              )
            ],
          ),
        ),
//         Spacer(),
        widget.related_products.length != 0
            ? Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                    width: MediaQuery.of(context).size.width,
                    child: Text(AppLocalizations.of(context)
                        .translate('related_items'))),
              )
            : Container(),
        widget.related_products.length != 0
            ? Expanded(
                flex: 3,
                child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ListView.separated(
                      separatorBuilder: (context, index) => SizedBox(
                        height: 5,
                      ),
                      scrollDirection: Axis.horizontal,
                      itemCount: widget.related_products.length,
                      itemBuilder: (context, index) => Padding(
                        padding: EdgeInsets.all(1.0),
                        child: InkWell(
                          onTap: () {},
                          child: Container(
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
//                              Navigator.push(
//                                  context,
//                                  new MaterialPageRoute(
//                                      builder: (
//                                          context) => new DetailsScreen()));

//                                    Navigator.pushNamed(
//                                        context, '/products',
//                                        arguments: i);
                                      },
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.end,
                                        children: <Widget>[
                                          Container(
                                            child: Icon(
                                              Icons.favorite_border,
                                              color: Colors.blue,
                                            ),
                                          ),
                                          SizedBox(
                                            height: 50,
                                            child: CachedNetworkImage(
                                              fit: BoxFit.fill,
                                              imageUrl: widget
                                                  .related_products[index]
                                                  .baseImage
                                                  .path,
                                              placeholder: (context, url) => Center(
                                                  child:
                                                      CircularProgressIndicator()),
                                              errorWidget:
                                                  (context, url, error) =>
                                                      new Icon(Icons.error),
                                            ),
                                          ),
                                          SizedBox(
                                            height: 20,
                                          ),
                                          Align(
                                            alignment: Alignment.centerLeft,
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  widget.related_products[index]
                                                      .name,
                                                  style: TextStyle(
                                                      color: Colors.black,
                                                      fontSize: 14,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  maxLines: 2,
                                                ),
                                                Text(
                                                    '#' +
                                                        widget
                                                            .related_products[
                                                                index]
                                                            .id
                                                            .toString(),
                                                    style: TextStyle(
                                                      color: Colors.grey,
                                                    ))
                                              ],
                                            ),
                                          ),
                                          Row(children: [
                                            RichText(
                                              text: new TextSpan(
                                                text: (double.parse(widget
                                                                .related_products[
                                                                    index]
                                                                .price
                                                                .amount)
                                                            .toInt())
                                                        .toString() +
                                                    '\$  ',
                                                style: new TextStyle(
                                                    decoration: widget
                                                                .related_products[
                                                                    index]
                                                                .price
                                                                .amount !=
                                                            widget
                                                                .related_products[
                                                                    index]
                                                                .sellingPrice
                                                                .amount
                                                        ? TextDecoration
                                                            .lineThrough
                                                        : TextDecoration.none,
                                                    fontWeight: FontWeight.bold,
                                                    color: Colors.black),
                                                children: <TextSpan>[
                                                  widget.related_products[index]
                                                              .price.amount !=
                                                          widget
                                                              .related_products[
                                                                  index]
                                                              .sellingPrice
                                                              .amount
                                                      ? new TextSpan(
                                                          text: (double.parse(widget
                                                                          .related_products[
                                                                              index]
                                                                          .sellingPrice
                                                                          .amount)
                                                                      .toInt())
                                                                  .toString() +
                                                              '\$',
                                                          style: new TextStyle(
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            color: Colors.black,
                                                            decoration:
                                                                TextDecoration
                                                                    .none,
                                                          ))
                                                      : TextSpan(text: ""),
                                                ],
                                              ),
                                            ),
                                            widget.related_products[index].price
                                                        .amount !=
                                                    widget
                                                        .related_products[index]
                                                        .sellingPrice
                                                        .amount
                                                ? Expanded(
                                                    child: Align(
                                                      alignment:
                                                          Alignment.centerRight,
                                                      child: Container(
                                                        width: 51,
                                                        height: 51,
                                                        decoration:
                                                            BoxDecoration(
                                                          border: Border.all(
                                                              width: 3,
                                                              color: Colors
                                                                  .orange),
                                                          borderRadius:
                                                              BorderRadius.all(
                                                            Radius.circular(
                                                                600),
                                                          ),
                                                          color: Colors.orange,
                                                        ),
                                                        child: Center(
                                                            child: widget
                                                                        .related_products[
                                                                            index]
                                                                        .price
                                                                        .amount !=
                                                                    widget
                                                                        .related_products[
                                                                            index]
                                                                        .sellingPrice
                                                                        .amount
                                                                ? Text(
                                                                    calculatePerscentage(
                                                                            widget.related_products[index].sellingPrice.amount,
                                                                            widget.related_products[index].price.amount) +
                                                                        '%',
                                                                    style: TextStyle(
                                                                        color: Colors
                                                                            .white,
                                                                        fontSize:
                                                                            11,
                                                                        fontWeight:
                                                                            FontWeight.bold),
                                                                  )
                                                                : Container()),
                                                      ),
                                                    ),
                                                  )
                                                : Container(
                                                    width: 51,
                                                    height: 51,
                                                  )
                                          ]),
                                          Align(
                                            alignment: Alignment.centerLeft,
                                            child: SmoothStarRating(
                                                allowHalfRating: false,
                                                onRated: (value) {
//                                            _rating = value;
                                                },
                                                starCount: 5,
                                                rating: 0,
                                                size: 15.0,
                                                isReadOnly: true,
                                                color: Colors.deepOrangeAccent,
                                                borderColor:
                                                    Colors.deepOrangeAccent,
                                                spacing: 0.0),
                                          ),
                                          SizedBox(
                                            height: 12,
                                          ),
                                          Expanded(
                                            child: Container(
                                              width: double.infinity,
                                              color: Colors.blue,
                                              child: Center(
                                                  child: Text(
                                                'Add to cart',
                                                style: TextStyle(
                                                    color: Colors.white),
                                              )),
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
                        ),
                      ),
                    )),
              )
            : Container(),
      ],
    );
  }

  calculatePerscentage(String sellingPrice, String oldPrice) {
    var percentage = (double.parse(oldPrice) - double.parse(sellingPrice)) /
        (double.parse(oldPrice) * 100);
    return percentage.toString();
  }
}
