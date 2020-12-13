class SearchResponse {
  String msg;
  bool status;
  SearchResultDataResponse data;

  SearchResponse({this.msg, this.status, this.data});

  SearchResponse.fromJson(Map<String, dynamic> json) {
    data = json['data'] != null
        ? new SearchResultDataResponse.fromJson(json['data'])
        : null;
    status = json['status'];
    msg = json['msg'];
  }
}

class SearchReq {
  String lang;
  String token;
  String word;
  int page;
  int type;

  SearchReq(this.lang, this.token, this.word, this.page, this.type);

  Map<String, dynamic> searchToMap() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['lang'] = lang;
    data['token'] = token;
    data['keyword'] = word;
    data['page'] = page;
    data['type'] = type;
    return data;
  }

  Map<String, dynamic> getProductsToMap() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['lang'] = lang;
    data['token'] = token;
    data['category_id'] = word;
    data['page'] = page;
    return data;
  }
}

class FilterReq {
  String lang;
  String token;
  String word;
  var priceFrom;
  var priceTo;
  int isUsed;
  var catId;
  int rating0;
  int rating1;
  int rating2;
  int rating3;
  int rating4;

  FilterReq(
      {this.lang,
      this.token,
      this.word,
        this.isUsed,
      this.priceFrom,
      this.priceTo,
      this.catId,
      this.rating0,
      this.rating1,
      this.rating2,
      this.rating3,
      this.rating4});

  Map<String, dynamic> filterMap() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['lang'] = lang;
    data['token'] = token;
    data['is_used'] = isUsed;
    data['keyword'] = word;
    data['price_from'] = priceFrom;
    data['price_to'] = priceTo;
    if (rating0 != null) data['rating[0]'] = rating0;
    if (rating1 != null) data['rating[1]'] = rating1;
    if (rating2 != null) data['rating[2]'] = rating2;
    if (rating3 != null) data['rating[3]'] = rating3;
    if (rating4 != null) data['rating[4]'] = rating4;
    data['catid'] = catId;
    return data;
  }
}

class SearchResultDataResponse {
  List<ProductOrService> productOrService;
  int total;

  SearchResultDataResponse({this.productOrService, this.total});

  SearchResultDataResponse.fromJson(Map<String, dynamic> json) {
    total = json['total'];
    if (json['items'] == null) {
      if (json['products'] != null) {
        productOrService = new List<ProductOrService>();
        json['products'].forEach((v) {
          productOrService.add(new ProductOrService.fromJson(v));
        });
      }
    } else {
      if (json['items'] != null) {
        productOrService = new List<ProductOrService>();
        json['items'].forEach((v) {
          productOrService.add(new ProductOrService.fromJson(v));
        });
      }
    }
  }
}

class ProductOrService {
  int id;
  String name;
  var rating;
  String mainImage;
  String offerType; //fixed, percentage
  var oldPrice;
  var newPrice;
  var offerPercent; // digit without %
  Image image;
  Price price;
  String isUsed;
  bool isFav;

  ProductOrService.fromJson(Map<String, dynamic> json) {
    mainImage = json['main_image'];
    isUsed=json['is_used'];
    image = mainImage != null
        ? json['base_image'] != null
            ? new Image.fromJson(json['base_image'])
            : null
        : new Image(
            "http://5himaka.adology-solutions.com/storage/media/s3SGqmWIuCusJZnBZFnnnc2BxTx90lW8J0A9lSDY.jpeg");
    price = json['price'] != null ? new Price.fromJson(json['price']) : null;
    id = json['id'];
    name = json['name'];
    oldPrice = json['old_price'];
    newPrice = json['new_price'];
    rating = json['rating_percent'];
    isFav = json['is_wishlist'];
    offerType = json['special_price_type'];
    offerPercent = json['special_price_percent'];
  }
}

class Image {
  int id;
  String path;

  Image(this.path);

  Image.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    path = json['path'];
  }
}

class Price {
  String currency;
  String amount;

  Price.fromJson(Map<String, dynamic> json) {
    currency = json['currency'];
    amount = json['amount'];
  }
}
