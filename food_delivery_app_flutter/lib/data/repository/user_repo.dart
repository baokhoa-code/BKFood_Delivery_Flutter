import 'package:food_delivery_app_flutter/data/api/api_client.dart';
import 'package:food_delivery_app_flutter/utils/app_constants.dart';
import 'package:food_delivery_app_flutter/utils/colors.dart';
import 'package:get/get.dart';

class UserRepo {
  final ApiClient apiClient;
  UserRepo({required this.apiClient});
  Future<Response> getUserInfo() async {
    return await apiClient.getData(AppConstants.USER_INFO_URI);
  }
}
