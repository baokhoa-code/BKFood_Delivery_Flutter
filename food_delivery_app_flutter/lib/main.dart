import 'package:flutter/material.dart';
import 'package:food_delivery_app_flutter/controllers/popular_product_controller.dart';
import 'package:food_delivery_app_flutter/controllers/recommended_product_controller.dart';
import 'package:food_delivery_app_flutter/helper/route_helper.dart';
import 'package:food_delivery_app_flutter/pages/auth/sign_in_page.dart';
import 'package:food_delivery_app_flutter/pages/auth/sign_up_page.dart';
import 'package:food_delivery_app_flutter/utils/colors.dart';
import 'package:get/get.dart';
import 'controllers/cart_controller.dart';
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
    Get.find<CartController>().getCartData();
    return GetBuilder<PopularProductController>(builder: (_) {
      return GetBuilder<RecommendedProductController>(builder: (_) {
        return GetMaterialApp(
          debugShowCheckedModeBanner: false,
          title: "BKFood",
          // home: SignInPage(),
          initialRoute: RouteHelper.getSplash(),
          getPages: RouteHelper.routes,
          theme: ThemeData(
            primaryColor: AppColors.mainColor,
            fontFamily: "Lato",
          ),
        );
      });
    });
  }
}
