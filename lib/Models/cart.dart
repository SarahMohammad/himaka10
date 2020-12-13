import 'package:himaka/Models/product_service_details_response.dart';

class Cart {
  List<Item> items;


  Cart({this.items});

  Cart.fromJson(Map<String, dynamic> json) {
    if (json['items'] != null) {
      items = new List<Item>();
      json['items'].forEach((item) {
        items.add(new Item.fromJson(item));
      });
    }
  }

  Map<String, dynamic> toJson() => {
        "items": List<dynamic>.from(items.map((x) => x.toJson())),
      };
}
