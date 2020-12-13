import 'dart:io';

import 'package:dio/dio.dart';
import 'package:himaka/Models/add_product_response.dart';
import 'package:himaka/Models/prep_add_product_service.dart';
import 'package:himaka/services/api.dart';
import 'package:himaka/services/locator.dart';
import 'package:himaka/utils/globals.dart';

import 'base_model.dart';

class AddProductOrServiceViewModel extends BaseModel {
  Api _api = locator<Api>();
  bool _titleValidate = true;
  bool _descValidate = true;
  bool _priceValidate = true;
  bool _catValidate = true;
  bool _imagesValidate = true;

  PrepAddProductOrService _productOrService;

  Future prepAddProductService(String lang) async {
    setState(ViewState.Busy);
    PrepAddReq req = new PrepAddReq(lang, Globals.userData.token);
    _productOrService = await _api.prepAddProductOrService(req.prepAddToMap());
    setState(ViewState.Idle);
  }

  bool addValidation(String title, String desc, String price, List<int> catId,
      File image1, File image2, File image3, File image4, File image5) {
    bool validate = true;

    if (title.isEmpty) {
      _titleValidate = false;
      validate = false;
    } else {
      _titleValidate = true;
    }
    if (price.isEmpty) {
      _priceValidate = false;
      validate = false;
    } else {
      _priceValidate = true;
    }
    if (desc.isNotEmpty && desc.length > 4) {
      _descValidate = true;
    } else {
      _descValidate = false;
      validate = false;
    }
    if (catId.length == 0) {
      _catValidate = false;
      validate = false;
    } else {
      _catValidate = true;
    }
    if (image1 == null &&
        image2 == null &&
        image3 == null &&
        image4 == null &&
        image5 == null) {
      _imagesValidate = false;
      validate = false;
    } else {
      _imagesValidate = true;
    }
    notifyListeners();
    return validate;
  }

  Future<AddProductResponse> addProductOrService(
      String lang,
      String name,
      String desc,
      List<int> categories,
      var price,
      var discount,
      File image1,
      File image2,
      File image3,
      File image4,
      File image5) async {
    setState(ViewState.Busy);
    AddProductReq req = new AddProductReq(
        lang,
        Globals.userData.token,
        name,
        desc,
        price,
        await getAddProductImages(image1, image2, image3, image4, image5),
        discountPrice: discount != null ? discount : "");
    AddProductResponse response =
        await _api.addProductOrService(req.addProductToMap(categories));
    setState(ViewState.Idle);
    return response;
  }

  Future<List<MultipartFile>> getAddProductImages(
      File image1, File image2, File image3, File image4, File image5) async {
    List<MultipartFile> gallery = new List<MultipartFile>();
    if (image1 != null) {
      gallery.add(await getImageFile(image1, 1));
    }
    if (image2 != null) {
      gallery.add(await getImageFile(image2, 2));
    }
    if (image3 != null) {
      gallery.add(await getImageFile(image3, 3));
    }
    if (image4 != null) {
      gallery.add(await getImageFile(image4, 4));
    }
    if (image5 != null) {
      gallery.add(await getImageFile(image5, 5));
    }

    return gallery;
  }

  Future<MultipartFile> getImageFile(File image, int num) async {
    // final filePath = await FlutterAbsolutePath.getAbsolutePath(image.toString());
    return await MultipartFile.fromFile(image.path, filename: 'image$num.jpg');
  }

  bool get titleValidate => _titleValidate;

  PrepAddProductOrService get productOrService => _productOrService;

  bool get descValidate => _descValidate;

  bool get priceValidate => _priceValidate;

  bool get catValidate => _catValidate;

  bool get imagesValidate => _imagesValidate;

  set imagesValidate(bool value) {
    _imagesValidate = value;
  }

  set catValidate(bool value) {
    _catValidate = value;
  }
}
