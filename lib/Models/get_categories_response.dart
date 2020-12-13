import 'package:himaka/Models/search_response.dart';

class GetCategoriesResponse {
  String msg;
  List<String> errors;
  bool status;
  GetCategoriesData data;
  GetCategoriesResponse.fromJson(Map<String, dynamic> json) {
    data = json['data'] != null
        ? new GetCategoriesData.fromJson(json['data'])
        : null;
    status = json['status'];
    if (json['errors'] != null) {
      errors = new List<String>();
      json['errors'].forEach((v) {
        errors.add(v);
      });
    }
    msg = json['msg'];
  }
}

class GetCategoriesReq {
  String lang;
  String token;
  int catType;

  GetCategoriesReq(this.lang, this.token, this.catType);

  Map<String, dynamic> getCategoriesToMap() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['lang'] = lang;
    data['token'] = token;
    data['category_id'] = catType; // 1 products, 2 services
    return data;
  }
}

class GetCategoriesData {
  List<Category> mainCategories;
  GetCategoriesData.fromJson(Map<String, dynamic> json) {
    if (json['MainCategories'] != null) {
      mainCategories = new List<Category>();
      json['MainCategories'].forEach((v) {
        mainCategories.add(new Category.fromJson(v));
      });
    }
  }
}

class Category {
  int id;
  String name;
  String slug;
  Image image;
  List<Category> subCategory;
  List<ProductOrService> products;

  Category.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    slug = json['slug'];
    name = json['name'];
    if (json['sub_categories'] != null) {
      subCategory = new List<Category>();
      json['sub_categories'].forEach((v) {
        subCategory.add(new Category.fromJson(v));
      });
    }
    if (json['products'] != null) {
      products = new List<ProductOrService>();
      json['products'].forEach((v) {
        products.add(new ProductOrService.fromJson(v));
      });
    }
  }
}
