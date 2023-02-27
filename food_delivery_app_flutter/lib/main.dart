import 'package:flutter/material.dart';
import 'package:food_delivery_app_flutter/controllers/popular_product_controller.dart';
import 'package:food_delivery_app_flutter/controllers/recommended_product_controller.dart';
import 'package:food_delivery_app_flutter/helper/route_helper.dart';
import 'package:food_delivery_app_flutter/pages/food/recommended_food_detail.dart';
import 'package:food_delivery_app_flutter/pages/home/food_page_body.dart';
import 'package:food_delivery_app_flutter/pages/home/main_food_page.dart';
import 'package:get/get.dart';
import 'helper/dependencies.dart' as dep;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dep.init();
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    Get.find<PopularProductController>().getPopularProductList();
    Get.find<RecommendedProductController>().getRecommendedProductList();

    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: "BKFood",
      home: MainFoodPage(),
      initialRoute: RouteHelper.initial,
      getPages: RouteHelper.routes,
    );
  }
}
