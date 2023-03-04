import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:food_delivery_app_flutter/base/custom_loader.dart';
import 'package:food_delivery_app_flutter/helper/route_helper.dart';
import 'package:food_delivery_app_flutter/pages/auth/sign_up_page.dart';
import 'package:food_delivery_app_flutter/utils/colors.dart';
import 'package:food_delivery_app_flutter/utils/dimensions.dart';
import 'package:food_delivery_app_flutter/widgets/app_text_field.dart';
import 'package:food_delivery_app_flutter/widgets/big_text.dart';
import 'package:get/get.dart';

import '../../base/show_custom_message.dart';
import '../../controllers/auth_controller.dart';
import '../../models/signup_body_model.dart';

class SignInPage extends StatelessWidget {
  const SignInPage({super.key});

  @override
  Widget build(BuildContext context) {
    var emailController = TextEditingController();
    var passwordController = TextEditingController();

    void _login(AuthController authController) {
      String email = emailController.text.trim();
      String password = passwordController.text.trim();

      if (email.isEmpty) {
        showCustomSnackBar("Type in your email", title: "Password");
      } else if (password.isEmpty) {
        showCustomSnackBar("Type in your password", title: "Email");
      } else if (!GetUtils.isEmail(email)) {
        showCustomSnackBar("Email invalid", title: "Email Validation");
      } else if (password.length < 6) {
        showCustomSnackBar("Password lenght must at least 6",
            title: "Password Lenght");
      } else {
        authController.login(email, password).then((status) {
          if (status.isSucced) {
            showCustomSnackBar("Success login",
                title: "Success", color: AppColors.mainColor);
            Get.toNamed(RouteHelper.getInitial());
          } else {
            showCustomSnackBar(status.message);
          }
        });
      }
    }

    return Scaffold(
        backgroundColor: Colors.white,
        body: GetBuilder<AuthController>(
          builder: (contronller) {
            return contronller.isLoading == false
                ? SingleChildScrollView(
                    physics: BouncingScrollPhysics(),
                    child: Column(
                      children: [
                        SizedBox(
                          height: Dimensions.screenHeight * 0.05,
                        ),
                        Container(
                          height: Dimensions.screenHeight * 0.25,
                          child: const Center(
                            child: CircleAvatar(
                                backgroundColor: Colors.white,
                                radius: 75,
                                backgroundImage:
                                    AssetImage("assets/image/logo1.png")),
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(left: Dimensions.width20),
                          child: Column(children: [
                            Text(
                              "Hello",
                              style: TextStyle(
                                  fontSize: Dimensions.font20 * 3 +
                                      Dimensions.font20 / 2,
                                  fontWeight: FontWeight.bold),
                            ),
                            Text(
                              "Sign in your account",
                              style: TextStyle(
                                  fontSize: Dimensions.font20,
                                  color: Colors.grey[500]),
                            )
                          ]),
                        ),
                        SizedBox(
                          height: Dimensions.height20 * 2,
                        ),
                        AppTextField(
                            textController: emailController,
                            hintText: "Email",
                            icon: Icons.email),
                        SizedBox(
                          height: Dimensions.height20,
                        ),
                        AppTextField(
                            isObscure: true,
                            textController: passwordController,
                            hintText: "Password",
                            icon: Icons.password),
                        SizedBox(
                          height: Dimensions.height20,
                        ),
                        Row(
                          children: [
                            Expanded(child: Container()),
                            RichText(
                                text: TextSpan(
                                    text: "Sign in to your account",
                                    style: TextStyle(
                                        color: Colors.grey[500],
                                        fontSize: Dimensions.font20))),
                            SizedBox(
                              width: Dimensions.width20,
                            )
                          ],
                        ),
                        SizedBox(
                          height: Dimensions.screenHeight * 0.05,
                        ),
                        GestureDetector(
                          onTap: () {
                            _login(contronller);
                          },
                          child: Container(
                            width: Dimensions.screenWidth / 2,
                            height: Dimensions.screenHeight / 13,
                            decoration: BoxDecoration(
                                borderRadius:
                                    BorderRadius.circular(Dimensions.radius30),
                                color: AppColors.mainColor),
                            child: Center(
                                child: BigText(
                              text: "Sign in",
                              size: Dimensions.font20 + Dimensions.height20 / 2,
                              color: Colors.white,
                            )),
                          ),
                        ),
                        SizedBox(
                          height: Dimensions.screenHeight * 0.05,
                        ),
                        RichText(
                            text: TextSpan(
                                text: "Dont\'t have an account?",
                                style: TextStyle(
                                    color: Colors.grey[500],
                                    fontSize: Dimensions.font20),
                                children: [
                              TextSpan(
                                recognizer: TapGestureRecognizer()
                                  ..onTap = () => Get.to(() => SignUpPage(),
                                      transition: Transition.fade),
                                text: " Create",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: AppColors.mainBlackColor,
                                    fontSize: Dimensions.font20),
                              )
                            ])),
                      ],
                    ),
                  )
                : CustomLoader();
          },
        ));
  }
}
