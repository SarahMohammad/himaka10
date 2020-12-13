import 'package:himaka/Models/add_complaint_pre_response.dart';
import 'package:himaka/Models/complaints_response.dart';

import '../Models/home_response.dart';
import '../Models/orders_response.dart';
import '../services/api.dart';
import '../services/locator.dart';
import '../utils/globals.dart';
import 'base_model.dart';

class ComplaintsHistoryViewModel extends BaseModel {
  GetComplaintsResponse _complaintsResponse;
  AddComplaintPreResponse _addComplaintPreResponse;
  bool _detailsValidate = true;
  bool _orderValidate = true;
  bool _productValidate = true;
  int _serviceId=1;

  Api _api = locator<Api>();

  Future getComplaints(String lang) async {
    setState(ViewState.Busy);
    Map<String, dynamic> token = {"token": Globals.userData.token};
    _complaintsResponse = await _api.getComplaints(token);
    setState(ViewState.Idle);
  }

  Future addComplaintPre(String lang) async {
    _serviceId=1;
    setState(ViewState.Busy);
    Map<String, dynamic> token = {"token": Globals.userData.token};
    _addComplaintPreResponse = await _api.addComplaintPre(token);
    setState(ViewState.Idle);
  }

  Future<AddComplaintPreResponse> addComplaint(
      String lang, String details, int orderId, int productId) async {
    _serviceId=2;
    setState(ViewState.Busy);
    Map<String, dynamic> data = {
      "token": Globals.userData.token,
      'lang': lang,
      'details': details,
      'order_id': orderId,
      'product_id': productId
    };
    AddComplaintPreResponse response = await _api.addComplaint(data);
    setState(ViewState.Idle);
    return response;
  }
  bool addComplaintValidation(String details,Order order,Offer product ) {
    bool validate = true;
    if (details.isEmpty) {
      _detailsValidate = false;
      validate = false;
    } else {
      _detailsValidate = true;
    }
    if (order==null) {
      _orderValidate = false;
      validate = false;
    } else {
      _orderValidate = true;
    }
    if (product==null) {
      _productValidate = false;
      validate = false;
    } else {
      _productValidate = true;
    }

    notifyListeners();
    return validate;
  }

  List<Offer> getOrderProducts(int id) {
    List<Offer> result = new List<Offer>();
    if (id != null) {
      Order _order = _addComplaintPreResponse.data.orders
          .firstWhere((element) => element.id == id);
      print(_order.toString());
      if (_order != null)
        return _order.products;
      else
        return result;
    }
    return result;
  }


  int get serviceId => _serviceId;

  bool get detailsValidate => _detailsValidate;

  AddComplaintPreResponse get addComplaintPreResponse =>
      _addComplaintPreResponse;

  GetComplaintsResponse get complaintsResponse => _complaintsResponse;

  bool get orderValidate => _orderValidate;

  bool get productValidate => _productValidate;
}
