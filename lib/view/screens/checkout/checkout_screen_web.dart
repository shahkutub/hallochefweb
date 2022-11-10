import 'package:efood_multivendor/controller/auth_controller.dart';
import 'package:efood_multivendor/controller/cart_controller.dart';
import 'package:efood_multivendor/controller/coupon_controller.dart';
import 'package:efood_multivendor/controller/localization_controller.dart';
import 'package:efood_multivendor/controller/location_controller.dart';
import 'package:efood_multivendor/controller/order_controller.dart';
import 'package:efood_multivendor/controller/restaurant_controller.dart';
import 'package:efood_multivendor/controller/splash_controller.dart';
import 'package:efood_multivendor/controller/user_controller.dart';
import 'package:efood_multivendor/data/model/body/place_order_body.dart';
import 'package:efood_multivendor/data/model/response/address_model.dart';
import 'package:efood_multivendor/data/model/response/cart_model.dart';
import 'package:efood_multivendor/data/model/response/product_model.dart';
import 'package:efood_multivendor/helper/date_converter.dart';
import 'package:efood_multivendor/helper/price_converter.dart';
import 'package:efood_multivendor/helper/responsive_helper.dart';
import 'package:efood_multivendor/helper/route_helper.dart';
import 'package:efood_multivendor/util/app_constants.dart';
import 'package:efood_multivendor/util/dimensions.dart';
import 'package:efood_multivendor/util/images.dart';
import 'package:efood_multivendor/util/styles.dart';
import 'package:efood_multivendor/view/base/custom_app_bar.dart';
import 'package:efood_multivendor/view/base/custom_button.dart';
import 'package:efood_multivendor/view/base/custom_snackbar.dart';
import 'package:efood_multivendor/view/base/custom_text_field.dart';
import 'package:efood_multivendor/view/base/my_text_field.dart';
import 'package:efood_multivendor/view/base/not_logged_in_screen.dart';
import 'package:efood_multivendor/view/base/web_menu_bar.dart';
import 'package:efood_multivendor/view/screens/address/address_screen.dart';
import 'package:efood_multivendor/view/screens/address/widget/address_widget.dart';
import 'package:efood_multivendor/view/screens/cart/widget/delivery_option_button.dart';
import 'package:efood_multivendor/view/screens/checkout/widget/address_dialogue.dart';
import 'package:efood_multivendor/view/screens/checkout/widget/payment_button.dart';
import 'package:efood_multivendor/view/screens/checkout/widget/tips_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:universal_html/html.dart' as html;
import 'package:flutter/material.dart';

import '../cart/cart_screen.dart';

class CheckoutScreenWeb extends StatefulWidget {
  final List<CartModel> cartList;
  final bool fromCart;
  CheckoutScreenWeb({@required this.fromCart, @required this.cartList});

  @override
  _CheckoutScreenWebState createState() => _CheckoutScreenWebState();
}

class _CheckoutScreenWebState extends State<CheckoutScreenWeb> {
  final TextEditingController _couponController = TextEditingController();
  final TextEditingController _noteController = TextEditingController();
  TextEditingController _tipController = TextEditingController();
  TextEditingController _streetNumberController = TextEditingController();
  TextEditingController _houseController = TextEditingController();
  TextEditingController _floorController = TextEditingController();
  final FocusNode _streetNode = FocusNode();
  final FocusNode _houseNode = FocusNode();
  final FocusNode _floorNode = FocusNode();
  double _taxPercent = 0;
  bool _isCashOnDeliveryActive;
  bool _isDigitalPaymentActive;
  bool _isWalletActive;
  bool _isLoggedIn;
  List<CartModel> _cartList;

  static const _daylist = [
    'Mon, Nov 7',
    'Tue, Nov 8',
    'Wed, Nov 9',

  ];

