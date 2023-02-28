import 'package:food_delivery_app_flutter/pages/cart/cart_page.dart';
import 'package:food_delivery_app_flutter/pages/food/popular_food_detail.dart';
import 'package:food_delivery_app_flutter/pages/food/recommended_food_detail.dart';
import 'package:food_delivery_app_flutter/pages/home/home_page.dart';
import 'package:food_delivery_app_flutter/pages/home/main_food_page.dart';
import 'package:food_delivery_app_flutter/pages/spash/splash_page.dart';
import 'package:get/get.dart';

class RouteHelper {
  static const String splash = "/splash";
  static const String initial = "/";
  static const String popularFood = "/popular-food";
  static const String recommendedFood = "/recommended-food";
  static const String cart = "/cart";

  static String getSplash() => '$splash';
  static String getInitial() => '$initial';
  static String getPopularFood(int pageId, String page) =>
      '$popularFood?pageId=$pageId&page=$page';
  static String getRecommendedFood(int pageId, String page) =>
      '$recommendedFood?pageId=$pageId&page=$page';
  static String getCart() => '$cart';

  static List<GetPage> routes = [
    GetPage(
      name: splash,
      page: () {
        return SplashScreen();
      },
    ),
    GetPage(
        name: initial,
        page: () {
          return HomePage();
        },
        transition: Transition.fadeIn),
    GetPage(
        name: popularFood,
        page: () {
          var pageId = Get.parameters['pageId'];
          var page = Get.parameters['page'];
          return PopularFoodDetail(pageId: int.parse(pageId!), page: page!);
        },
        transition: Transition.fadeIn),
    GetPage(
        name: recommendedFood,
        page: () {
          var pageId = Get.parameters['pageId'];
          var page = Get.parameters['page'];
          return RecommendedFoodDetail(pageId: int.parse(pageId!), page: page!);
        },
        transition: Transition.fadeIn),
    GetPage(
        name: cart,
        page: () {
          return CartPage();
        },
        transition: Transition.fadeIn),
  ];
}
