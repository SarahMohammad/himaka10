import 'package:himaka/Models/search_response.dart';

class AddProductResponse {
  String msg;
  bool status;
  List<String> errors;
  AddProductResponseData data;

  AddProductResponse(this.msg, this.status);

  AddProductResponse.fromJson(Map<String, dynamic> json) {
    data = json['data'] != null
        ? new AddProductResponseData.fromJson(json['data'])
        : null;
    status = json['status'];
    msg = json['msg'];
    if (json['errors'] != null) {
      errors = new List<String>();
      json['errors'].forEach((v) {
        errors.add(v);
      });
    }
  }
}

class AddProductReq {
  String lang;
  String token;
  String name;
  String desc;
  var price;
  var discountPrice; // option
  var images;

  AddProductReq(
      this.lang, this.token, this.name, this.desc, this.price, this.images,
      {this.discountPrice});

  Map<String, dynamic> addProductToMap(List<int> categories) {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['lang'] = lang;
    data['token'] = token;
    data['name'] = name;
    data['description'] = desc;
    data['price'] = price;
    if ( discountPrice != "")
      data['discount_percent'] = discountPrice;
    for(int i=0;i<categories.length;i++){
      data['categories[$i]'] = categories[i];
    }
    data['images'] = images;
    return data;
  }
}

class AddProductResponseData {
  ProductOrService productOrService;

  AddProductResponseData.fromJson(Map<String, dynamic> json) {
    productOrService = json['product'] != null
        ? new ProductOrService.fromJson(json['product'])
        : null;
  }
}
