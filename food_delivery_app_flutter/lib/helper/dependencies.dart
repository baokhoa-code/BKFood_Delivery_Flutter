import 'package:food_delivery_app_flutter/controllers/auth_controller.dart';
import 'package:food_delivery_app_flutter/controllers/cart_controller.dart';
import 'package:food_delivery_app_flutter/controllers/location_controller.dart';
import 'package:food_delivery_app_flutter/controllers/popular_product_controller.dart';
import 'package:food_delivery_app_flutter/controllers/recommended_product_controller.dart';
import 'package:food_delivery_app_flutter/controllers/user_controller.dart';
import 'package:food_delivery_app_flutter/data/api/api_client.dart';
import 'package:food_delivery_app_flutter/data/repository/cart_repo.dart';
import 'package:food_delivery_app_flutter/data/repository/location_repo.dart';
import 'package:food_delivery_app_flutter/data/repository/popular_product_repo.dart';
import 'package:food_delivery_app_flutter/data/repository/recommended_product_repo.dart';
import 'package:food_delivery_app_flutter/data/repository/user_repo.dart';
import 'package:food_delivery_app_flutter/utils/app_constants.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../data/repository/auth_repo.dart';

Future<void> init() async {
  final sharedPreferences = await SharedPreferences.getInstance();

  Get.lazyPut(() => sharedPreferences);

  Get.lazyPut(() => ApiClient(
      appBaseUrl: AppConstants.BASE_URL, sharedPreferences: Get.find()));
  Get.lazyPut(
      () => AuthRepo(apiClient: Get.find(), sharedPreferences: Get.find()));
  Get.lazyPut(() => UserRepo(apiClient: Get.find()));

  Get.lazyPut(() => PopularProductRepo(apiClient: Get.find()));
  Get.lazyPut(() => RecommendedProductRepo(apiClient: Get.find()));
  Get.lazyPut(() => CartRepo(sharedPreferences: Get.find()));
  Get.lazyPut(
      () => LocationRepo(apiClient: Get.find(), sharedPreferences: Get.find()));

  Get.lazyPut(() => AuthController(authRepo: Get.find()));
  Get.lazyPut(() => UserController(userRepo: Get.find()));
  Get.lazyPut(() => PopularProductController(popularProductRepo: Get.find()));
  Get.lazyPut(
      () => RecommendedProductController(recommendedProductRepo: Get.find()));
  Get.lazyPut(() => CartController(cartRepo: Get.find()));
  Get.lazyPut(() => LocationContronller(locationRepo: Get.find()));
}
