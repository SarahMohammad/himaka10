import 'package:get_it/get_it.dart';
import 'package:himaka/ViewModels/add_product_or_service_view_model.dart';
import 'package:himaka/ViewModels/add_review_view_model.dart';
import 'package:himaka/ViewModels/auth_view_model.dart';
import 'package:himaka/ViewModels/banner_products_view_model.dart';
import 'package:himaka/ViewModels/complaints_history_view_model.dart';
import 'package:himaka/ViewModels/customer_support_view_model.dart';
import 'package:himaka/ViewModels/filter_view_model.dart';
import 'package:himaka/ViewModels/get_categories_view_model.dart';
import 'package:himaka/ViewModels/home_view_model.dart';
import 'package:himaka/ViewModels/orders_view_model.dart';
import 'package:himaka/ViewModels/personal_wallet_view_model.dart';
import 'package:himaka/ViewModels/product_service_details_view_model.dart';
import 'package:himaka/ViewModels/profile_view_model.dart';
import 'package:himaka/ViewModels/search_view_model.dart';
import 'package:himaka/ViewModels/upgrade_view_model.dart';
import 'package:himaka/ViewModels/wallet_view_model.dart';
import 'package:himaka/ViewModels/wish_list_view_model.dart';
import 'package:himaka/utils/AppLanguage.dart';

import 'api.dart';
import 'authentication_service.dart';

GetIt locator = GetIt();

void setupLocator() {
  locator.registerLazySingleton(() => AuthenticationService());
  locator.registerFactory(() => Api());
  locator.registerLazySingleton(() => AppLanguage());
  locator.registerFactory(() => AuthViewModel());
  locator.registerFactory(() => HomeViewModel());
  locator.registerFactory(() => WishListViewModel());

  locator.registerFactory(() => SearchViewModel());
  locator.registerFactory(() => FilterViewModel());
  locator.registerFactory(() => OrdersViewModel());
  locator.registerFactory(() => CustomerSupportViewModel());
  locator.registerFactory(() => ProfileViewModel());
  locator.registerFactory(() => ProductServiceDetailsViewModel());
  locator.registerFactory(() => AddReviewViewModel());
  locator.registerFactory(() => AddProductOrServiceViewModel());
  locator.registerFactory(() => GetCategoriesViewModel());
  locator.registerFactory(() => PersonalWalletViewModel());
  locator.registerFactory(() => UpgradeViewModel());
  locator.registerFactory(() => WalletViewModel());
  locator.registerFactory(() => BannerProductsViewModel());
  locator.registerFactory(() => ComplaintsHistoryViewModel());
}
