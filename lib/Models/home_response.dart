// To parse this JSON data, do
//
//     final homeResponse = homeResponseFromJson(jsonString);

import 'dart:convert';

HomeResponse homeResponseFromJson(String str) =>
    HomeResponse.fromJson(json.decode(str));

String homeResponseToJson(HomeResponse data) => json.encode(data.toJson());

class HomeResponse {
  HomeResponse({
    this.status,
    this.msg,
    this.data,
  });

  bool status;
  String msg;
  Data data;

  factory HomeResponse.fromJson(Map<String, dynamic> json) => HomeResponse(
        status: json["status"],
        msg: json["msg"],
        data: Data.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "msg": msg,
        "data": data.toJson(),
      };
}

class Data {
  Data({
    this.offers,
    this.products,
    this.total,
  });

  List<Offer> offers;
  List<Offer> products;
  int total;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        offers: json["offers"] != null
            ? List<Offer>.from(json["offers"].map((x) => Offer.fromJson(x)))
            : null,
        products:
            List<Offer>.from(json["products"].map((x) => Offer.fromJson(x))),
        total: json["total"],
      );

  Map<String, dynamic> toJson() => {
        "offers": List<dynamic>.from(offers.map((x) => x.toJson())),
        "products": List<dynamic>.from(products.map((x) => x.toJson())),
        "total": total,
      };
}

class Offer {
  Offer(
      {this.id,
      this.userId,
      this.brandId,
      this.taxClassId,
      this.slug,
      this.price,
      this.specialPrice,
      this.specialPriceType,
      this.specialPriceStart,
      this.specialPriceEnd,
      this.sellingPrice,
      this.sku,
      this.manageStock,
      this.qty,
      this.inStock,
      this.viewed,
      this.isActive,
      this.newFrom,
      this.newTo,
      this.deletedAt,
      this.createdAt,
      this.updatedAt,
      this.used,
      this.oldPrice,
      this.newPrice,
      this.mainImage,
      this.images,
      this.baseImage,
      this.formattedPrice,
      this.ratingPercent,
      this.isInStock,
      this.isOutOfStock,
      this.isNew,
      this.hasPercentageSpecialPrice,
      this.specialPricePercent,
      this.name,
      this.description,
      this.shortDescription,
      this.translations,
      this.files,
      this.isWishlist,
      this.image});

  String image;
  int id;
  String userId;
  String brandId;
  dynamic taxClassId;
  String slug;
  HomePrice price;
  HomePrice specialPrice;
  SpecialPriceType specialPriceType;
  DateTime specialPriceStart;
  DateTime specialPriceEnd;
  HomePrice sellingPrice;
  dynamic sku;
  bool manageStock;
  dynamic qty;
  bool inStock;
  String viewed;
  bool isActive;
  dynamic newFrom;
  dynamic newTo;
  dynamic deletedAt;
  DateTime createdAt;
  DateTime updatedAt;
  String used;
  int oldPrice;
  var newPrice;
  String mainImage;
  List<String> images;
  dynamic baseImage;
  String formattedPrice;
  dynamic ratingPercent;
  bool isInStock;
  bool isOutOfStock;
  bool isNew;
  bool hasPercentageSpecialPrice;
  double specialPricePercent;
  String name;
  String description;
  dynamic shortDescription;
  List<Translation> translations;
  List<BaseImageElement> files;
  bool isWishlist;

