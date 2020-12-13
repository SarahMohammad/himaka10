class PrepAddProductOrService{
  String msg;
  String errors;
  bool status;
  PrepAddProductOrServiceData data;

  PrepAddProductOrService.fromJson(Map<String, dynamic> json) {
    data = json['data'] != null
        ? new PrepAddProductOrServiceData.fromJson(json['data'])
        : null;
    status = json['status'];
    errors = json['errors'];
    msg = json['msg'];
  }

}
class PrepAddReq{
  String lang;
  String token;

  PrepAddReq(this.lang, this.token);

  Map<String, dynamic> prepAddToMap() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['lang'] = lang;
    data['token'] = token;
    return data;
  }
}
class PrepAddProductOrServiceData{
  List<PrepCategory> productCategories;
  List<PrepCategory> serviceCategories;
  PrepAddProductOrServiceData.fromJson(Map<String, dynamic> json) {
    if (json['products'] != null) {
      productCategories = new List<PrepCategory>();
      json['products'].forEach((v) {
        productCategories.add(new PrepCategory.fromJson(v));
      });
    }
    if (json['services'] != null) {
      serviceCategories = new List<PrepCategory>();
      json['services'].forEach((v) {
        serviceCategories.add(new PrepCategory.fromJson(v));
      });
    }
  }

}
class PrepCategory{
  int id;
  String name;
  PrepCategory.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
  }

}