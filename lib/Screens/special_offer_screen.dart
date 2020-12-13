import 'dart:convert';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_svg/svg.dart';
import 'package:himaka/Models/cart.dart';
import 'package:himaka/Models/login_response.dart';
import 'package:himaka/Models/product_service_details_response.dart';
import 'package:himaka/utils/app_localizations.dart';
import 'package:himaka/utils/globals.dart';
import 'package:himaka/utils/show_toast.dart';

class SpecialOfferScreen extends StatefulWidget {
  Item item;

  SpecialOfferScreen({this.item});

  @override
  State<StatefulWidget> createState() => new _SpecialOfferScreenState();
}

class _SpecialOfferScreenState extends State<SpecialOfferScreen> {
  TextEditingController _pinController = new TextEditingController();
  TextEditingController _answerController = new TextEditingController();
  TextEditingController _priceController = new TextEditingController();
  final _storage = FlutterSecureStorage();
  String key = 'cart';
  String val;
  bool visible = false;
  String confirmedNumber = '';
//  bool _pinValidate = false;
  bool validate = false;
  List<String> users = <String>[
    'In what city did your parents meet?',
    'What is your favorite color?',
    'What is your current job?',
    'What is your favorite team?',
    'What is your favorite movie?',
    'In what town was your first job?',
    'What is the color of your eyes?',
  ];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    textFormConfiguration(context, Globals.userData);
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      backgroundColor: Colors.white,
      appBar: _buildBar(context),
      body: SafeArea(
        child: SingleChildScrollView(
          child:
//          ConstrainedBox(
////            constraints: BoxConstraints(
////              minHeight: viewportConstraints.minHeight,
////            ),
//            child:
              new Container(
                  height: MediaQuery.of(context).size.height,
                  padding: EdgeInsets.all(16.0),
                  child: new Column(
                    children: <Widget>[
                      SizedBox(
                        height: 10,
                      ),
                      SvgPicture.asset(
                        'images/special_offer.svg',
                        height: MediaQuery.of(context).size.height / 2.7,
                        width: MediaQuery.of(context).size.width,
                        allowDrawingOutsideViewBox: true,
                      ),
                      Container(
                        child: Text(
                          AppLocalizations.of(context)
                              .translate('special_offer_msg'),
                          textAlign: TextAlign.center,
                          style: TextStyle(color: Colors.black),
                        ),
                      ),
                      Container(
                        child: new TextField(
                          cursorColor: Colors.black,
                          controller: _priceController,
                          decoration: new InputDecoration(
//                                    errorText: model.priceValidate
//                                        ? null
//                                        : AppLocalizations.of(context)
//                                            .translate('four_validate_error'),
                            contentPadding: EdgeInsets.all(0),
//                                    hintText: 'PIN',
                            labelText: 'Your price',
                            labelStyle: TextStyle(color: Colors.black),

                            // alignLabelWithHint: false,
                            hintStyle: TextStyle(
                              fontSize: 20.0,
                              color: Colors.black,
                            ),
                            enabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.black),
                            ),
                            focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.black),
                            ),
                            prefixIcon: Padding(
                              padding: const EdgeInsets.all(15.0),
                              child: SvgPicture.asset(
                                'images/icon_special_price.svg',
                                height: 5.0,
                                width: 5.0,
                                color: Colors.black,
                                allowDrawingOutsideViewBox: true,
                              ),
                            ),
                          ),
                        ),
                      ),
                      Container(
                        child: new TextField(
                          cursorColor: Colors.black,
                          controller: _pinController,
                          decoration: new InputDecoration(
//                            errorText: validatePin(_pinController.text)
//                                ? null
//                                : AppLocalizations.of(context)
//                                    .translate('four_validate_error'),
                            contentPadding: EdgeInsets.all(0),
//                                    hintText: 'PIN',
                            labelText: 'PIN',

                            labelStyle: TextStyle(color: Colors.black),

                            // alignLabelWithHint: false,
                            hintStyle: TextStyle(
                              fontSize: 20.0,
                              color: Colors.black,
                            ),
                            enabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.black),
                            ),
                            focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.black),
                            ),
                            prefixIcon: Padding(
                              padding: const EdgeInsets.all(15.0),
                              child: SvgPicture.asset(
                                'images/icon_padlock.svg',
                                height: 5.0,
                                width: 5.0,
                                color: Colors.black,
                                allowDrawingOutsideViewBox: true,
                              ),
                            ),
                          ),
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.only(top: 20.0),
                        width: MediaQuery.of(context).size.width,
                        child: DropdownButton<String>(
                          dropdownColor: Colors.grey,
                          icon: Icon(
                            Icons.arrow_drop_down,
                            color: Colors.black,
                          ),
                          isExpanded: true,
                          hint: Text(
                            Globals.userData.question,
                            style: TextStyle(color: Colors.black),
                          ),
                          value: val,
                          onChanged: (String value) {
                            setState(() {
                              val = value;
                            });
                          },
                          items: users.map(
                            (String question) {
                              return DropdownMenuItem<String>(
                                value: question,
                                child: Row(
                                  children: [
                                    SizedBox(
                                      width: 10,
                                    ),
                                    Icon(
                                      Icons.help_outline,
                                      color: Colors.black,
                                    ),
                                    SizedBox(
                                      width: 10,
                                    ),
                                    Text(
                                      question,
                                      style: TextStyle(color: Colors.black),
                                    ),
                                  ],
                                ),
                              );
                            },
                          ).toList(),
                        ),
                      ),
//                      model.quesValidate
//                          ?
                      Container(),
