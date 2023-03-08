import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:food_delivery_app_flutter/base/custom_loader.dart';
import 'package:food_delivery_app_flutter/controllers/auth_controller.dart';
import 'package:food_delivery_app_flutter/controllers/cart_controller.dart';
import 'package:food_delivery_app_flutter/controllers/location_controller.dart';
import 'package:food_delivery_app_flutter/controllers/user_controller.dart';
import 'package:food_delivery_app_flutter/helper/route_helper.dart';
import 'package:food_delivery_app_flutter/utils/colors.dart';
import 'package:food_delivery_app_flutter/utils/dimensions.dart';
import 'package:food_delivery_app_flutter/widgets/account_widget.dart';
import 'package:food_delivery_app_flutter/widgets/app_icon.dart';
import 'package:food_delivery_app_flutter/widgets/big_text.dart';
import 'package:get/get.dart';

import '../../base/show_custom_message.dart';

class AccountPage extends StatelessWidget {
  const AccountPage({super.key});

  @override
  Widget build(BuildContext context) {
    bool _userLoggedIn = Get.find<AuthController>().isUserLoggedIn();
    if (_userLoggedIn) {
      Get.find<UserController>().getUserInfo();
      print("User has logged in");
    }
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: AppColors.mainColor,
        title: BigText(
          text: "Profile",
          size: Dimensions.font24,
          color: Colors.white,
        ),
      ),
      body: GetBuilder<UserController>(builder: (userController) {
        return _userLoggedIn
            ? (!userController.isLoading
                ? Container(
                    width: double.maxFinite,
                    margin: EdgeInsets.only(top: Dimensions.height20),
                    child: Column(
                      children: [
                        //profile icon
                        AppIcon(
                          icon: Icons.person,
                          backgroundColor: AppColors.mainColor,
                          iconColor: Colors.white,
                          iconSize: Dimensions.height45 + Dimensions.height30,
                          size: Dimensions.height15 * 10,
                        ),
                        SizedBox(
                          height: Dimensions.height30,
                        ),
                        Expanded(
                            child: SingleChildScrollView(
                          child: Column(
                            children: [
                              //name
                              AccountWidget(
                                  appIcon: AppIcon(
                                    icon: Icons.person,
                                    backgroundColor: AppColors.mainColor,
                                    iconColor: Colors.white,
                                    iconSize: Dimensions.height10 * 5 / 2,
                                    size: Dimensions.height10 * 5,
                                  ),
                                  bigText: BigText(
                                    text: userController.userModel!.name,
                                  )),
                              SizedBox(
                                height: Dimensions.height20 * 1.5,
                              ),
                              //phone
                              AccountWidget(
                                  appIcon: AppIcon(
                                    icon: Icons.phone,
                                    backgroundColor: AppColors.yellowColor,
                                    iconColor: Colors.white,
                                    iconSize: Dimensions.height10 * 5 / 2,
                                    size: Dimensions.height10 * 5,
                                  ),
                                  bigText: BigText(
                                    text: userController.userModel!.phone,
                                  )),
                              SizedBox(
                                height: Dimensions.height20 * 1.5,
                              ),
                              //email
                              AccountWidget(
                                  appIcon: AppIcon(
                                    icon: Icons.email,
                                    backgroundColor: AppColors.yellowColor,
                                    iconColor: Colors.white,
                                    iconSize: Dimensions.height10 * 5 / 2,
                                    size: Dimensions.height10 * 5,
                                  ),
                                  bigText: BigText(
                                    text: userController.userModel!.email,
                                  )),
                              SizedBox(
                                height: Dimensions.height20 * 1.5,
                              ),
                              //address
                              GetBuilder<LocationContronller>(
                                  builder: (locationController) {
                                if (_userLoggedIn &&
                                    locationController.addressList.isEmpty) {
                                  return GestureDetector(
                                    onTap: () {
                                      Get.offNamed(RouteHelper.getAddAddress());
                                    },
                                    child: AccountWidget(
                                        appIcon: AppIcon(
                                          icon: Icons.location_on,
                                          backgroundColor:
                                              AppColors.yellowColor,
                                          iconColor: Colors.white,
                                          iconSize: Dimensions.height10 * 5 / 2,
                                          size: Dimensions.height10 * 5,
                                        ),
                                        bigText: BigText(
                                          text: "Fill in your addresses",
                                        )),
                                  );
                                } else {
                                  return GestureDetector(
                                    onTap: () {
                                      Get.offNamed(RouteHelper.getAddAddress());
                                    },
                                    child: AccountWidget(
                                        appIcon: AppIcon(
                                          icon: Icons.location_on,
                                          backgroundColor:
                                              AppColors.yellowColor,
                                          iconColor: Colors.white,
                                          iconSize: Dimensions.height10 * 5 / 2,
                                          size: Dimensions.height10 * 5,
                                        ),
                                        bigText: BigText(
                                          text: "Your addresses",
                                        )),
                                  );
                                }
                              }),
                              SizedBox(
                                height: Dimensions.height20 * 1.5,
                              ),
                              //message
                              AccountWidget(
                                  appIcon: AppIcon(
                                    icon: Icons.message_outlined,
                                    backgroundColor: Colors.redAccent,
                                    iconColor: Colors.white,
                                    iconSize: Dimensions.height10 * 5 / 2,
                                    size: Dimensions.height10 * 5,
                                  ),
                                  bigText: BigText(
                                    text: "Message",
                                  )),
                              SizedBox(
                                height: Dimensions.height20,
                              ),
                              GestureDetector(
                                onTap: () {
                                  if (Get.find<AuthController>()
                                      .isUserLoggedIn()) {
                                    Get.find<AuthController>()
                                        .isClearSharedData();
                                    Get.find<CartController>().clear();
                                    Get.find<CartController>()
                                        .clearCartHistory();
                                    Get.find<LocationContronller>()
                                        .clearAddressList();
                                    showCustomSnackBar("Loggout Success",
                                        title: "Loggout",
                                        color: AppColors.mainColor);
                                    Get.offNamed(RouteHelper.getSinIn());
                                  } else {
                                    showCustomSnackBar("You logged out",
                                        title: "Loggout",
                                        color: AppColors.warningColor);
                                    Get.offNamed(RouteHelper.getSinIn());
                                  }
                                },
                                child: AccountWidget(
                                    appIcon: AppIcon(
                                      icon: Icons.logout,
                                      backgroundColor: Colors.redAccent,
                                      iconColor: Colors.white,
                                      iconSize: Dimensions.height10 * 5 / 2,
                                      size: Dimensions.height10 * 5,
                                    ),
                                    bigText: BigText(
                                      text: "Logout",
                                    )),
                              ),
                              SizedBox(
                                height: Dimensions.height20,
                              ),
                            ],
                          ),
                        ))
                      ],
                    ),
                  )
                : CustomLoader())
            : Container(
                child: Center(
                    child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      width: double.maxFinite,
                      height: Dimensions.height20 * 10,
                      margin: EdgeInsets.only(
                          left: Dimensions.width20, right: Dimensions.width20),
                      decoration: BoxDecoration(
                          borderRadius:
                              BorderRadius.circular(Dimensions.radius30),
                          image: DecorationImage(
                              fit: BoxFit.cover,
                              image: AssetImage("assets/image/bicycle.png"))),
                    ),
                    GestureDetector(
                      onTap: () {
                        Get.toNamed(RouteHelper.getSinIn());
                      },
                      child: Container(
                        width: 200,
                        height: Dimensions.height20 * 3,
                        margin: EdgeInsets.only(
                            left: Dimensions.width20,
                            right: Dimensions.width20),
                        decoration: BoxDecoration(
                          color: AppColors.mainColor,
                          borderRadius:
                              BorderRadius.circular(Dimensions.radius30),
                        ),
                        child: Center(
                          child: BigText(
                            text: "Sign In",
                            color: Colors.white,
                            size: Dimensions.font26,
                          ),
                        ),
                      ),
                    ),
                  ],
                )),
              );
      }),
    );
  }
}
