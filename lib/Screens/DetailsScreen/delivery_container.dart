import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:himaka/Models/product_service_details_response.dart';

class DeliveryContainer extends StatefulWidget {
  DeliveryInfo deliveryInfo;
  DeliveryContainer(this.deliveryInfo);

  @override
  _DeliveryContainerState createState() => _DeliveryContainerState();
}

class _DeliveryContainerState extends State<DeliveryContainer> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          flex: 2,
          child: ListView(
            children: [
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Row(
                  children: [
                    SvgPicture.asset(
                      'images/send_himaka.svg',
                      height: 20.0,
                      width: 20.0,
                      allowDrawingOutsideViewBox: true,
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Flexible(child: Text(widget.deliveryInfo.the5Himaka))
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Row(
                  children: [
                    SvgPicture.asset(
                      'images/icon_delivery.svg',
                      height: 20.0,
                      width: 20.0,
                      allowDrawingOutsideViewBox: true,
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Flexible(
                        child: Text(widget.deliveryInfo.deliveryInformation))
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Row(
                  children: [
                    SvgPicture.asset(
                      'images/icon_return.svg',
                      height: 20.0,
                      width: 20.0,
                      allowDrawingOutsideViewBox: true,
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Flexible(child: Text(widget.deliveryInfo.returnPolicy))
                  ],
                ),
              ),
            ],
          ),
        ),
//         Spacer(),
//        Padding(
//          padding: const EdgeInsets.all(8.0),
//          child: Container(
//              width: MediaQuery.of(context).size.width,
//              child: Text('Related Items')),
//        ),
//        Expanded(
//          flex: 4,
//          child: Padding(
//              padding: const EdgeInsets.all(8.0),
//              child: ListView.separated(separatorBuilder: (context, index) => SizedBox(height: 5,),
//                scrollDirection: Axis.horizontal,
//                itemCount: 9,
//                itemBuilder: (context, index) => Padding(
//                  padding: EdgeInsets.all(1.0),
//                  child: InkWell(
//                    onTap: () {
//                    },
//                    child: Container(
//                      child: Card(
//                        clipBehavior: Clip.antiAlias,
//                        child: InkWell(
//                          onTap: () {
//                            print('Card tapped.');
//                          },
//                          child:
//                          Container(
//                            width: 160.0,
//                            child: Card(
//                              clipBehavior: Clip.antiAlias,
//                              child: InkWell(
//                                onTap: () {
//
////                              Navigator.push(
////                                  context,
////                                  new MaterialPageRoute(
////                                      builder: (
////                                          context) => new DetailsScreen()));
//
////                                    Navigator.pushNamed(
////                                        context, '/products',
////                                        arguments: i);
//                                },
//                                child: Column(
//                                  crossAxisAlignment:
//                                  CrossAxisAlignment.end,
//                                  children: <Widget>[
//                                    Container(child: Icon(Icons.favorite_border , color: Colors.blue,),),
//                                    SizedBox(
//                                      height: 50,
//                                      child: CachedNetworkImage(
//                                        fit: BoxFit.fill,
//                                        imageUrl: "https://static.digit.in/default/thumb_97296_default_td_480x480.jpeg",
//                                        placeholder: (context, url) =>
//                                            Center(
//                                                child:
//                                                CircularProgressIndicator()),
//                                        errorWidget:
//                                            (context, url, error) =>
//                                        new Icon(Icons.error),
//                                      ),
//                                    ),
//                                    SizedBox(height: 20,),
//                                    Align(
//                                      alignment: Alignment.centerLeft,
//                                      child: Column(
//                                        crossAxisAlignment: CrossAxisAlignment.start,
//                                        children: [
//                                          Text(
//                                            'Two Gold Rings',
//                                            style: TextStyle(color: Colors.black , fontSize: 14 , fontWeight: FontWeight.bold),
//                                          ),
//                                          Text('#200',
//                                              style: TextStyle(
//                                                color: Colors.grey,
//                                              ))
//                                        ],
//                                      ),
//                                    ),
//                                    Row(
//                                        children: [
//                                          RichText(
//
//                                            text: new TextSpan(
//                                              text: '700\$    ',
//                                              style: new TextStyle( fontWeight: FontWeight.bold ,  color: Colors.black),
//
//                                              children: <TextSpan>[
//                                                new TextSpan(
//                                                    text: '900\$',
//                                                    style: new TextStyle( fontWeight: FontWeight.bold, color: Colors.black , decoration: TextDecoration.lineThrough,)
//                                                ),
//                                              ],
//                                            ),
//                                          ),
//                                          Expanded(
//                                            child: Align(
//                                              alignment: Alignment.centerRight,
//                                              child: Container(
//                                                width: 51,
//                                                height: 51,
//                                                decoration: BoxDecoration(
//                                                  border: Border.all(width: 3 , color: Colors.orange),
//                                                  borderRadius: BorderRadius.all(
//                                                    Radius.circular(600),
//
//                                                  ),
//                                                  color: Colors.orange,
//                                                ),
//                                                child: Center(child: Text('-55%' , style: TextStyle(color: Colors.white , fontSize: 11 , fontWeight: FontWeight.bold),)),
//                                              ),
//                                            ),
//                                          )
//                                        ]
//                                    ),
//                                    Align(
//                                      alignment: Alignment.centerLeft,
//                                      child: SmoothStarRating(
//                                          allowHalfRating: false,
//                                          onRated: (value) {
////                                            _rating = value;
//                                          },
//                                          starCount: 5,
//                                          rating: 4,
//                                          size: 15.0,
//                                          isReadOnly:true,
//                                          color: Colors.deepOrangeAccent,
//                                          borderColor: Colors.deepOrangeAccent,
//                                          spacing:0.0
//
//                                      ),
//                                    ),
//                                    SizedBox(height: 12,),
//                                    Expanded(
//                                      child: Container(
//                                        width: double.infinity,
//                                        color: Colors.blue,
//                                        child: Center(child: Text('Add to cart' , style: TextStyle(color: Colors.white),)),),
//                                    )
//                                  ],
//                                ),
//                              ),
//                            ),
//                          ),
//
//                        ),
//                      ),
//                    ),
//                  ),
//                ),)
//          ),
//        ),
      ],
    );
  }
}
