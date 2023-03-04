import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:food_delivery_app_flutter/base/custom_loader.dart';
import 'package:food_delivery_app_flutter/base/show_custom_message.dart';
import 'package:food_delivery_app_flutter/controllers/auth_controller.dart';
import 'package:food_delivery_app_flutter/helper/route_helper.dart';
import 'package:food_delivery_app_flutter/models/response_model.dart';
import 'package:food_delivery_app_flutter/models/signup_body_model.dart';
import 'package:food_delivery_app_flutter/pages/auth/sign_in_page.dart';
import 'package:food_delivery_app_flutter/utils/colors.dart';
import 'package:food_delivery_app_flutter/utils/dimensions.dart';
import 'package:food_delivery_app_flutter/widgets/app_text_field.dart';
import 'package:food_delivery_app_flutter/widgets/big_text.dart';
import 'package:get/get.dart';

class SignUpPage extends StatelessWidget {
  const SignUpPage({super.key});

  @override
  Widget build(BuildContext context) {
    var emailController = TextEditingController();
    var passwordController = TextEditingController();
    var nameController = TextEditingController();
    var phoneController = TextEditingController();
    var signUpImages = [
      "assets/image/g.png",
      "assets/image/t.png",
      "assets/image/f.png"
    ];
    void _registration(AuthController authController) {
      String name = nameController.text.trim();
      String password = passwordController.text.trim();
      String phone = phoneController.text.trim();
      String email = emailController.text.trim();

      if (name.isEmpty) {
        showCustomSnackBar("Type in your name", title: "Name");
      } else if (phone.isEmpty) {
        showCustomSnackBar("Type in your phone number", title: "Phone number");
      } else if (password.isEmpty) {
        showCustomSnackBar("Type in your password", title: "Password");
      } else if (email.isEmpty) {
        showCustomSnackBar("Type in your email", title: "Email");
      } else if (!GetUtils.isEmail(email)) {
        showCustomSnackBar("Email invalid", title: "Email Validation");
      } else if (password.length < 6) {
        showCustomSnackBar("Password lenght must at least 6",
            title: "Password Lenght");
      } else {
        SignUpBody signUpBody = new SignUpBody(
            name: name, email: email, password: password, phone: phone);

        authController.registration(signUpBody).then((status) {
          if (status.isSucced) {
            showCustomSnackBar("Success registration",
                title: "Success", color: AppColors.mainColor);
            Get.offNamed(RouteHelper.getInitial());
          } else {
            showCustomSnackBar(status.message);
          }
        });
      }
    }

    return Scaffold(
        backgroundColor: Colors.white,
        body: GetBuilder<AuthController>(
          builder: (controller) {
            return controller.isLoading == false
                ? SingleChildScrollView(
                    physics: const BouncingScrollPhysics(),
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
                        AppTextField(
                            textController: nameController,
                            hintText: "Name",
                            icon: Icons.person),
                        SizedBox(
                          height: Dimensions.height20,
                        ),
                        AppTextField(
                            textController: phoneController,
                            hintText: "Phone",
                            icon: Icons.phone),
                        SizedBox(
                          height: Dimensions.height20,
                        ),
                        GestureDetector(
                          onTap: () {
                            _registration(controller);
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
                              text: "Sign up",
                              size: Dimensions.font20 + Dimensions.height20 / 2,
                              color: Colors.white,
                            )),
                          ),
                        ),
                        SizedBox(
                          height: Dimensions.height10,
                        ),
                        RichText(
                            text: TextSpan(
                                text: "Have an account already?",
                                recognizer: TapGestureRecognizer()
                                  ..onTap = () => Get.to(() => SignInPage(),
                                      transition: Transition.fade),
                                style: TextStyle(
                                    color: Colors.grey[500],
                                    fontSize: Dimensions.font20))),
                        SizedBox(
                          height: Dimensions.screenHeight * 0.05,
                        ),
                        RichText(
                            text: TextSpan(
                                text:
                                    "Sign up using one of the following medthods",
                                style: TextStyle(
                                    color: Colors.grey[500],
                                    fontSize: Dimensions.font16))),
                        Wrap(
                          children: List.generate(
                              3,
                              (index) => Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: CircleAvatar(
                                        backgroundColor: Colors.white,
                                        radius: 30,
                                        backgroundImage:
                                            AssetImage(signUpImages[index])),
                                  )),
                        )
                      ],
                    ),
                  )
                : const CustomLoader();
          },
        ));
  }
}
