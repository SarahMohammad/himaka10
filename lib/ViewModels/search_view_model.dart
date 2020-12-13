import 'package:himaka/Models/FavResponse.dart';
import 'package:himaka/Models/search_response.dart';
import 'package:himaka/ViewModels/base_model.dart';
import 'package:himaka/services/api.dart';
import 'package:himaka/services/locator.dart';
import 'package:himaka/utils/globals.dart';

class SearchViewModel extends BaseModel {
  Api _api = locator<Api>();
  SearchResponse _searchResponse;
  FavResponse _favResponse;
  List<ProductOrService> _productOrService;
  int _page = 0;
  int _total = 0;
  bool _isLoading = false;
  int _type = 3; // 1 product, 2 service

  String _visibleItemsCount = "";

  String get visibleItemsCount => _visibleItemsCount;

  set visibleItemsCount(String value) {
    _visibleItemsCount = value;
    notifyListeners();
  }

  Future addFav(String lang, int productId, int fav, String word) async {
//    _serviceId = 2;
    print(lang);
    Map<String, dynamic> data = {
      "token": Globals.userData.token,
      'lang': lang,
      'product_id': productId,
      'isFav': fav
    };
    _favResponse = await _api.addProductServiceFav(data);

    if (_favResponse != null) {
      pullToRefresh();
      search(lang, word);
    }
  }

  Future search(String lang, String word) async {
    setState(ViewState.Busy);
    SearchReq req =
        new SearchReq(lang, Globals.userData.token, word, _page, _type);
    SearchResponse temp = await _api.search(req.searchToMap());
    _searchResponse = temp;
    if (_total == 0 && temp != null && temp.data != null)
      _total = temp.data.total;
    if (temp != null) if (temp.data != null &&
        temp.data.productOrService != null)
      incrementPage(temp.data.productOrService);
    _isLoading = false;
    setState(ViewState.Idle);
  }

  Future getProducts(String lang, int catId) async {
    setState(ViewState.Busy);
    SearchReq req = new SearchReq(
        lang, Globals.userData.token, catId.toString(), _page, _type);
    SearchResponse temp = await _api.getProducts(req.getProductsToMap());
    _searchResponse = temp;
    if (_total == 0 && temp != null && temp.data != null)
      _total = temp.data.total;
    if (temp != null) if (temp.data != null &&
        temp.data.productOrService != null)
      incrementPage(temp.data.productOrService);
    _isLoading = false;
    setState(ViewState.Idle);
  }

  Future filter(String lang, String word, var priceFrom, var priceTo, var catId,
      List<int> rating, int isUsed) async {
    setState(ViewState.Busy);
    FilterReq req = new FilterReq(
        lang: lang,
        word: word,
        isUsed: isUsed,
        token: Globals.userData.token,
        priceFrom: priceFrom,
        priceTo: priceTo,
        catId: catId == -1 ? "" : catId);
    if (rating.length > 0) req = setFilterReq(req, rating);
    SearchResponse temp = await _api.filter(req.filterMap());
    _searchResponse = temp;
    if (_total == 0 && temp != null && temp.data != null)
      _total = temp.data.total;
    if (temp != null) if (temp.data != null &&
        temp.data.productOrService != null)
      incrementPage(temp.data.productOrService);
    _isLoading = false;
    setState(ViewState.Idle);
  }

  FilterReq setFilterReq(FilterReq req, List<int> rating) {
    for (int i = 0; i < rating.length; i++) {
      if (rating[i] == 0) {
        req.rating0 = 0;
      } else if (rating[i] == 1) {
        req.rating1 = 1;
      } else if (rating[i] == 2) {
        req.rating2 = 2;
      } else if (rating[i] == 3) {
        req.rating3 = 3;
      } else if (rating[i] == 4) {
        req.rating4 = 4;
      }
    }
    return req;
  }

  incrementPage(List<ProductOrService> allProducts) {
    if (_productOrService == null) {
      _productOrService = allProducts;
    } else {
      if (allProducts.length > 0) {
        _productOrService.addAll(allProducts);
      }
    }
    if (canIncrement()) _page++;
  }

  bool canIncrement() {
    if (_total == 0 || (_total / 10) > _page) {
      return true;
    }
    return false;
  }

  void pullToRefresh() {
    _page = 0;
    _searchResponse = null;
    _productOrService = null;
  }

  List<ProductOrService> get productOrService => _productOrService;

  set type(int value) {
    _type = value;
  }

  set isLoading(bool value) {
    _isLoading = value;
  }

  set total(int value) {
    _total = value;
  }

  bool get isLoading => _isLoading;

  int get page => _page;

  int get total => _total;
}
