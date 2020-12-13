class PrepFilterResponse{
  String msg;
  String errors;
  bool status;
  PrepFilterData data;

  PrepFilterResponse({this.msg, this.status, this.data});

  PrepFilterResponse.fromJson(Map<String, dynamic> json) {
    data = json['data'] != null
        ? new PrepFilterData.fromJson(json['data'])
        : null;
    status = json['status'];
    errors = json['errors'];
    msg = json['msg'];
  }
}
class PrepReq{
  String lang;
  String token;
  int type;

  PrepReq(this.lang, this.token, this.type);

  Map<String, dynamic> prepFilterToMap() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['lang'] = lang;
    data['token'] = token;
    data['category_id'] = type;// 1 products, 2 services
    return data;
  }
}
class PrepFilterData{
  var minPrice;
  var maxPrice;
  List<MainCategory> mainCategories;
  PrepFilterData.fromJson(Map<String, dynamic> json) {
    if (json['MainCategories'] != null) {
      mainCategories = new List<MainCategory>();
      json['MainCategories'].forEach((v) {
        mainCategories.add(new MainCategory.fromJson(v));
      });
    }
    minPrice = json['min_price'];
    maxPrice = json['max_price'];
  }

}
class MainCategory{
  int id;
  String name;
  String slug;
  MainCategory.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    slug = json['slug'];
    name = json['name'];
  }

}