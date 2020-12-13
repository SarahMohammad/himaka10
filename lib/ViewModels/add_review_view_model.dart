import 'package:himaka/Models/add_review_response.dart';
import 'package:himaka/Models/home_response.dart';
import 'package:himaka/Models/orders_response.dart';
import 'package:himaka/services/api.dart';
import 'package:himaka/services/locator.dart';
import 'package:himaka/utils/globals.dart';

import 'base_model.dart';

class AddReviewViewModel extends BaseModel {
  AddReviewResponse _addReviewResponse;

  Api _api = locator<Api>();

  Future addReview(int id, String comment, int rate, String lang) async {
    setState(ViewState.Busy);
    Map<String, dynamic> data = {
      "lang":lang,
      "token": Globals.userData.token,
      'item_id': id,
      'comment': comment,
      'rating': rate.toString(),
    };
    _addReviewResponse = await _api.addReviewApi(data);
    setState(ViewState.Idle);
  }

  AddReviewResponse get addReviewResponse => _addReviewResponse;
}