  static const _timelist = [
    'ASAP',
    '12:15 PM',
    '12:30 PM',
    '12:45 PM',
    '1:00 PM',
    '1:15 PM',
    '1:30 PM',
  ];
  final ScrollController scrollController = ScrollController();
  final bool _ltr = Get.find<LocalizationController>().isLtr;
  bool isSwitched = false;
  TextEditingController floorEditextController = TextEditingController();
  TextEditingController apartmentEditextController = TextEditingController();
  var _selectedDay ='Mon, Nov 7';
  var _selectedTime ='ASAP';
  @override
  void initState() {
    super.initState();
    _isLoggedIn = Get.find<AuthController>().isLoggedIn();
    if(_isLoggedIn) {
      Get.find<LocationController>().getZone(
        Get.find<LocationController>().getUserAddress().latitude,
        Get.find<LocationController>().getUserAddress().longitude, false, updateInAddress: true
      );
      Get.find<CouponController>().setCoupon('');

      Get.find<OrderController>().updateTimeSlot(0, notify: false);
      Get.find<OrderController>().updateTips(-1, notify: false);
      Get.find<OrderController>().addTips(0, notify: false);

      if(Get.find<UserController>().userInfoModel == null) {
        Get.find<UserController>().getUserInfo();
      }
      if(Get.find<LocationController>().addressList == null) {
        Get.find<LocationController>().getAddressList();
      }
      _isCashOnDeliveryActive = Get.find<SplashController>().configModel.cashOnDelivery;
      _isDigitalPaymentActive = Get.find<SplashController>().configModel.digitalPayment;
      _isWalletActive = Get.find<SplashController>().configModel.customerWalletStatus == 1;
      _cartList = [];
      widget.fromCart ? _cartList.addAll(Get.find<CartController>().cartList) : _cartList.addAll(widget.cartList);
      Get.find<RestaurantController>().initCheckoutData(_cartList[0].product.restaurantId);
    }
  }

