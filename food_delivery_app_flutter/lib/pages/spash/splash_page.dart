import 'dart:async';

import 'package:flutter/material.dart';
import 'package:food_delivery_app_flutter/utils/dimensions.dart';
import 'package:get/get.dart';

import '../../controllers/popular_product_controller.dart';
import '../../controllers/recommended_product_controller.dart';
import '../../helper/route_helper.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with TickerProviderStateMixin {
  late Animation<double> animation;
  late Animation<double> animation2;
  late AnimationController controller;

  Future<void> _loadResources() async {
    await Get.find<PopularProductController>().getPopularProductList();
    await Get.find<RecommendedProductController>().getRecommendedProductList();
  }

  @override
  void initState() {
    super.initState();
    _loadResources();
    controller =
        AnimationController(vsync: this, duration: const Duration(seconds: 2))
          ..forward();
    animation = CurvedAnimation(
        parent: controller, curve: Curves.easeInOutCubicEmphasized);
    animation2 = CurvedAnimation(
        parent: controller, curve: Curves.fastLinearToSlowEaseIn);
    Timer(const Duration(seconds: 4),
        () => Get.offNamed(RouteHelper.getInitial()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ScaleTransition(
            scale: animation,
            child: Center(
              child: Image.asset(
                "assets/image/logo1.png",
                width: Dimensions.splashImg,
              ),
            ),
          ),
          ScaleTransition(
            scale: animation2,
            child: Center(
              child: Image.asset(
                "assets/image/logo2.png",
                width: Dimensions.splashImg,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
