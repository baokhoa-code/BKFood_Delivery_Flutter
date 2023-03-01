import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:food_delivery_app_flutter/base/no_data_page.dart';
import 'package:food_delivery_app_flutter/controllers/cart_controller.dart';
import 'package:food_delivery_app_flutter/controllers/popular_product_controller.dart';
import 'package:food_delivery_app_flutter/utils/app_constants.dart';
import 'package:food_delivery_app_flutter/utils/colors.dart';
import 'package:food_delivery_app_flutter/utils/dimensions.dart';
import 'package:food_delivery_app_flutter/widgets/app_icon.dart';
import 'package:food_delivery_app_flutter/widgets/big_text.dart';
import 'package:food_delivery_app_flutter/widgets/small_text.dart';
import 'package:get/get.dart';

import '../../controllers/recommended_product_controller.dart';
import '../../helper/route_helper.dart';

class CartPage extends StatelessWidget {
  const CartPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(
          children: [
            Positioned(
                top: Dimensions.height20 * 3,
                left: Dimensions.width20,
                right: Dimensions.width20,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    AppIcon(
                      icon: Icons.arrow_back_ios,
                      iconColor: Colors.white,
                      backgroundColor: AppColors.mainColor,
                      iconSize: Dimensions.iconSize24,
                    ),
                    SizedBox(
                      width: Dimensions.width20 * 5,
                    ),
                    GestureDetector(
                      onTap: () {
                        Get.toNamed(RouteHelper.getInitial());
                      },
                      child: AppIcon(
                        icon: Icons.home_outlined,
                        iconColor: Colors.white,
                        backgroundColor: AppColors.mainColor,
                        iconSize: Dimensions.iconSize24,
                      ),
                    ),
                    AppIcon(
                      icon: Icons.shopping_cart,
                      iconColor: Colors.white,
                      backgroundColor: AppColors.mainColor,
                      iconSize: Dimensions.iconSize24,
                    ),
                  ],
                )),
            GetBuilder<CartController>(builder: (_cartController) {
              return _cartController.getItems.length > 0
                  ? Positioned(
                      top: Dimensions.height20 * 5,
                      left: Dimensions.width20,
                      right: Dimensions.width20,
                      bottom: 0,
                      child: Container(
                        margin: EdgeInsets.only(top: Dimensions.height15),
                        //     color: Colors.red,
                        child: MediaQuery.removePadding(
                          context: context,
                          removeTop: true,
                          child: GetBuilder<CartController>(
                            builder: (controller) {
                              var _cartList = controller.getItems;
                              return ListView.builder(
                                  itemCount: _cartList.length,
                                  itemBuilder: (_, index) {
                                    return Container(
                                      height: 100,
                                      width: double.maxFinite,
                                      child: Row(
                                        children: [
                                          GestureDetector(
                                            onTap: () {
                                              var popularIndex = Get.find<
                                                      PopularProductController>()
                                                  .popularProductList
                                                  .indexOf(_cartList[index]
                                                      .product!);
                                              if (popularIndex >= 0) {
                                                Get.toNamed(
                                                    RouteHelper.getPopularFood(
                                                        popularIndex,
                                                        "cartpage"));
                                              } else {
                                                var recommendedIndex = Get.find<
                                                        RecommendedProductController>()
                                                    .recommendedProductList
                                                    .indexOf(_cartList[index]
                                                        .product!);
                                                if (recommendedIndex < 0) {
                                                  Get.snackbar(
                                                      "History product",
                                                      "Product review is currently no available!",
                                                      backgroundColor:
                                                          AppColors.mainColor,
                                                      colorText: Colors.white);
                                                } else {
                                                  Get.toNamed(RouteHelper
                                                      .getRecommendedFood(
                                                          recommendedIndex,
                                                          "cartpage"));
                                                }
                                              }
                                            },
                                            child: Container(
                                              width: Dimensions.height20 * 5,
                                              height: Dimensions.height20 * 5,
                                              margin: EdgeInsets.only(
                                                  bottom: Dimensions.height10),
                                              decoration: BoxDecoration(
                                                  image: DecorationImage(
                                                      fit: BoxFit.cover,
                                                      image: NetworkImage(
                                                          AppConstants
                                                                  .BASE_URL +
                                                              AppConstants
                                                                  .UPLOAD_URL +
                                                              _cartList[index]
                                                                  .img!)),
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          Dimensions.radius20),
                                                  color: Colors.white),
                                            ),
                                          ),
                                          SizedBox(
                                            width: Dimensions.width10,
                                          ),
                                          Expanded(
                                              child: Container(
                                            height: Dimensions.height20 * 5,
                                            child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceEvenly,
                                                children: [
                                                  BigText(
                                                    text:
                                                        _cartList[index].name!,
                                                    color: Colors.black54,
                                                  ),
                                                  SmallText(text: "Spicy"),
                                                  Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: [
                                                      BigText(
                                                        text:
                                                            "\$ ${_cartList[index].price!}",
                                                        color: Colors.redAccent,
                                                      ),
                                                      Container(
                                                        padding: EdgeInsets.only(
                                                            top: Dimensions
                                                                .height10,
                                                            bottom: Dimensions
                                                                .height10,
                                                            left: Dimensions
                                                                .width10,
                                                            right: Dimensions
                                                                .width10),
                                                        decoration: BoxDecoration(
                                                            borderRadius:
                                                                BorderRadius.circular(
                                                                    Dimensions
                                                                        .radius20),
                                                            color:
                                                                Colors.white),
                                                        child: Row(children: [
                                                          GestureDetector(
                                                            onTap: () {
                                                              if (_cartList[index]
                                                                          .quantity! -
                                                                      1 ==
                                                                  0) {
                                                                showCupertinoDialog(
                                                                    context:
                                                                        context,
                                                                    builder:
                                                                        (BuildContext
                                                                            context) {
                                                                      return CupertinoAlertDialog(
                                                                        title: const Text(
                                                                            'Delete Food'),
                                                                        content:
                                                                            const Text('Are you sure to delete this food from cart?'),
                                                                        actions: <
                                                                            Widget>[
                                                                          CupertinoDialogAction(
                                                                            onPressed:
                                                                                () {
                                                                              Navigator.pop(context);
                                                                              controller.addItem(_cartList[index].product!, _cartList[index].quantity! - 1);
                                                                            },
                                                                            child:
                                                                                const Text('Yes'),
                                                                          ),
                                                                          CupertinoDialogAction(
                                                                            onPressed:
                                                                                () {
                                                                              Navigator.pop(context);
                                                                            },
                                                                            child:
                                                                                const Text('No'),
                                                                          ),
                                                                        ],
                                                                      );
                                                                    });
                                                              } else {
                                                                controller.addItem(
                                                                    _cartList[
                                                                            index]
                                                                        .product!,
                                                                    _cartList[index]
                                                                            .quantity! -
                                                                        1);
                                                              }
                                                            },
                                                            child: Icon(
                                                              Icons.remove,
                                                              color: AppColors
                                                                  .signColor,
                                                            ),
                                                          ),
                                                          SizedBox(
                                                            width: Dimensions
                                                                    .width10 /
                                                                2,
                                                          ),
                                                          BigText(
                                                              text: _cartList[
                                                                      index]
                                                                  .quantity
                                                                  .toString()),
                                                          SizedBox(
                                                            width: Dimensions
                                                                    .width10 /
                                                                2,
                                                          ),
                                                          GestureDetector(
                                                            onTap: () {
                                                              if (_cartList[index]
                                                                          .quantity! +
                                                                      1 >
                                                                  20) {
                                                                Get.snackbar(
                                                                    "Max item number",
                                                                    "You can not add more !",
                                                                    backgroundColor:
                                                                        AppColors
                                                                            .mainColor,
                                                                    colorText:
                                                                        Colors
                                                                            .white);
                                                              } else {
                                                                controller.addItem(
                                                                    _cartList[
                                                                            index]
                                                                        .product!,
                                                                    _cartList[index]
                                                                            .quantity! +
                                                                        1);
                                                              }
                                                            },
                                                            child: Icon(
                                                              Icons.add,
                                                              color: AppColors
                                                                  .signColor,
                                                            ),
                                                          )
                                                        ]),
                                                      )
                                                    ],
                                                  )
                                                ]),
                                          ))
                                        ],
                                      ),
                                    );
                                  });
                            },
                          ),
                        ),
                      ))
                  : NoDataPage(text: "Your cart is empty");
            }),
          ],
        ),
        bottomNavigationBar: GetBuilder<CartController>(
          builder: (controller) {
            return Container(
              height: Dimensions.bottomHeightBar,
              padding: EdgeInsets.only(
                  top: Dimensions.height30,
                  bottom: Dimensions.height30,
                  left: Dimensions.width20,
                  right: Dimensions.width20),
              decoration: BoxDecoration(
                  color: AppColors.buttonBackgroundColor,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(Dimensions.radius20 * 2),
                      topRight: Radius.circular(Dimensions.radius20 * 2))),
              child: controller.getItems.length > 0
                  ? Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          padding: EdgeInsets.only(
                              top: Dimensions.height20,
                              bottom: Dimensions.height20,
                              left: Dimensions.width20,
                              right: Dimensions.width20),
                          decoration: BoxDecoration(
                              borderRadius:
                                  BorderRadius.circular(Dimensions.radius20),
                              color: Colors.white),
                          child: Row(children: [
                            SizedBox(
                              width: Dimensions.width10 / 2,
                            ),
                            BigText(
                                text:
                                    "\$ " + controller.totalAmount.toString()),
                            SizedBox(
                              width: Dimensions.width10 / 2,
                            ),
                          ]),
                        ),
                        GestureDetector(
                          onTap: () {
                            controller.addToHistory();
                          },
                          child: Container(
                            padding: EdgeInsets.only(
                                top: Dimensions.height20,
                                bottom: Dimensions.height20,
                                left: Dimensions.width20,
                                right: Dimensions.width20),
                            child: BigText(
                              text: "Check out",
                              color: Colors.white,
                            ),
                            decoration: BoxDecoration(
                                borderRadius:
                                    BorderRadius.circular(Dimensions.radius20),
                                color: AppColors.mainColor),
                          ),
                        ),
                      ],
                    )
                  : Container(),
            );
          },
        ));
  }
}
