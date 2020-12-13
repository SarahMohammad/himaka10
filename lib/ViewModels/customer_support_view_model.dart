import 'package:himaka/Models/customer_support_response.dart';
import 'package:himaka/Models/home_response.dart';
import 'package:himaka/Models/orders_response.dart';
import 'package:himaka/services/api.dart';
import 'package:himaka/services/locator.dart';

import 'base_model.dart';

class CustomerSupportViewModel extends BaseModel {
  CustomerSupportResponse _customerSupportResponse;

  Api _api = locator<Api>();

  Future getCustomerSupport() async {
    setState(ViewState.Busy);
    _customerSupportResponse = await _api.getCustomerSupportApi();
    setState(ViewState.Idle);
  }

  CustomerSupportResponse get customerSupportResponse =>
      _customerSupportResponse;
}
