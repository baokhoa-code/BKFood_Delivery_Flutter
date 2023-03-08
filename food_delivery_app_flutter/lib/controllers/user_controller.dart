import 'package:food_delivery_app_flutter/data/repository/user_repo.dart';
import 'package:food_delivery_app_flutter/models/response_model.dart';
import 'package:food_delivery_app_flutter/models/signup_body_model.dart';
import 'package:food_delivery_app_flutter/models/user_model.dart';
import 'package:get/get.dart';

class UserController extends GetxController implements GetxService {
  final UserRepo userRepo;

  UserController({required this.userRepo});

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  UserModel? _userModel;
  UserModel? get userModel => _userModel;

  Future<ResponseModel> getUserInfo() async {
    Response response = await userRepo.getUserInfo();
    late ResponseModel responseModel;
    _isLoading = true;
    if (response.statusCode == 200) {
      _userModel = UserModel.fromJson(response.body);
      _isLoading = false;
      responseModel = ResponseModel(true, "Successfully");
    } else {
      responseModel = ResponseModel(false, response.body.toString());
    }

    update();
    return responseModel;
  }
}
