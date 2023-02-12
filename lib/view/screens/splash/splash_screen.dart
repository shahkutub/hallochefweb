import 'dart:async';

import 'package:connectivity/connectivity.dart';
import 'package:efood_multivendor/controller/auth_controller.dart';
import 'package:efood_multivendor/controller/cart_controller.dart';
import 'package:efood_multivendor/controller/location_controller.dart';
import 'package:efood_multivendor/controller/splash_controller.dart';
import 'package:efood_multivendor/controller/wishlist_controller.dart';
import 'package:efood_multivendor/data/model/body/notification_body.dart';
import 'package:efood_multivendor/helper/route_helper.dart';
import 'package:efood_multivendor/util/app_constants.dart';
import 'package:efood_multivendor/util/dimensions.dart';
import 'package:efood_multivendor/util/images.dart';
import 'package:efood_multivendor/view/base/no_internet_screen.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';

import '../../../data/model/response/address_model.dart';
import '../../../data/model/response/zone_response_model.dart';
import '../../../util/styles.dart';
import '../../base/custom_loader.dart';
import '../../base/custom_snackbar.dart';
import '../location/widget/permission_dialog.dart';

class SplashScreen extends StatefulWidget {
  final NotificationBody body;
  SplashScreen({@required this.body});

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  GlobalKey<ScaffoldState> _globalKey = GlobalKey();
  StreamSubscription<ConnectivityResult> _onConnectivityChanged;

  void _checkPermission(Function onTap) async {
    LocationPermission permission = await Geolocator.checkPermission();
    if(permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
    }
    if(permission == LocationPermission.denied) {
      showCustomSnackBar('you_have_to_allow'.tr);
    }else if(permission == LocationPermission.deniedForever) {
      Get.dialog(PermissionDialog());
    }else {
      onTap();
    }
  }

  @override
  void initState() {
    super.initState();

    // _checkPermission(() async {
    //   Get.dialog(CustomLoader(), barrierDismissible: false);
    //   AddressModel _address = await Get.find<LocationController>().getCurrentLocation(true);
    //   //ZoneResponseModel _response = await locationController.getZone(_address.latitude, _address.longitude, false);
    //   // if(_response.isSuccess) {
    //   //   locationController.saveAddressAndNavigate(_address, fromSignUp, route, route != null);
    //   // }else {
    //   //   Get.back();
    //   //   Get.toNamed(RouteHelper.getPickMapRoute(route == null ? RouteHelper.accessLocation : route, route != null));
    //   //   showCustomSnackBar('service_not_available_in_current_location'.tr);
    //   // }
    // });


    bool _firstTime = true;
    _onConnectivityChanged = Connectivity().onConnectivityChanged.listen((ConnectivityResult result) {
      if(!_firstTime) {
        bool isNotConnected = result != ConnectivityResult.wifi && result != ConnectivityResult.mobile;
        isNotConnected ? SizedBox() : ScaffoldMessenger.of(context).hideCurrentSnackBar();
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          backgroundColor: isNotConnected ? Colors.red : Colors.green,
          duration: Duration(seconds: isNotConnected ? 6000 : 3),
          content: Text(
            isNotConnected ? 'no_connection'.tr : 'connected'.tr,
            textAlign: TextAlign.center,
          ),
        ));
        if(!isNotConnected) {
          _route();
        }
      }
      _firstTime = false;
    });

    Get.find<SplashController>().initSharedData();
    if(Get.find<LocationController>().getUserAddress() != null && (Get.find<LocationController>().getUserAddress().zoneIds == null
        || Get.find<LocationController>().getUserAddress().zoneData == null)) {
      Get.find<AuthController>().clearSharedAddress();
    }
    Get.find<CartController>().getCartData();
    _route();

  }

  @override
  void dispose() {
    super.dispose();

    _onConnectivityChanged.cancel();
  }

  void _route() {
    Get.find<SplashController>().getConfigData().then((isSuccess) {
      if(isSuccess) {
        print('configlatlon: '+Get.find<SplashController>().configModel.defaultLocation.lat);

        Timer(Duration(seconds: 1), () async {
          int _minimumVersion = 0;
          if(GetPlatform.isAndroid) {
            _minimumVersion = Get.find<SplashController>().configModel.appMinimumVersionAndroid;
          }else if(GetPlatform.isIOS) {
            _minimumVersion = Get.find<SplashController>().configModel.appMinimumVersionIos;
          }
          if(AppConstants.APP_VERSION < _minimumVersion || Get.find<SplashController>().configModel.maintenanceMode) {
            Get.offNamed(RouteHelper.getUpdateRoute(AppConstants.APP_VERSION < _minimumVersion));
          }else {
            if(widget.body != null) {
              if (widget.body.notificationType == NotificationType.order) {
                Get.offNamed(RouteHelper.getOrderDetailsRoute(widget.body.orderId));
              }else if(widget.body.notificationType == NotificationType.general){
                Get.offNamed(RouteHelper.getNotificationRoute());
              }else {
                Get.offNamed(RouteHelper.getChatRoute(notificationBody: widget.body, conversationID: widget.body.conversationId));
              }
            }else {
              if (Get.find<AuthController>().isLoggedIn()) {
                Get.find<AuthController>().updateToken();
                await Get.find<WishListController>().getWishList();
                Get.offNamed(RouteHelper.getInitialRoute());
                // if (Get.find<LocationController>().getUserAddress() != null) {
                //   Get.offNamed(RouteHelper.getInitialRoute());
                // } else {
                //   Get.offNamed(RouteHelper.getAccessLocationRoute('splash'));
                // }
              } else {
                if (Get.find<SplashController>().showIntro()) {
                  Get.offNamed(RouteHelper.getOnBoardingRoute());
                  if(AppConstants.languages.length > 1) {
                    Get.offNamed(RouteHelper.getLanguageRoute('splash'));
                  }else {
                    Get.offNamed(RouteHelper.getOnBoardingRoute());
                  }
                } else {
                  Get.offNamed(RouteHelper.getSignInRoute(RouteHelper.splash));
                }
              }
            }
          }
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _globalKey,
      body: GetBuilder<SplashController>(builder: (splashController) {
        return Center(
          child: splashController.hasConnection ? Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Image.asset(Images.logo, width: 150),
              SizedBox(height: Dimensions.PADDING_SIZE_LARGE),
              Text(AppConstants.APP_NAME, style: robotoBold.copyWith(
                fontSize: 20, color: Theme.of(context).primaryColor,
              )),
              //Image.asset(Images.logo_name, width: 150),
              /*SizedBox(height: Dimensions.PADDING_SIZE_SMALL),
            Text(AppConstants.APP_NAME, style: robotoMedium.copyWith(fontSize: 25)),*/
            ],
          ) : NoInternetScreen(child: SplashScreen(body: widget.body)),
        );
      }),
    );
  }
}
