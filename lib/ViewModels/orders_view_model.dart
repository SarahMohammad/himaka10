import 'package:himaka/Models/client_user_orders.dart';
import 'package:himaka/Models/home_response.dart';
import 'package:himaka/Models/order_details_response.dart';
import 'package:himaka/Models/orders_response.dart';
import 'package:himaka/services/api.dart';
import 'package:himaka/services/locator.dart';
import 'package:himaka/utils/globals.dart';

import 'base_model.dart';

class OrdersViewModel extends BaseModel {
  OrdersResponse _ordersResponse;
  OrderDetailsResponse _orderDetailsResponse;
  ClientUserOrdersResponse _clientUserOrdersResponse;

  Api _api = locator<Api>();

  Future getOrders(String lang, int pathId) async {
    setState(ViewState.Busy);
    Map<String, dynamic> token = {"token": Globals.userData.token};
    if (pathId == 1)
      _ordersResponse = await _api.getOrdersApi(token);
    else
      _clientUserOrdersResponse = await _api.getUserClientOrdersApi(token, pathId);
    setState(ViewState.Idle);
  }

  Future getOrderDetails(String lang, int orderId) async {
    setState(ViewState.Busy);
    Map<String, dynamic> token = {
      "token": Globals.userData.token,
      "lang": lang,
      "order_id": orderId
    };
    _orderDetailsResponse = await _api.getOrderDetailsApi(token);
    setState(ViewState.Idle);
  }

  OrdersResponse get ordersResponse => _ordersResponse;

  OrderDetailsResponse get orderDetailsResponse => _orderDetailsResponse;

  ClientUserOrdersResponse get clientUserOrdersResponse =>
      _clientUserOrdersResponse;
}
