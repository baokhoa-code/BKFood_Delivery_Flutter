import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:food_delivery_app_flutter/base/custom_button.dart';
import 'package:food_delivery_app_flutter/base/custom_loader.dart';
import 'package:food_delivery_app_flutter/controllers/location_controller.dart';
import 'package:food_delivery_app_flutter/helper/route_helper.dart';
import 'package:food_delivery_app_flutter/utils/colors.dart';
import 'package:food_delivery_app_flutter/utils/dimensions.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class PickAddressMap extends StatefulWidget {
  final bool fromSignup;
  final bool fromAddress;
  final GoogleMapController? googleMapController;

  const PickAddressMap(
      {Key? key,
      required this.fromSignup,
      required this.fromAddress,
      this.googleMapController})
      : super(key: key);

  @override
  State<PickAddressMap> createState() => _PickAddressMapState();
}

class _PickAddressMapState extends State<PickAddressMap> {
  late LatLng _initialPosition;
  late GoogleMapController _mapController;
  late CameraPosition _cameraPosition;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    if (Get.find<LocationContronller>().addressList.isEmpty) {
      _initialPosition = LatLng(9.935927, 105.727066);
      _cameraPosition = CameraPosition(target: _initialPosition, zoom: 17);
    } else {
      if (Get.find<LocationContronller>().addressList.isNotEmpty) {
        _initialPosition = LatLng(
            double.parse(
                Get.find<LocationContronller>().getAddress["latitude"]),
            double.parse(
                Get.find<LocationContronller>().getAddress["longitude"]));
        _cameraPosition = CameraPosition(target: _initialPosition, zoom: 17);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<LocationContronller>(builder: (locationController) {
      return Scaffold(
        body: SafeArea(
            child: Center(
          child: SizedBox(
            width: double.maxFinite,
            child: Stack(
              children: [
                GoogleMap(
                  initialCameraPosition:
                      CameraPosition(target: _initialPosition, zoom: 17),
                  zoomControlsEnabled: false,
                  onCameraMove: (CameraPosition cameraPosition) {
                    _cameraPosition = cameraPosition;
                  },
                  onCameraIdle: () {
                    Get.find<LocationContronller>()
                        .updatePosition(_cameraPosition, false);
                  },
                ),
                Center(
                  child: locationController.isLoading == false
                      ? Image.asset(
                          "assets/image/map_marker.png",
                          height: 50,
                          width: 50,
                        )
                      : CircularProgressIndicator(),
                ),
                Positioned(
                  top: Dimensions.height45,
                  left: Dimensions.width20,
                  right: Dimensions.width20,
                  child: Container(
                    padding:
                        EdgeInsets.symmetric(horizontal: Dimensions.width10),
                    height: 50,
                    decoration: BoxDecoration(
                        color: AppColors.mainColor,
                        borderRadius:
                            BorderRadius.circular(Dimensions.radius20 / 2)),
                    child: Row(
                      children: [
                        const Icon(
                          Icons.location_on,
                          size: 25,
                          color: Colors.white,
                        ),
                        Expanded(
                            child: Text(
                          '${locationController.pickPlacemark.name ?? ''}',
                          style: TextStyle(
                              color: Colors.white, fontSize: Dimensions.font16),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ))
                      ],
                    ),
                  ),
                ),
                Positioned(
                    bottom: 80,
                    left: Dimensions.width20,
                    right: Dimensions.width20,
                    child: CustomButton(
                      width: 200,
                      buttonText: 'Pick Address',
                      onPressed: locationController.isLoading == true
                          ? null
                          : () {
                              if (locationController.pickPosition.latitude !=
                                      0 &&
                                  locationController.pickPlacemark.name !=
                                      null) {
                                if (widget.fromAddress) {
                                  if (widget.googleMapController != null) {
                                    print("Now you can click on this");
                                    widget.googleMapController!.moveCamera(
                                        CameraUpdate.newCameraPosition(
                                            CameraPosition(
                                                target: LatLng(
                                                    locationController
                                                        .pickPosition.latitude,
                                                    locationController
                                                        .pickPosition
                                                        .longitude))));
                                    locationController.setAddAddressData();
                                  }
                                  // Get.toNamed(RouteHelper.getAddAddress());
                                  Get.back();
                                }
                              }
                            },
                    ))
              ],
            ),
          ),
        )),
      );
    });
  }
}