  @override
  void dispose() {
    super.dispose();
    _streetNumberController.dispose();
    _houseController.dispose();
    _floorController.dispose();
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: WebMenuBar(),
      body:
      // _isLoggedIn ?
      // GetBuilder<LocationController>(builder: (locationController) {
        ///return
        Column(
          children: [

            Expanded(child: Scrollbar(child: SingleChildScrollView(
              physics: BouncingScrollPhysics(),
              // padding: EdgeInsets.all(Dimensions.PADDING_SIZE_SMALL),
              child: Center(child: SizedBox(
                width: Dimensions.WEB_MAX_WIDTH,
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [

                  Container(
                    height: 800,
                    //margin: EdgeInsets.fromLTRB(context.width/8, 0, context.width/8, 0),
                      //color: Color(0xFFffffff),
                      child:Row(
                        children: <Widget>[
                          new Flexible(
                            child: Card(
                              elevation: 5,
                              margin: EdgeInsets.all(20),
                              child: Container(
                                color: Color(0xFFffffff),
                                padding: EdgeInsets.all(20),
                                child: Column(
                                  children: [
                                    Row(
                                      children: [
                                        Container(
                                          padding: EdgeInsets.all(10),
                                          color: Colors.deepOrangeAccent,
                                          child: Text('1',style: TextStyle(color: Colors.white),),
                                        ),
                                        SizedBox(width: 20,),
                                        Text('Delivery details',style: TextStyle(color: Colors.black),),
                                      ],
                                    ),

                                    SizedBox(height: 30,),
                                    Container(
                                      height: 100,
                                      color: Color(0xffEEF0F1),
                                      child: Stack(
                                        children: [
                                          Align(
                                            alignment: Alignment.centerLeft,
                                            child: Container(
                                              height: 100,
                                              width: 1,
                                              color: Colors.black,
                                            )
                                          ),
                                          Align(
                                            alignment: Alignment.center,
                                            child: Container(
                                              margin: EdgeInsets.fromLTRB(10, 5, 10, 5),
                                              child: Column(
                                                mainAxisAlignment: MainAxisAlignment.start,
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                children: [
                                                  Text('Contactless delivery',style: TextStyle(color: Colors.black,fontSize: 15),),
                                                  Stack(
                                                    children: [
                                                      Align(
                                                          alignment: Alignment.topLeft,
                                                          child: Container(
                                                              margin: EdgeInsets.fromLTRB(0, 15, 30, 0),
                                                              child: Flexible(child:Text('Please put a note to the rider to let them know where '
                                                              'you want them to leave your order such as your room number or '
                                                              'at the lobby (for online payment) ',textAlign: TextAlign.left,),)
                                                          )

                                                      )
                                                    ],
                                                  )
                                                ],
                                              ),
                                            ),

                                          ),
                                          

                                          Align(
                                            alignment: Alignment.topRight,
                                            child: Container(
                                              //margin: EdgeInsets.all(20),
                                              child: Switch(
                                                activeColor: Colors.deepOrange,
                                              ),
                                            )
                                            
                                            
                                          )


                                        ],
                                      ),
                                    ),

                                    SizedBox(
                                      height: 30,
                                    ),

                                    Row(
                                      children: [
                                        Text('Delivery time :',style: TextStyle(color: Colors.black,),textAlign: TextAlign.left,),
                                      ],
                                    ),

                                    SizedBox(
                                      height: 10,
                                    ),

                                    Row(
                                      children: [
                                        Flexible(child: InputDecorator(
                                            decoration: InputDecoration(
                                              //labelText: 'Fruit',
                                              labelStyle: Theme.of(context).primaryTextTheme.caption.copyWith(color: Colors.black),
                                              border: const OutlineInputBorder(),
                                            ),
                                            child: DropdownButtonHideUnderline(
                                              child: DropdownButton(
                                                isExpanded: true,
                                                isDense: true, // Reduces the dropdowns height by +/- 50%
                                                icon: Icon(Icons.keyboard_arrow_down),
                                                value: _selectedDay,
                                                items: _daylist.map((item) {
                                                  return DropdownMenuItem(
                                                    value: item,
                                                    child: Text(item),
                                                  );
                                                }).toList(),
                                                onChanged: (selectedItem) => setState(() => _selectedDay = selectedItem,
                                                ),
                                              ),
                                            )
                                        ),flex: 1,),
                                        SizedBox(width: 10,),
                                        Flexible(child: InputDecorator(
                                            decoration: InputDecoration(
                                              //labelText: 'Fruit',
                                              labelStyle: Theme.of(context).primaryTextTheme.caption.copyWith(color: Colors.black),
                                              border: const OutlineInputBorder(),
                                            ),
                                            child: DropdownButtonHideUnderline(
                                              child: DropdownButton(
                                                isExpanded: true,
                                                isDense: true, // Reduces the dropdowns height by +/- 50%
                                                icon: Icon(Icons.keyboard_arrow_down),
                                                value: _selectedTime,
                                                items: _timelist.map((item) {
                                                  return DropdownMenuItem(
                                                    value: item,
                                                    child: Text(item),
                                                  );
                                                }).toList(),
                                                onChanged: (selectedItem) => setState(() => _selectedTime = selectedItem,
                                                ),
                                              ),
                                            )
                                        ),flex: 1,),
                                      ],
                                    ),

                                    SizedBox(
                                      height: 15,
                                    ),
                                    Row(
                                      children: [
                                        Text('Delivery Address',style: TextStyle(color: Colors.black,),textAlign: TextAlign.left,),
                                      ],
                                    ),
                                    SizedBox(
                                      height: 15,
                                    ),

                                    Container(
                                      child: Image.asset(
                                        'assets/image/map_big.png',
                                        // height: 350,
                                        // width: context.width,
                                        fit: BoxFit.fill,),

                                    ),
                                    SizedBox(
                                      height: 5,
                                    ),
                                    GetBuilder<LocationController>(builder: (locationController) {
                                      return Column(
                                        children: [
                                          Container(
                                            padding: EdgeInsets.all(5),
                                            child:Stack(
                                              children: [
                                                Align(
                                                  alignment: Alignment.topLeft,
                                                  child: Stack(
                                                    children: [
                                                      Align(alignment: Alignment.topLeft,
                                                          child: Container(
                                                            //margin: EdgeInsets.only(top: 5),
                                                            width: 1000,
                                                            child:Row(
                                                              crossAxisAlignment: CrossAxisAlignment.center,
                                                              mainAxisAlignment: MainAxisAlignment.start,
                                                              children: [


                                                                Container(
                                                                  alignment: Alignment.center,
                                                                  height: 40,
                                                                  width: 40,
                                                                  //padding: EdgeInsets.all(10),
                                                                  //margin: EdgeInsets.all(100.0),
                                                                  decoration: BoxDecoration(
                                                                    ///color: Colors.deepOrangeAccent.withOpacity(0.5),
                                                                      color: Color(0xFFE34A28).withOpacity(0.1),
                                                                      shape: BoxShape.circle
                                                                  ),
                                                                  child: Icon(
                                                                      locationController.getUserAddress().addressType == 'home' ? Icons.home_filled : locationController.getUserAddress().addressType == 'office' ? Icons.work : Icons.location_on_outlined,
                                                                      size: 30, color: Color(0xFFE34A28)),
                                                                ),
                                                                // SizedBox(width: 10),
                                                                // Icon(
                                                                //   locationController.getUserAddress().addressType == 'home' ? Icons.home_filled : locationController.getUserAddress().addressType == 'office' ? Icons.work : Icons.location_on,
                                                                //   size: 20, color: Colors.white,),
                                                                SizedBox(width: 10),
                                                                Flexible(
                                                                  child: Text(
                                                                    //'Gulshan, dhaka',
                                                                    locationController.getUserAddress().address,
                                                                    style: robotoRegular.copyWith(
                                                                      color: Color(0xFFE34A28), fontSize: Dimensions.fontSizeSmall,
                                                                    ),
                                                                    maxLines: 1, overflow: TextOverflow.ellipsis,
                                                                  ),
                                                                ),

                                                                Container(
                                                                  margin: EdgeInsets.only(left: 25,right: 15),
                                                                  height: 50,
                                                                  width: 1,
                                                                  color: Color(0xffEBEBEB),
                                                                ),



                                                              ],
                                                            ),


                                                          )

                                                        //Image.asset(Images.logo,height: 70,width: 70,fit: BoxFit.fill,),
                                                      ),

                                                    ],
                                                  ),
                                                ),

                                                // Align(
                                                //   alignment: Alignment.bottomLeft,
                                                //   child: Stack(
                                                //     children: [
                                                //       Align(
                                                //         alignment: Alignment.topLeft,
                                                //         child: InkWell(
                                                //             onTap: (){
                                                //               //Get.to(RouteHelper.getAccessLocationRoute(''));
                                                //               Get.to(AccessLocationScreen(fromSignUp: false, fromHome: false, route: Get.currentRoute));
                                                //             },
                                                //             child: Row(crossAxisAlignment: CrossAxisAlignment.center, mainAxisAlignment: MainAxisAlignment.start,
                                                //               children: [
                                                //                 Icon(
                                                //                   locationController.getUserAddress().addressType == 'home' ? Icons.home_filled
                                                //                       : locationController.getUserAddress().addressType == 'office' ? Icons.work : Icons.location_on,
                                                //                   size: 20, color: Theme.of(context).textTheme.bodyText1.color,
                                                //                 ),
                                                //                 SizedBox(width: 10),
                                                //                 Flexible(
                                                //                   child: Text(
                                                //                     locationController.getUserAddress().address,
                                                //                     style: robotoRegular.copyWith(
                                                //                       color: Colors.white, fontSize: Dimensions.fontSizeSmall,
                                                //                     ),
                                                //                     maxLines: 1, overflow: TextOverflow.ellipsis,
                                                //                   ),
                                                //                 ),
                                                //                 Icon(Icons.arrow_drop_down, color: Theme.of(context).textTheme.bodyText1.color),
                                                //               ],
                                                //             )
                                                //         ),
                                                //       )
                                                //     ],
                                                //   ),
                                                // ),
                                              ],
                                            ),
                                          ),
                                          // Stack(
                                          //   children: [
                                          //     Align(
                                          //       alignment: Alignment.topLeft,
                                          //       child: Stack(
                                          //         children: [
                                          //           Align(alignment: Alignment.topLeft,
                                          //             child: Container(
                                          //               margin: EdgeInsets.only(top: 5),
                                          //               width: 300,
                                          //               child:Row(
                                          //                 crossAxisAlignment: CrossAxisAlignment.center,
                                          //                 mainAxisAlignment: MainAxisAlignment.start,
                                          //                 children: [
                                          //
                                          //                   Image.asset(Images.logo,height: 40,width: 40,fit: BoxFit.fill,),
                                          //                   Text('HalloChef',style: TextStyle(fontSize: 30),),
                                          //                   //Image.asset(Images.logo_name,height: 70,width: 220,fit: BoxFit.fill,),
                                          //                   SizedBox(
                                          //                     //width: 20,
                                          //                   )
                                          //                 ],
                                          //               ),
                                          //
                                          //
                                          //             )
                                          //
                                          //             //Image.asset(Images.logo,height: 70,width: 70,fit: BoxFit.fill,),
                                          //           ),
                                          //           Align(
                                          //             alignment: Alignment.topRight,
                                          //             child: Container(
                                          //               margin: EdgeInsets.only(top: 10),
                                          //               width: 300,
                                          //               child:Row(
                                          //                 crossAxisAlignment: CrossAxisAlignment.center,
                                          //                 mainAxisAlignment: MainAxisAlignment.end,
                                          //                 children: [
                                          //
                                          //                   Container(
                                          //                     margin: EdgeInsets.only(left: 5,right: 5),
                                          //                     height: 30,
                                          //                     width: 1,
                                          //                     color: Colors.white,
                                          //                   ),
                                          //
                                          //                   InkWell(
                                          //                     child: Row(
                                          //                       crossAxisAlignment: CrossAxisAlignment.center,
                                          //                       mainAxisAlignment: MainAxisAlignment.center,
                                          //                       children: [
                                          //                         Icon(
                                          //                             Icons.account_circle_sharp,
                                          //                             color: Colors.white,
                                          //                             size: 30, // also decreased the size of the icon a bit
                                          //                           ),
                                          //
                                          //                         Text("Login",style: TextStyle(fontSize: 12),), // here, inside the column
                                          //                       ],
                                          //                     ),
                                          //                   ),
                                          //
                                          //                   Container(
                                          //                     margin: EdgeInsets.only(left: 5,right: 15),
                                          //                     height: 30,
                                          //                     width: 1,
                                          //                     color: Colors.white,
                                          //                   ),
                                          //
                                          //                   InkWell(
                                          //                     onTap: (){
                                          //                       Get.to(CartScreen(fromNav: true),);
                                          //                     },
                                          //                     child: Icon(Icons.shopping_bag_outlined),
                                          //                   ),
                                          //                   SizedBox(
                                          //                     //width: 20,
                                          //                   )
                                          //                 ],
                                          //               ),
                                          //
                                          //
                                          //             )
                                          //
                                          //             // InkWell(
                                          //             //     onTap: (){
                                          //             //       //Get.to(RouteHelper.getAccessLocationRoute(''));
                                          //             //       Get.to(AccessLocationScreen(fromSignUp: false, fromHome: false, route: Get.currentRoute));
                                          //             //     },
                                          //             //     child: Row(crossAxisAlignment: CrossAxisAlignment.start, mainAxisAlignment: MainAxisAlignment.start,
                                          //             //       children: [
                                          //             //         Icon(
                                          //             //           locationController.getUserAddress().addressType == 'home' ? Icons.home_filled
                                          //             //               : locationController.getUserAddress().addressType == 'office' ? Icons.work : Icons.location_on,
                                          //             //           size: 20, color: Theme.of(context).textTheme.bodyText1.color,
                                          //             //         ),
                                          //             //         SizedBox(width: 10),
                                          //             //         Flexible(
                                          //             //           child: Text(
                                          //             //             locationController.getUserAddress().address,
                                          //             //             style: robotoRegular.copyWith(
                                          //             //               color: Colors.white, fontSize: Dimensions.fontSizeSmall,
                                          //             //             ),
                                          //             //             maxLines: 1, overflow: TextOverflow.ellipsis,
                                          //             //           ),
                                          //             //         ),
                                          //             //         Icon(Icons.arrow_drop_down, color: Theme.of(context).textTheme.bodyText1.color),
                                          //             //       ],
                                          //             //     )
                                          //             // ),
                                          //           )
                                          //         ],
                                          //       ),
                                          //     ),
                                          //
                                          //     // Align(
                                          //     //   alignment: Alignment.bottomLeft,
                                          //     //   child: Stack(
                                          //     //     children: [
                                          //     //       Align(
                                          //     //         alignment: Alignment.topLeft,
                                          //     //         child: InkWell(
                                          //     //             onTap: (){
                                          //     //               //Get.to(RouteHelper.getAccessLocationRoute(''));
                                          //     //               Get.to(AccessLocationScreen(fromSignUp: false, fromHome: false, route: Get.currentRoute));
                                          //     //             },
                                          //     //             child: Row(crossAxisAlignment: CrossAxisAlignment.center, mainAxisAlignment: MainAxisAlignment.start,
                                          //     //               children: [
                                          //     //                 Icon(
                                          //     //                   locationController.getUserAddress().addressType == 'home' ? Icons.home_filled
                                          //     //                       : locationController.getUserAddress().addressType == 'office' ? Icons.work : Icons.location_on,
                                          //     //                   size: 20, color: Theme.of(context).textTheme.bodyText1.color,
                                          //     //                 ),
                                          //     //                 SizedBox(width: 10),
                                          //     //                 Flexible(
                                          //     //                   child: Text(
                                          //     //                     locationController.getUserAddress().address,
                                          //     //                     style: robotoRegular.copyWith(
                                          //     //                       color: Colors.white, fontSize: Dimensions.fontSizeSmall,
                                          //     //                     ),
                                          //     //                     maxLines: 1, overflow: TextOverflow.ellipsis,
                                          //     //                   ),
                                          //     //                 ),
                                          //     //                 Icon(Icons.arrow_drop_down, color: Theme.of(context).textTheme.bodyText1.color),
                                          //     //               ],
                                          //     //             )
                                          //     //         ),
                                          //     //       )
                                          //     //     ],
                                          //     //   ),
                                          //     // ),
                                          //   ],
                                          // ),
                                          //
                                          // Stack(
                                          //   children: [
                                          //     Align(
                                          //       alignment: Alignment.topLeft,
                                          //       child: Stack(
                                          //         children: [
                                          //           Align(alignment: Alignment.topLeft,
                                          //             child: Container(
                                          //               //width: 500,
                                          //               child: InkWell(
                                          //                   onTap: (){
                                          //                     //Get.to(RouteHelper.getAccessLocationRoute(''));
                                          //                     Get.to(AccessLocationScreen(fromSignUp: false, fromHome: false, route: Get.currentRoute));
                                          //                   },
                                          //                   child: Row(crossAxisAlignment: CrossAxisAlignment.center, mainAxisAlignment: MainAxisAlignment.start,
                                          //                     children: [
                                          //
                                          //                       Text('Delivering to : ',style: TextStyle(fontSize: 12),),
                                          //
                                          //                       // Container(
                                          //                       //   height: 60,
                                          //                       //     width: 60,
                                          //                       //     decoration: BoxDecoration(
                                          //                       //         border: Border.all(
                                          //                       //           color: Colors.red[500].withOpacity(2.0),
                                          //                       //         ),
                                          //                       //         borderRadius: BorderRadius.all(Radius.circular(20))
                                          //                       //     ),
                                          //                       //
                                          //                       // ),
                                          //                       Icon(
                                          //                         locationController.getUserAddress().addressType == 'home' ? Icons.home_filled
                                          //                             : locationController.getUserAddress().addressType == 'office' ? Icons.work : Icons.location_on,
                                          //                         size: 20, color: Colors.white,
                                          //                       ),
                                          //
                                          //                       SizedBox(width: 10),
                                          //                       Flexible(
                                          //                         child: Text(
                                          //                           locationController.getUserAddress().address,
                                          //                           style: robotoRegular.copyWith(
                                          //                             color: Colors.white, fontSize: Dimensions.fontSizeSmall,
                                          //                           ),
                                          //                           maxLines: 1, overflow: TextOverflow.ellipsis,
                                          //                         ),
                                          //                       ),
                                          //                       Icon(Icons.arrow_drop_down, color: Theme.of(context).textTheme.bodyText1.color),
                                          //
                                          //                       Container(
                                          //                         margin: EdgeInsets.only(left: 15,right: 15),
                                          //                         height: 30,
                                          //                         width: 1,
                                          //                         color: Colors.white,
                                          //                       ),
                                          //
                                          //                       Text('WHEN : ',style: TextStyle(fontSize: 12),),
                                          //
                                          //                       Text('ASAP  ',style: TextStyle(fontSize: 12),),
                                          //                       Icon(Icons.keyboard_arrow_down_sharp, color: Colors.white)
                                          //
                                          //                     ],
                                          //                   )
                                          //               ),
                                          //             )
                                          //           ),
                                          //           // Align(
                                          //           //   alignment: Alignment.topRight,
                                          //           //   child: Image.asset(Images.logo,height: 50,width: 50,),
                                          //           //
                                          //           //
                                          //           // )
                                          //         ],
                                          //       ),
                                          //     ),
                                          //
                                          //     // Align(
                                          //     //   alignment: Alignment.bottomLeft,
                                          //     //   child: Stack(
                                          //     //     children: [
                                          //     //       Align(
                                          //     //         alignment: Alignment.topLeft,
                                          //     //         child: InkWell(
                                          //     //             onTap: (){
                                          //     //               //Get.to(RouteHelper.getAccessLocationRoute(''));
                                          //     //               Get.to(AccessLocationScreen(fromSignUp: false, fromHome: false, route: Get.currentRoute));
                                          //     //             },
                                          //     //             child: Row(crossAxisAlignment: CrossAxisAlignment.center, mainAxisAlignment: MainAxisAlignment.start,
                                          //     //               children: [
                                          //     //                 Icon(
                                          //     //                   locationController.getUserAddress().addressType == 'home' ? Icons.home_filled
                                          //     //                       : locationController.getUserAddress().addressType == 'office' ? Icons.work : Icons.location_on,
                                          //     //                   size: 20, color: Theme.of(context).textTheme.bodyText1.color,
                                          //     //                 ),
                                          //     //                 SizedBox(width: 10),
                                          //     //                 Flexible(
                                          //     //                   child: Text(
                                          //     //                     locationController.getUserAddress().address,
                                          //     //                     style: robotoRegular.copyWith(
                                          //     //                       color: Colors.white, fontSize: Dimensions.fontSizeSmall,
                                          //     //                     ),
                                          //     //                     maxLines: 1, overflow: TextOverflow.ellipsis,
                                          //     //                   ),
                                          //     //                 ),
                                          //     //                 Icon(Icons.arrow_drop_down, color: Theme.of(context).textTheme.bodyText1.color),
                                          //     //               ],
                                          //     //             )
                                          //     //         ),
                                          //     //       )
                                          //     //     ],
                                          //     //   ),
                                          //     // ),
                                          //   ],
                                          // )
                                        ],
                                      );

                                    }
                                    ),
                                    SizedBox(
                                      height: 10,
                                    ),

                                    Row(
                                      children: [
                                        Flexible(
                                          child: TextField(
                                            controller: floorEditextController,
                                            decoration: InputDecoration(
                                              border: OutlineInputBorder(),
                                              labelText: 'Floor/ Unit',
                                              hintText: 'Enter Floor/ Unit',
                                            ),
                                          ),
                                          flex: 1,
                                        ),

                                        SizedBox(width: 20,),

                                        Flexible(
                                          child: TextField(
                                            controller: apartmentEditextController,
                                            decoration: InputDecoration(
                                              border: OutlineInputBorder(),
                                              labelText: 'Apartment',
                                              hintText: 'Enter Your Apartment',
                                            ),
                                          ),
                                          flex: 1,
                                        ),
                                      ],
                                    ),
                                    SizedBox(height: 20,),
                                    Container(
                                      height: 70,
                                      child: TextField(
                                        controller: apartmentEditextController,
                                        decoration: InputDecoration(
                                          contentPadding: EdgeInsets.symmetric(vertical: 40.0,horizontal: 40.0),
                                          border: OutlineInputBorder(),
                                          labelText: 'Note to ride',
                                          hintText: 'Enter Note to ride',
                                        ),
                                      ),
                                    )



                                  ],
                                ),
                              ),

                            ),
                            flex: 8,),
                          new Flexible(


                            child: CartScreen(fromNav: false),
                            //child: Container(
                            //alignment: Alignment.center,
                            // child: Column(
                            //   crossAxisAlignment: CrossAxisAlignment.stretch,
                            //   //mainAxisAlignment: MainAxisAlignment.center,
                            //   children: [
                            //
                            //
                            //
                            //     SizedBox(height: 20,),
                            //
                            //     Row(
                            //       crossAxisAlignment: CrossAxisAlignment.center,
                            //       mainAxisAlignment: MainAxisAlignment.center,
                            //       children: [
                            //         Switch(
                            //           activeColor: Color(0xffE34A28),
                            //           value: isSwitched,
                            //           onChanged: (value) {
                            //             setState(() {
                            //               isSwitched = value;
                            //             });
                            //           },
                            //         ),
                            //         SizedBox(width: 10,),
                            //         Text('Pick Up',style: TextStyle(fontSize: 15,color: Colors.black),)
                            //       ],
                            //     ),
                            //
                            //
                            //     SizedBox(height: 20,),
                            //     Row(
                            //       crossAxisAlignment: CrossAxisAlignment.center,
                            //       mainAxisAlignment: MainAxisAlignment.center,
                            //       children: [
                            //         Text('Your Cart',style: TextStyle(fontSize: 15,color: Colors.black),)
                            //       ],
                            //     ),
                            //     SizedBox(height: 20,),
                            //     Row(
                            //       crossAxisAlignment: CrossAxisAlignment.center,
                            //       mainAxisAlignment: MainAxisAlignment.center,
                            //       children: [
                            //         Text('Start adding items to your cart',style: TextStyle(fontSize: 10,color: Colors.grey),)
                            //       ],
                            //     ),
                            //
                            //     SizedBox(height: 20,),
                            //
                            //     Container(
                            //       margin: EdgeInsets.fromLTRB(5, 0, 5, 0),
                            //       width: context.width/5,
                            //       height: 1,
                            //       color: Colors.grey,
                            //     ),
                            //
                            //     SizedBox(height: 20,),
                            //     Row(
                            //       crossAxisAlignment: CrossAxisAlignment.center,
                            //       mainAxisAlignment: MainAxisAlignment.end,
                            //       children: [
                            //         Text(' Tk 0   ',style: TextStyle(fontSize: 12,color: Colors.grey),)
                            //       ],
                            //     ),
                            //
                            //     SizedBox(height: 20,),
                            //     Row(
                            //       crossAxisAlignment: CrossAxisAlignment.center,
                            //       mainAxisAlignment: MainAxisAlignment.end,
                            //       children: [
                            //         Text(' Tk 0   ',style: TextStyle(fontSize: 12,color: Colors.black,fontWeight: FontWeight.bold),)
                            //       ],
                            //     ),
                            //
                            //
                            //     SizedBox(height: 40,),
                            //     //Go to Checkout
                            //     InkWell(
                            //       onTap: (){
                            //         //Navigator.of(context).push(MaterialPageRoute(builder: (context) => DashboardScreenWeb(pageIndex: 0,)));
                            //       },
                            //       child: Container(
                            //         margin: EdgeInsets.fromLTRB(15, 0, 15, 0),
                            //         padding: EdgeInsets.fromLTRB(25, 7, 25, 7),
                            //         // height: 30,
                            //         //width: 100,
                            //         decoration: BoxDecoration(
                            //
                            //           color: Color(0xFFCACACA),
                            //           borderRadius: BorderRadius.all(
                            //             Radius.circular(5),
                            //           ),
                            //           border: Border.all(
                            //             width: 1,
                            //             color: Colors.white,
                            //             style: BorderStyle.solid,
                            //           ),
                            //         ),
                            //         child: Center(
                            //           child: Text(
                            //             "Go to Checkout",style: TextStyle(fontSize: 15,color: Colors.white),
                            //           ),
                            //         ),
                            //       ),
                            //     )
                            //
                            //   ],
                            // ),
                            //),
                            flex: 4,)
                        ],
                      )


                  )

                ]),
              )),
            ))),


          ],
        )
        //;
      //})
         // : Get.toNamed(RouteHelper.getSignInRoute(RouteHelper.main))
    );
  }

  void _callback(bool isSuccess, String message, String orderID, double amount) async {
    if(isSuccess) {
      if(Get.find<OrderController>().isRunningOrderViewShow == false){
        Get.find<OrderController>().closeRunningOrder(true);
      }
      Get.find<OrderController>().getRunningOrders(1, notify: false, fromHome: true);
      if(widget.fromCart) {
        Get.find<CartController>().clearCartList();
      }
      Get.find<OrderController>().stopLoader();
      if(Get.find<OrderController>().paymentMethodIndex == 0 || Get.find<OrderController>().paymentMethodIndex == 2) {
        Get.offNamed(RouteHelper.getOrderSuccessRoute(orderID, 'success', amount));
      }else {
       if(GetPlatform.isWeb) {
         Get.back();
         String hostname = html.window.location.hostname;
         String protocol = html.window.location.protocol;
         String selectedUrl = '${AppConstants.BASE_URL}/payment-mobile?order_id=$orderID&customer_id=${Get.find<UserController>()
             .userInfoModel.id}&&callback=$protocol//$hostname${RouteHelper.orderSuccess}?id=$orderID&amount=$amount&status=';
         html.window.open(selectedUrl,"_self");
       } else{
         Get.offNamed(RouteHelper.getPaymentRoute(orderID, Get.find<UserController>().userInfoModel.id, amount));
       }
      }
      Get.find<OrderController>().clearPrevData();
      Get.find<OrderController>().updateTips(-1);
      Get.find<CouponController>().removeCouponData(false);
    }else {
      showCustomSnackBar(message);
    }
  }
}