  factory Offer.fromJson(Map<String, dynamic> json) => Offer(
        id: json["id"],
        image: json['image'],
        userId: json["user_id"] == null ? null : json["user_id"],
        brandId: json["brand_id"] == null ? null : json["brand_id"],
        taxClassId: json["tax_class_id"],
        slug: json["slug"],
        price: json['price'] != null ? HomePrice.fromJson(json["price"]) : null,
        specialPrice: json["special_price"] == null
            ? null
            : HomePrice.fromJson(json["special_price"]),
        specialPriceType:
            specialPriceTypeValues.map[json["special_price_type"]],
        specialPriceStart: json["special_price_start"] == null
            ? null
            : DateTime.parse(json["special_price_start"]),
        specialPriceEnd: json["special_price_end"] == null
            ? null
            : DateTime.parse(json["special_price_end"]),
        sellingPrice: json["selling_price"] != null
            ? HomePrice.fromJson(json["selling_price"])
            : null,
        sku: json["sku"],
        manageStock: json["manage_stock"],
        qty: json["qty"],
        inStock: json["in_stock"],
        viewed: json["viewed"],
        isActive: json["is_active"],
        newFrom: json["new_from"],
        newTo: json["new_to"],
//        deletedAt: json["deleted_at"],
//        createdAt: DateTime.parse(json["created_at"]),
//        updatedAt: DateTime.parse(json["updated_at"]),
        used: json["used"],
        oldPrice: json["old_price"],
        newPrice: json["new_price"],
        mainImage: json["main_image"] == null ? null : json["main_image"],
        images: json["images"] != null
            ? List<String>.from(json["images"].map((x) => x))
            : null,
        baseImage: json["base_image"] == null ? null : (json["base_image"]),
        formattedPrice: json["formatted_price"],
        ratingPercent: json["rating_percent"],
        isInStock: json["is_in_stock"],
        isOutOfStock: json["is_out_of_stock"],
        isNew: json["is_new"],
        hasPercentageSpecialPrice: json["has_percentage_special_price"],
        specialPricePercent: json["special_price_percent"] == null
            ? null
            : json["special_price_percent"].toDouble(),
        name: json["name"],
        description: json["description"],
        shortDescription: json["short_description"],
//        translations: json["translations"] != null
//            ? List<Translation>.from(
//                json["translations"].map((x) => Translation.fromJson(x)))
//            : null,
        files: json['files'] != null
            ? List<BaseImageElement>.from(
                json["files"].map((x) => BaseImageElement.fromJson(x)))
            : null,
        isWishlist: json["is_wishlist"] == null ? null : json["is_wishlist"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "user_id": userId == null ? null : userId,
        "brand_id": brandId == null ? null : brandId,
        "tax_class_id": taxClassId,
        "slug": slug,
        "price": price.toJson(),
        "special_price": specialPrice == null ? null : specialPrice.toJson(),
        "special_price_type": specialPriceTypeValues.reverse[specialPriceType],
        "special_price_start": specialPriceStart == null
            ? null
            : specialPriceStart.toIso8601String(),
        "special_price_end":
            specialPriceEnd == null ? null : specialPriceEnd.toIso8601String(),
        "selling_price": sellingPrice.toJson(),
        "sku": sku,
        "manage_stock": manageStock,
        "qty": qty,
        'image': image,
        "in_stock": inStock,
        "viewed": viewed,
        "is_active": isActive,
        "new_from": newFrom,
        "new_to": newTo,
//        "deleted_at": deletedAt,
//        "created_at": createdAt.toIso8601String(),
//        "updated_at": updatedAt.toIso8601String(),
        "used": used,
        "old_price": oldPrice,
        "new_price": newPrice,
        "main_image": mainImage == null ? null : mainImage,
        "images": List<dynamic>.from(images.map((x) => x)),
        "base_image": baseImage,
        "formatted_price": formattedPrice,
        "rating_percent": ratingPercent,
        "is_in_stock": isInStock,
        "is_out_of_stock": isOutOfStock,
        "is_new": isNew,
        "has_percentage_special_price": hasPercentageSpecialPrice,
        "special_price_percent":
            specialPricePercent == null ? null : specialPricePercent,
        "name": name,
        "description": description,
        "short_description": shortDescription,
//        "translations": List<dynamic>.from(translations.map((x) => x.toJson())),
        "files": List<dynamic>.from(files.map((x) => x.toJson())),
        "is_wishlist": isWishlist == null ? null : isWishlist,
      };
}

class BaseImageElement {
  BaseImageElement({
    this.id,
    this.filename,
    this.path,
  });

  int id;
  String filename;
  String path;

  factory BaseImageElement.fromJson(Map<String, dynamic> json) =>
      BaseImageElement(
        id: json["id"],
        filename: json["filename"],
        path: json["path"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "filename": filename,
        "path": path,
      };
}

class HomePrice {
  HomePrice({
    this.amount,
    this.formatted,
    this.currency,
    this.inCurrentCurrency,
  });

  String amount;
  String formatted;
  String currency;
  InCurrentCurrency inCurrentCurrency;

  factory HomePrice.fromJson(Map<String, dynamic> json) => HomePrice(
        amount: json["amount"],
        formatted: json["formatted"],
        // currency: currencyValues.map[json["currency"]],
        currency: json["currency"],
        inCurrentCurrency:
            InCurrentCurrency.fromJson(json["inCurrentCurrency"]),
      );

  Map<String, dynamic> toJson() => {
        "amount": amount,
        "formatted": formatted,
        // "currency": currencyValues.reverse[currency],
        "currency": currency,
        "inCurrentCurrency": inCurrentCurrency.toJson(),
      };
}

enum Currency { USD }

final currencyValues = EnumValues({"USD": Currency.USD});

class InCurrentCurrency {
  InCurrentCurrency({
    this.amount,
    this.formatted,
    this.currency,
  });

  double amount;
  String formatted;
  Currency currency;

  factory InCurrentCurrency.fromJson(Map<String, dynamic> json) =>
      InCurrentCurrency(
        amount: json["amount"].toDouble(),
        formatted: json["formatted"],
        currency: currencyValues.map[json["currency"]],
      );

  Map<String, dynamic> toJson() => {
        "amount": amount,
        "formatted": formatted,
        "currency": currencyValues.reverse[currency],
      };
}

enum SpecialPriceType { PERCENT, FIXED }

final specialPriceTypeValues = EnumValues(
    {"fixed": SpecialPriceType.FIXED, "percent": SpecialPriceType.PERCENT});

class Translation {
  Translation({
    this.id,
    this.productId,
    this.locale,
    this.name,
    this.description,
    this.shortDescription,
  });

  int id;
  String productId;
  Locale locale;
  String name;
  String description;
  dynamic shortDescription;

  factory Translation.fromJson(Map<String, dynamic> json) => Translation(
        id: json["id"],
        productId: json["product_id"],
        locale: localeValues.map[json["locale"]],
        name: json["name"],
        description: json["description"],
        shortDescription: json["short_description"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "product_id": productId,
        "locale": localeValues.reverse[locale],
        "name": name,
        "description": description,
        "short_description": shortDescription,
      };
}

enum Locale { EN }

final localeValues = EnumValues({"en": Locale.EN});

class EnumValues<T> {
  Map<String, T> map;
  Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    if (reverseMap == null) {
      reverseMap = map.map((k, v) => new MapEntry(v, k));
    }
    return reverseMap;
  }
}
