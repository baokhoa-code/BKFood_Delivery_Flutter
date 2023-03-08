import 'package:flutter/material.dart';
import 'package:food_delivery_app_flutter/controllers/auth_controller.dart';
import 'package:food_delivery_app_flutter/controllers/location_controller.dart';
import 'package:food_delivery_app_flutter/controllers/user_controller.dart';
import 'package:food_delivery_app_flutter/helper/route_helper.dart';
import 'package:food_delivery_app_flutter/models/address_model.dart';
import 'package:food_delivery_app_flutter/pages/address/pick_address_map.dart';
import 'package:food_delivery_app_flutter/utils/colors.dart';
import 'package:food_delivery_app_flutter/utils/dimensions.dart';
import 'package:food_delivery_app_flutter/widgets/app_text_field.dart';
import 'package:food_delivery_app_flutter/widgets/big_text.dart';
import 'package:geocoding/geocoding.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../base/show_custom_message.dart';
import '../../widgets/app_icon.dart';

class AddAddressPage extends StatefulWidget {
  const AddAddressPage({super.key});

  @override
  State<AddAddressPage> createState() => _AddAddressPageState();
}

class _AddAddressPageState extends State<AddAddressPage> {
  TextEditingController _addressController = TextEditingController();
  final TextEditingController _contactPersonName = TextEditingController();
  final TextEditingController _contactPersonNumber = TextEditingController();
  late bool _isLogged;
  CameraPosition _cameraPosition =
      const CameraPosition(target: LatLng(9.935927, 105.727066), zoom: 17);
  late LatLng _initialPosition = LatLng(9.935927, 105.727066);

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _isLogged = Get.find<AuthController>().isUserLoggedIn();
    if (_isLogged && Get.find<UserController>().userModel == null) {
      Get.find<UserController>().getUserInfo();
    }
    if (Get.find<LocationContronller>().addressList.isNotEmpty) {
      if (Get.find<LocationContronller>().getUserAddressFromLocalStorage() ==
          "") {
        Get.find<LocationContronller>()
            .saveUserAddress(Get.find<LocationContronller>().addressList.last);
      }
      Get.find<LocationContronller>().getUserAddress();
      _cameraPosition = CameraPosition(
          target: LatLng(
              double.parse(
                  Get.find<LocationContronller>().getAddress["latitude"]),
              double.parse(
                  Get.find<LocationContronller>().getAddress["longitude"])));
      _initialPosition = LatLng(
          double.parse(Get.find<LocationContronller>().getAddress["latitude"]),
          double.parse(
              Get.find<LocationContronller>().getAddress["longitude"]));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Address page"),
        backgroundColor: AppColors.mainColor,
      ),
      body: GetBuilder<UserController>(builder: (userController) {
        if (userController.userModel != null &&
            _contactPersonName.text.isEmpty) {
          _contactPersonName.text = '${userController.userModel?.name}';
          _contactPersonNumber.text = '${userController.userModel?.phone}';
          if (Get.find<LocationContronller>().addressList.isNotEmpty) {
            _addressController.text =
                Get.find<LocationContronller>().getUserAddress().address;
            // print("Address in add_address_page1: " + _addressController.text);
          }
        }
        return GetBuilder<LocationContronller>(builder: (locationContronller) {
          _addressController.text =
              '${locationContronller.placemark.name ?? ''}'
              '${locationContronller.placemark.locality ?? ''}'
              '${locationContronller.placemark.postalCode ?? ''}'
              '${locationContronller.placemark.country ?? ''}';
          // print("Address in add_address_page2: " + _addressController.text);
          return SingleChildScrollView(
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Container(
                height: 160,
                width: MediaQuery.of(context).size.width,
                margin: const EdgeInsets.only(left: 5, right: 5, top: 5),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    border: Border.all(width: 2, color: AppColors.mainColor)),
                child: Stack(children: [
                  GoogleMap(
                    initialCameraPosition:
                        CameraPosition(target: _initialPosition, zoom: 17),
                    onTap: (latlng) {
                      Get.toNamed(RouteHelper.getPickAddress(),
                          arguments: PickAddressMap(
                            fromSignup: false,
                            fromAddress: true,
                            googleMapController:
                                locationContronller.mapController,
                          ));
                    },
                    zoomControlsEnabled: false,
                    compassEnabled: false,
                    indoorViewEnabled: true,
                    mapToolbarEnabled: false,
                    myLocationEnabled: true,
                    onCameraIdle: () {
                      locationContronller.updatePosition(_cameraPosition, true);
                    },
                    onCameraMove: ((position) => _cameraPosition = position),
                    onMapCreated: ((GoogleMapController gmcontroller) {
                      locationContronller.setMapController(gmcontroller);
                    }),
                  )
                ]),
              ),
              Padding(
                padding: EdgeInsets.only(
                    left: Dimensions.width20, top: Dimensions.height20),
                child: SizedBox(
                  height: 50,
                  child: ListView.builder(
                      shrinkWrap: true,
                      scrollDirection: Axis.horizontal,
                      itemCount: locationContronller.addressTypeList.length,
                      itemBuilder: (context, index) {
                        return InkWell(
                          onTap: () {
                            locationContronller.setAddressTypeIndex(index);
                          },
                          child: Container(
                            padding: EdgeInsets.symmetric(
                                horizontal: Dimensions.width20,
                                vertical: Dimensions.height10),
                            margin: EdgeInsets.only(right: Dimensions.width10),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(
                                    Dimensions.radius20 / 4),
                                color: Theme.of(context).cardColor,
                                boxShadow: [
                                  BoxShadow(
                                      color: Colors.green[200]!,
                                      spreadRadius: 1,
                                      blurRadius: 5)
                                ]),
                            child: Icon(
                              index == 0
                                  ? Icons.home_filled
                                  : index == 1
                                      ? Icons.work
                                      : Icons.location_on,
                              color:
                                  locationContronller.addressTypeIndex == index
                                      ? AppColors.mainColor
                                      : Theme.of(context).disabledColor,
                            ),
                          ),
                        );
                      }),
                ),
              ),
              SizedBox(
                height: Dimensions.height10,
              ),
              Padding(
                  padding: EdgeInsets.only(left: Dimensions.width20),
                  child: BigText(text: "Delivery Address")),
              SizedBox(
                height: Dimensions.height10,
              ),
              AppTextField(
                  textController: _addressController,
                  hintText: "Your address",
                  icon: Icons.map),
              SizedBox(
                height: Dimensions.height10,
              ),
              Padding(
                  padding: EdgeInsets.only(left: Dimensions.width20),
                  child: BigText(text: "Contact name")),
              SizedBox(
                height: Dimensions.height10,
              ),
              AppTextField(
                  textController: _contactPersonName,
                  hintText: "Your name",
                  icon: Icons.person),
              SizedBox(
                height: Dimensions.height10,
              ),
              Padding(
                  padding: EdgeInsets.only(left: Dimensions.width20),
                  child: BigText(text: "Contact number")),
              SizedBox(
                height: Dimensions.height10,
              ),
              AppTextField(
                  textController: _contactPersonNumber,
                  hintText: "Your phone",
                  icon: Icons.phone),
            ]),
          );
        });
      }),
      bottomNavigationBar:
          GetBuilder<LocationContronller>(builder: (locationController) {
        return Column(mainAxisSize: MainAxisSize.min, children: [
          Container(
            height: Dimensions.height20 * 8,
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
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                GestureDetector(
                  onTap: () {
                    AddressModel _addressModel = AddressModel(
                        addressType: locationController.addressTypeList[
                            locationController.addressTypeIndex],
                        contactPersonName: _contactPersonName.text,
                        contactPersonNumber: _contactPersonNumber.text,
                        address: _addressController.text,
                        latitude:
                            locationController.position.latitude.toString(),
                        longitude:
                            locationController.position.longitude.toString());
                    locationController
                        .addAddress(_addressModel)
                        .then((response) {
                      if (response.isSucced) {
                        Get.toNamed(RouteHelper.getInitial());
                        showCustomSnackBar("Address Handled",
                            title: "Added successfully",
                            color: AppColors.mainColor);
                      } else {
                        showCustomSnackBar("Address Handled",
                            title: "Add Fail", color: Colors.redAccent);
                      }
                    });
                  },
                  child: Container(
                    padding: EdgeInsets.only(
                        top: Dimensions.height20,
                        bottom: Dimensions.height20,
                        left: Dimensions.width20,
                        right: Dimensions.width20),
                    child: BigText(
                      text: "Save Address",
                      color: Colors.white,
                      size: Dimensions.font26,
                    ),
                    decoration: BoxDecoration(
                        borderRadius:
                            BorderRadius.circular(Dimensions.radius20),
                        color: AppColors.mainColor),
                  ),
                )
              ],
            ),
          ),
        ]);
      }),
    );
  }
}