//                          :
//                      Container(
//                        width: double.infinity,
//                        child: Text(
//                          AppLocalizations.of(context).translate('list_error'),
//                          style:
//                              TextStyle(color: Colors.red[700], fontSize: 13),
//                          textAlign: TextAlign.start,
//                        ),
//                      ),
                      Container(
                        child: new TextField(
                          controller: _answerController,
                          decoration: new InputDecoration(
//                            errorText: model.answerValidate
//                                ? null
//                                : AppLocalizations.of(context)
//                                    .translate('four_validate_error'),
                            labelText: 'Answer the question have been chosen',
                            labelStyle: TextStyle(color: Colors.black),
                            prefixIcon: Padding(
                              padding: const EdgeInsets.all(15.0),
                              child: SvgPicture.asset(
                                'images/icon_answers.svg',
                                height: 5.0,
                                width: 5.0,
                                color: Colors.black,
                                allowDrawingOutsideViewBox: true,
                              ),
                            ),
                            enabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.black),
                            ),
                            focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.black),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 30,
                      ),
                      ButtonTheme(
                        minWidth: MediaQuery.of(context).size.width,
                        child: RaisedButton(
                          elevation: 0.0,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          onPressed: () {
//                            if (model.secondSignUpValidation(
//                                _pinController.text.trim(),
//                                val,
//                                _answerController.text.trim())) {
//                              Navigator.push(
//                                  context,
//                                  new MaterialPageRoute(
//                                      builder: (context) =>
//                                          new ThirdStepSignUpScreen(
//                                            firstName: widget.firstName,
//                                            lastName: widget.lastName,
//                                            email: widget.email,
//                                            password: widget.password,
//                                            cPass: widget.cPass,
//                                            mobile: widget.mobile,
//                                            mcode: widget.mcode,
//                                            code: widget.code,
//                                            pin: _pinController.text,
//                                            ques: val,
//                                            answer:
//                                                _answerController.text.trim(),
//                                            data: widget.data,
//                                            nationalId: widget.nationalId,
//                                          )));
//                            }
//

                            validateOfferData(_priceController.text,
                                _pinController.text, _answerController.text);
                          },
                          padding: EdgeInsets.all(20),
                          color: Colors.lightBlueAccent,
                          child: Text('complete your offer',
                              style: TextStyle(color: Colors.white)),
                        ),
                      ),
//                              Expanded(
//                                  child: Align(
//                                      alignment: FractionalOffset.bottomCenter,
//                                      child: RichText(
//                                        textAlign: TextAlign.center,
//                                        text: new TextSpan(
//                                          text:
//                                              'by creating or logging to an account you agree to out ',
//                                          children: <TextSpan>[
//                                            new TextSpan(
//                                                text: 'terms and conditions',
//                                                style: new TextStyle(
//                                                  decoration:
//                                                      TextDecoration.underline,
//                                                )),
//                                            new TextSpan(text: ' and '),
//                                            new TextSpan(
//                                              text: 'privacy policy',
//                                              style: new TextStyle(
//                                                decoration:
//                                                    TextDecoration.underline,
//                                              ),
//                                              recognizer:
//                                                  new TapGestureRecognizer()
//                                                    ..onTap = () =>
//                                                        print('Tap Here onTap'),
//                                            ),
//                                          ],
//                                        ),
//                                      )))
                    ],
                  )),
//          ),
        ),
      ),
    );
  }

  Widget _buildBar(BuildContext context) {
    return new AppBar(
      title: new Text(
        AppLocalizations.of(context).translate('special_offer'),
        style: TextStyle(color: Colors.black),
      ),
      centerTitle: true,
      backgroundColor: Colors.transparent,
      elevation: 0.0,
      actions: [
        IconButton(
            icon: SvgPicture.asset(
              'images/close.svg',
              height: 25.0,
              width: 25.0,
              allowDrawingOutsideViewBox: true,
            ),
            onPressed: () {
              Navigator.of(context).pop();
            })
      ],
    );
  }

  void textFormConfiguration(BuildContext context, LoginUserResponse model) {
//    model.setWorkTimeInitialData(model.loginResponse.homeResult.centerTimeWork);

    _pinController = TextEditingController(text: model.pin.toString());

    _pinController.addListener(() {
      final name = _pinController.text;
      _pinController.value = _pinController.value.copyWith(
        text: name,
      );
    });

    _answerController = TextEditingController(text: model.answer);

    _answerController.addListener(() {
      final name = _answerController.text;
      _answerController.value = _answerController.value.copyWith(
        text: name,
      );
    });
  }

  validateOfferData(String price, String pin, String answer) {
    if (pin.length < 4) {
      validate = false;
      showToast(AppLocalizations.of(context).translate('pin_safety_error'),
          Colors.red);
    } else if (answer.isEmpty) {
      validate = false;
      showToast(AppLocalizations.of(context).translate('answer_question'),
          Colors.red);
    } else if (int.parse(price) < widget.item.newPrice * 0.1) {
      validate = false;
      showToast(AppLocalizations.of(context).translate('price_not_valid'),
          Colors.red);
    } else {
      validate = true;
      //save item (widget.item) with new price (price) to cart

      Item item = new Item(
          id: widget.item.id,
          name: widget.item.name,
          userId: widget.item.userId,
          brandId: widget.item.brandId,
          slug: widget.item.slug,
          isWishlist: widget.item.isWishlist,
          inStock: widget.item.inStock,
          ratingPercent: widget.item.ratingPercent,
          price: new Price(
              amount: widget.item.price.amount,
              formatted: widget.item.price.formatted,
              currency: widget.item.price.currency),
          oldPrice: widget.item.oldPrice,
          newPrice: price,
          count: 1,
          baseImage: new BaseImage(path: widget.item.mainImage));
      _addToCart(item, context);
      Navigator.of(context).pop();
    }
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
