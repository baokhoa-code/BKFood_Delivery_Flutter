import 'package:flutter/material.dart';
import 'package:food_delivery_app_flutter/controllers/cart_controller.dart';
import 'package:food_delivery_app_flutter/data/repository/popular_product_repo.dart';
import 'package:food_delivery_app_flutter/utils/colors.dart';
import 'package:get/get.dart';

import '../models/cart_module.dart';
import '../models/product_model.dart';

class PopularProductController extends GetxController {
  final PopularProductRepo popularProductRepo;

  PopularProductController({required this.popularProductRepo});

  List<dynamic> _popularProductList = [];
  List<dynamic> get popularProductList => _popularProductList;
  late CartController _cart;

  bool _isLoaded = false;
  bool get isLoaded => _isLoaded;
  bool _isExist = false;
  bool get isExist => _isExist;
  int _quantity = 0;
  int get quantity => _quantity;

  Future<void> getPopularProductList() async {
    Response response = await popularProductRepo.getPopularProductList();
    if (response.statusCode == 200) {
      _popularProductList = [];
      _popularProductList.addAll(Product.fromJson(response.body).products);
      _isLoaded = true;
      update();
    } else {}
  }

  void setQuantity(bool isIncrement) {
    if (isIncrement) {
      _quantity = checkQuantity(_quantity + 1);
    } else {
      _quantity = checkQuantity(_quantity - 1);
    }
    update();
  }

  int checkQuantity(int quantity) {
    if (quantity < 0) {
      Get.snackbar("Item count", "You can not reduce more !",
          backgroundColor: AppColors.mainColor, colorText: Colors.white);
      return 0;
    } else if (quantity > 20) {
      Get.snackbar("Item count", "You can not add more !",
          backgroundColor: AppColors.mainColor, colorText: Colors.white);
      return 20;
    } else {
      return quantity;
    }
  }

  void initProduct(ProductModel product, CartController cart) {
    _quantity = 0;
    _cart = cart;

    if (_cart.existInCart(product)) {
      _isExist = true;
      _quantity = _cart.getQuantity(product);
      // print("Existed with quantity: " + _quantity.toString());
    } else {
      _isExist = false;
      // print("No exist in cart");
    }
  }

  void addItem(ProductModel product) {
    _cart.addItem(product, _quantity);
    _quantity = _cart.getQuantity(product);
    if (_quantity == 0) {
      _isExist = false;
    } else {
      _isExist = true;
    }
    update();
  }

  int get totalItems {
    return _cart.totalItems;
  }

  int get totalUniqueItems {
    return _cart.totalUniqueItems;
  }

  List<CartModel> get getItems {
    return _cart.getItems;
  }
}
