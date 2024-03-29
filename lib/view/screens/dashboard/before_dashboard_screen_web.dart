import 'dart:async';
import 'dart:ui';

import 'package:efood_multivendor/controller/order_controller.dart';
import 'package:efood_multivendor/data/model/response/distance_model.dart';
import 'package:efood_multivendor/helper/responsive_helper.dart';
import 'package:efood_multivendor/util/app_constants.dart';
import 'package:efood_multivendor/util/dimensions.dart';
import 'package:efood_multivendor/view/base/cart_widget.dart';
import 'package:efood_multivendor/view/screens/cart/cart_screen.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_google_places/flutter_google_places.dart';
import 'package:flutter_google_places_web/flutter_google_places_web.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';

import '../../../controller/auth_controller.dart';

import '../../../controller/location_controller.dart';
import '../../../data/model/response/address_model.dart';
import '../../../data/model/response/zone_response_model.dart';
import '../../../helper/route_helper.dart';
import '../../../util/images.dart';
import '../../base/custom_loader.dart';
import '../../base/custom_snackbar.dart';
import '../location/widget/permission_dialog.dart';
import 'dashboard_screen_web.dart';
import 'dart:async';
import 'dart:math';

import 'package:google_api_headers/google_api_headers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_google_places/flutter_google_places.dart';
import 'package:google_maps_webservice/places.dart';

class BeforeDashboardScreenWeb extends StatefulWidget {
  final int pageIndex;
  BeforeDashboardScreenWeb({@required this.pageIndex});

  @override
  _DashboardScreenState createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<BeforeDashboardScreenWeb> {
  //String kGoogleApiKey = "AIzaSyCaCSJ0BZItSyXqBv8vpD1N4WBffJeKhLQ";
  String kGoogleApiKey = "AIzaSyDbyQUqqWpxFCkZJdGSxqc4f-zDTR8QZfU";
  //PageController _pageController;
  int _pageIndex = 0;
  //List<Widget> _screens;
  GlobalKey<ScaffoldMessengerState> _scaffoldKey = GlobalKey();
  bool _canExit = GetPlatform.isWeb ? true : false;
  // int currentIndex = 0;
  final List<Map<String, dynamic>> tabtitles = [
    {
      'title': "Delivery",
      'img':Images.deliverytab
    },
    {
      'title': "Pick-Up",
      'img':Images.pick_up_tab
    },
    {
      'title': "Dine-in",
      'img':Images.dine_in_tab
    },
    {
      'title': "Book-table",
      'img':Images.booktable_tab
    }
  ];
  final TextEditingController _searchController = TextEditingController();
  bool _isLoggedIn;

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
    //   //Get.dialog(CustomLoader(), barrierDismissible: false);
    //   AddressModel _address = await Get.find<LocationController>().getCurrentLocation(true);
    //   ZoneResponseModel _response = await Get.find<LocationController>().getZone(_address.latitude, _address.longitude, false);
    //   if(_response.isSuccess) {
    //     Get.find<LocationController>().saveAddressAndNavigate(_address, false,Get.currentRoute,false);
    //   }else {
    //     // Get.back();
    //     // Get.toNamed(RouteHelper.getPickMapRoute(route == null ? RouteHelper.accessLocation : route, route != null));
    //     // showCustomSnackBar('service_not_available_in_current_location'.tr);
    //   }
    // });


    //_pageIndex = widget.pageIndex;

    // _pageController = PageController(initialPage: widget.pageIndex);

    // _screens = [
    //   HomeScreen(),
    //   FavouriteScreen(),
    //   CartScreen(fromNav: true),
    //   OrderScreen(),
    //   Container(),
    // ];
    //
    // Future.delayed(Duration(seconds: 1), () {
    //   setState(() {});
    // });

    /*if(GetPlatform.isMobile) {
      NetworkInfo.checkConnectivity(_scaffoldKey.currentContext);
    }*/


    // Get.find<CategoryController>().getCategoryList(true);
    _isLoggedIn = Get.find<AuthController>().isLoggedIn();
    if(_isLoggedIn) {
      // Get.find<SearchController>().getSuggestedFoods();
      // Get.find<SearchController>().getHistoryList();
    }

    //Get.find<OrderController>().getRunningOrders(1, notify: false, fromHome: true);

    //Get.find<SearchController>().getHistoryList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold
      (
      key: _scaffoldKey,


      backgroundColor: Color(0xffFFFFFF),
      // appBar: AppBar(
      //   //backgroundColor: Color(0xffEEF2F5),
      //   toolbarHeight: 60,
      //   //title: const  Text('') ,
      //   title: GetBuilder<LocationController>(builder: (locationController) {
      //     return Column(
      //       children: [
      //         Stack(
      //           children: [
      //             Align(
      //               alignment: Alignment.topLeft,
      //               child: Stack(
      //                 children: [
      //                   Align(alignment: Alignment.topLeft,
      //                     child: Container(
      //                       margin: EdgeInsets.only(top: 5),
      //                       width: 300,
      //                       child:Row(
      //                         crossAxisAlignment: CrossAxisAlignment.center,
      //                         mainAxisAlignment: MainAxisAlignment.start,
      //                         children: [
      //
      //                           Image.asset(Images.logo,height: 40,width: 40,fit: BoxFit.fill,),
      //                           Text('HalloChef',style: TextStyle(fontSize: 20),),
      //                           //Image.asset(Images.logo_name,height: 70,width: 220,fit: BoxFit.fill,),
      //                           SizedBox(
      //                             //width: 20,
      //                           )
      //                         ],
      //                       ),
      //
      //
      //                     )
      //
      //                     //Image.asset(Images.logo,height: 70,width: 70,fit: BoxFit.fill,),
      //                   ),
      //                   Align(
      //                     alignment: Alignment.topRight,
      //                     child: Container(
      //                       margin: EdgeInsets.only(top: 10),
      //                       width: 300,
      //                       child:Row(
      //                         crossAxisAlignment: CrossAxisAlignment.center,
      //                         mainAxisAlignment: MainAxisAlignment.end,
      //                         children: [
      //                           Container(
      //                             margin: EdgeInsets.only(left: 5,right: 5),
      //                             height: 30,
      //                             width: 1,
      //                             color: Colors.white,
      //                           ),
      //                           Text("BN",style: TextStyle(fontSize: 12),), // here, inside the column
      //
      //                           Container(
      //                             margin: EdgeInsets.only(left: 5,right: 5),
      //                             height: 30,
      //                             width: 1,
      //                             color: Colors.white,
      //                           ),
      //
      //                           InkWell(
      //                             child: Row(
      //                               crossAxisAlignment: CrossAxisAlignment.center,
      //                               mainAxisAlignment: MainAxisAlignment.center,
      //                               children: [
      //                                 Icon(
      //                                     Icons.account_circle_sharp,
      //                                     color: Colors.white,
      //                                     size: 30, // also decreased the size of the icon a bit
      //                                   ),
      //
      //                                 Text("Login",style: TextStyle(fontSize: 12),), // here, inside the column
      //                               ],
      //                             ),
      //                           ),
      //
      //                           Container(
      //                             margin: EdgeInsets.only(left: 5,right: 15),
      //                             height: 30,
      //                             width: 1,
      //                             color: Colors.white,
      //                           ),
      //
      //                           InkWell(
      //                             onTap: (){
      //                               Get.to(CartScreen(fromNav: true),);
      //                             },
      //                             child: Icon(Icons.shopping_bag_outlined),
      //                           ),
      //                           SizedBox(
      //                             //width: 20,
      //                           )
      //                         ],
      //                       ),
      //
      //
      //                     )
      //
      //                     // InkWell(
      //                     //     onTap: (){
      //                     //       //Get.to(RouteHelper.getAccessLocationRoute(''));
      //                     //       Get.to(AccessLocationScreen(fromSignUp: false, fromHome: false, route: Get.currentRoute));
      //                     //     },
      //                     //     child: Row(crossAxisAlignment: CrossAxisAlignment.start, mainAxisAlignment: MainAxisAlignment.start,
      //                     //       children: [
      //                     //         Icon(
      //                     //           locationController.getUserAddress().addressType == 'home' ? Icons.home_filled
      //                     //               : locationController.getUserAddress().addressType == 'office' ? Icons.work : Icons.location_on,
      //                     //           size: 20, color: Theme.of(context).textTheme.bodyText1.color,
      //                     //         ),
      //                     //         SizedBox(width: 10),
      //                     //         Flexible(
      //                     //           child: Text(
      //                     //             locationController.getUserAddress().address,
      //                     //             style: robotoRegular.copyWith(
      //                     //               color: Colors.white, fontSize: Dimensions.fontSizeSmall,
      //                     //             ),
      //                     //             maxLines: 1, overflow: TextOverflow.ellipsis,
      //                     //           ),
      //                     //         ),
      //                     //         Icon(Icons.arrow_drop_down, color: Theme.of(context).textTheme.bodyText1.color),
      //                     //       ],
      //                     //     )
      //                     // ),
      //                   )
      //                 ],
      //               ),
      //             ),
      //
      //             // Align(
      //             //   alignment: Alignment.bottomLeft,
      //             //   child: Stack(
      //             //     children: [
      //             //       Align(
      //             //         alignment: Alignment.topLeft,
      //             //         child: InkWell(
      //             //             onTap: (){
      //             //               //Get.to(RouteHelper.getAccessLocationRoute(''));
      //             //               Get.to(AccessLocationScreen(fromSignUp: false, fromHome: false, route: Get.currentRoute));
      //             //             },
      //             //             child: Row(crossAxisAlignment: CrossAxisAlignment.center, mainAxisAlignment: MainAxisAlignment.start,
      //             //               children: [
      //             //                 Icon(
      //             //                   locationController.getUserAddress().addressType == 'home' ? Icons.home_filled
      //             //                       : locationController.getUserAddress().addressType == 'office' ? Icons.work : Icons.location_on,
      //             //                   size: 20, color: Theme.of(context).textTheme.bodyText1.color,
      //             //                 ),
      //             //                 SizedBox(width: 10),
      //             //                 Flexible(
      //             //                   child: Text(
      //             //                     locationController.getUserAddress().address,
      //             //                     style: robotoRegular.copyWith(
      //             //                       color: Colors.white, fontSize: Dimensions.fontSizeSmall,
      //             //                     ),
      //             //                     maxLines: 1, overflow: TextOverflow.ellipsis,
      //             //                   ),
      //             //                 ),
      //             //                 Icon(Icons.arrow_drop_down, color: Theme.of(context).textTheme.bodyText1.color),
      //             //               ],
      //             //             )
      //             //         ),
      //             //       )
      //             //     ],
      //             //   ),
      //             // ),
      //           ],
      //         ),
      //       ],
      //     );
      //
      //   }
      //   ),
      //   // actions: [
      //   //   InkWell(
      //   //     onTap: (){
      //   //       Get.to(CartScreen(fromNav: true),);
      //   //     },
      //   //     child: Icon(Icons.shopping_bag_outlined),
      //   //   ),
      //   //
      //   //   SizedBox(width: 10,)
      //   // ],
      //  // bottom: PreferredSize(
      //  //    preferredSize:const Size.fromHeight(40),
      //  //    child: GetBuilder<LocationController>(builder: (locationController) {
      //  //      return Container(
      //  //        margin: EdgeInsets.fromLTRB(70, 0, 70, 0),
      //  //        child: Row(
      //  //          children: [
      //  //            InkWell(
      //  //                onTap: (){
      //  //                  //Get.to(RouteHelper.getAccessLocationRoute(''));
      //  //                  Get.to(AccessLocationScreen(fromSignUp: false, fromHome: false, route: Get.currentRoute));
      //  //                },
      //  //                child: Row(crossAxisAlignment: CrossAxisAlignment.center, mainAxisAlignment: MainAxisAlignment.start,
      //  //                  children: [
      //  //                    Icon(
      //  //                      locationController.getUserAddress().addressType == 'home' ? Icons.home_filled
      //  //                          : locationController.getUserAddress().addressType == 'office' ? Icons.work : Icons.location_on,
      //  //                      size: 20, color: Theme.of(context).textTheme.bodyText1.color,
      //  //                    ),
      //  //                    SizedBox(width: 10),
      //  //                    Flexible(
      //  //                      child: Text(
      //  //                        locationController.getUserAddress().address,
      //  //                        style: robotoRegular.copyWith(
      //  //                          color: Colors.white, fontSize: Dimensions.fontSizeSmall,
      //  //                        ),
      //  //                        maxLines: 1, overflow: TextOverflow.ellipsis,
      //  //                      ),
      //  //                    ),
      //  //                    Icon(Icons.arrow_drop_down, color: Theme.of(context).textTheme.bodyText1.color),
      //  //                  ],
      //  //                )
      //  //            )
      //  //          ],
      //  //        )
      //  //      );
      //  //
      //  //    }
      //  //    ),
      //  //
      //  // ),
      // ),
      body: Column(
        children: [

          Container(
            color: Color(0xFFE34A28),
            child:Stack(
              children: [
                Align(
                  alignment: Alignment.topLeft,
                  child: Stack(
                    children: [
                      Align(alignment: Alignment.center,
                          child: Container(
                            width: 600,
                            padding: EdgeInsets.all(10),
                            child:Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [

                                Icon(Icons.work_outline_outlined,size: 40,color: Colors.white,),
                                Text('   Do you need a business account?  ',style: TextStyle(fontSize: 17,color: Colors.white),),
                                Container(
                                  padding: EdgeInsets.fromLTRB(10, 15, 10, 15),
                                  //height: 100,
                                  // width: 100,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(5),
                                    ),
                                    border: Border.all(
                                      width: 1,
                                      color: Colors.white,
                                      style: BorderStyle.solid,
                                    ),
                                  ),
                                  child: Center(
                                    child: Text(
                                      "SIGN UP NOW",style: TextStyle(fontSize: 15,color: Colors.white),
                                    ),
                                  ),
                                ),
                              ],
                            ),


                          )

                        //Image.asset(Images.logo,height: 70,width: 70,fit: BoxFit.fill,),
                      ),
                      Align(
                          alignment: Alignment.topRight,
                          child: Container(
                            margin: EdgeInsets.only(top: 10),
                            width: 50,
                            child:Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [

                                InkWell(
                                  onTap: (){
                                    //Get.to(CartScreen(fromNav: true),);
                                  },
                                  child: Icon(Icons.clear,color: Colors.white,),
                                ),
                                SizedBox(
                                  width: 20,
                                )
                              ],
                            ),


                          )

                        // InkWell(
                        //     onTap: (){
                        //       //Get.to(RouteHelper.getAccessLocationRoute(''));
                        //       Get.to(AccessLocationScreen(fromSignUp: false, fromHome: false, route: Get.currentRoute));
                        //     },
                        //     child: Row(crossAxisAlignment: CrossAxisAlignment.start, mainAxisAlignment: MainAxisAlignment.start,
                        //       children: [
                        //         Icon(
                        //           locationController.getUserAddress().addressType == 'home' ? Icons.home_filled
                        //               : locationController.getUserAddress().addressType == 'office' ? Icons.work : Icons.location_on,
                        //           size: 20, color: Theme.of(context).textTheme.bodyText1.color,
                        //         ),
                        //         SizedBox(width: 10),
                        //         Flexible(
                        //           child: Text(
                        //             locationController.getUserAddress().address,
                        //             style: robotoRegular.copyWith(
                        //               color: Colors.white, fontSize: Dimensions.fontSizeSmall,
                        //             ),
                        //             maxLines: 1, overflow: TextOverflow.ellipsis,
                        //           ),
                        //         ),
                        //         Icon(Icons.arrow_drop_down, color: Theme.of(context).textTheme.bodyText1.color),
                        //       ],
                        //     )
                        // ),
                      )
                    ],
                  ),
                ),

              ],
            ),
          ),

          Container(
            padding: EdgeInsets.all(5),
            color: Color(0xFFffffff),
            child:Stack(
              children: [
                Align(
                  alignment: Alignment.topLeft,
                  child: Stack(
                    children: [
                      Align(alignment: Alignment.topLeft,
                          child: Container(
                            //margin: EdgeInsets.only(top: 5),
                            width: 300,
                            child:Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [

                                Image.asset(Images.logo,height: 50,width: 50,fit: BoxFit.fill,),
                                Text('HalloChef',style: TextStyle(fontSize: 20,color: Color(0xffE34A28),fontWeight: FontWeight.bold),),
                                //Image.asset(Images.logo_name,height: 70,width: 220,fit: BoxFit.fill,),
                                SizedBox(
                                  //width: 20,
                                )
                              ],
                            ),


                          )

                        //Image.asset(Images.logo,height: 70,width: 70,fit: BoxFit.fill,),
                      ),
                      Align(
                          alignment: Alignment.topRight,
                          child: Container(
                            margin: EdgeInsets.only(top: 10),
                            width: 300,
                            child:Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Container(
                                  margin: EdgeInsets.only(left: 5,right: 15),
                                  height: 20,
                                  width: 1,
                                  color: Colors.grey,
                                ),
                                Text("BN",style: TextStyle(fontSize: 12),), // here, inside the column

                                Container(
                                  margin: EdgeInsets.only(left: 15,right: 15),
                                  height: 20,
                                  width: 1,
                                  color: Colors.grey,
                                ),

                                InkWell(
                                  child: Row(
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Icon(
                                        Icons.account_circle_sharp,
                                        color: Color(0xffE34A28),
                                        size: 30, // also decreased the size of the icon a bit
                                      ),

                                      InkWell(
                                        onTap: (){
                                          Get.offAllNamed(RouteHelper.getSignInRoute(RouteHelper.splash));
                                          //AppConstants.showDialogLogin(context);
                                          //AppConstants.showDialogSearch(context);
                                        },
                                        child:Text("  LOGIN",style: TextStyle(fontSize: 15,fontWeight: FontWeight.bold),), // here, inside the column

                                      )

                                    ],
                                  ),
                                ),

                                Container(
                                  margin: EdgeInsets.only(left: 15,right: 15),
                                  height: 20,
                                  width: 1,
                                  color: Colors.grey,
                                ),

                                InkWell(
                                  onTap: (){
                                    Get.to(CartScreen(fromNav: true),);
                                  },
                                  child: Icon(Icons.shopping_bag_outlined,color: Color(0xffE34A28),),
                                ),
                                SizedBox(
                                  //width: 20,
                                )
                              ],
                            ),


                          )

                        // InkWell(
                        //     onTap: (){
                        //       //Get.to(RouteHelper.getAccessLocationRoute(''));
                        //       Get.to(AccessLocationScreen(fromSignUp: false, fromHome: false, route: Get.currentRoute));
                        //     },
                        //     child: Row(crossAxisAlignment: CrossAxisAlignment.start, mainAxisAlignment: MainAxisAlignment.start,
                        //       children: [
                        //         Icon(
                        //           locationController.getUserAddress().addressType == 'home' ? Icons.home_filled
                        //               : locationController.getUserAddress().addressType == 'office' ? Icons.work : Icons.location_on,
                        //           size: 20, color: Theme.of(context).textTheme.bodyText1.color,
                        //         ),
                        //         SizedBox(width: 10),
                        //         Flexible(
                        //           child: Text(
                        //             locationController.getUserAddress().address,
                        //             style: robotoRegular.copyWith(
                        //               color: Colors.white, fontSize: Dimensions.fontSizeSmall,
                        //             ),
                        //             maxLines: 1, overflow: TextOverflow.ellipsis,
                        //           ),
                        //         ),
                        //         Icon(Icons.arrow_drop_down, color: Theme.of(context).textTheme.bodyText1.color),
                        //       ],
                        //     )
                        // ),
                      )
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
          Expanded(
            child:SingleChildScrollView(
              child: Container(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [


                    //RunningOrderViewWidgetNewDashboard(),

                    // FlutterGooglePlacesWeb(
                    //   apiKey: kGoogleApiKey,
                    //   proxyURL: 'https://cors-anywhere.herokuapp.com/',
                    //   components: 'country:us',
                    // ),


                    Row(
                      children: [
                        Flexible(
                          child: Container(
                              color: Colors.white,
                              height: context.width/2.4,
                              child:Container(
                                height: context.width/2.4,
                                margin: EdgeInsets.fromLTRB(80, 0, 20, 0),
                                alignment: Alignment.center,
                                //child: Center(
                                child: Card(
                                    elevation: 20,
                                    //width: context.width-200,
                                    child: Container(
                                      //height: context.width/2.5,
                                      child: Container(
                                          padding: EdgeInsets.all(20),
                                          child: Row(
                                            children: [
                                              InkWell(
                                                onTap: (){

                                                 // PlacesAutocomplete.show(
                                                 //      context: context,
                                                 //      apiKey: 'AIzaSyD_7sI26H4jmNN9Wjp8ElwiLITT9U5_rWg',
                                                 //      mode: Mode.overlay, // Mode.fullscreen
                                                 //      language: "fr",
                                                 //      components: [new Component(Component.country, "fr")]);

                                                  AppConstants.showDialogPlaceSearch(context);
                                                  //Get.to(AccessLocationScreen(fromSignUp: false, fromHome: false, route: Get.currentRoute));
                                                },
                                                child: Container(

                                                    child: TextField(
                                                      enabled: false,
                                                      autocorrect: true,
                                                      decoration: InputDecoration(
                                                          contentPadding: EdgeInsets.symmetric(vertical: 25.0,horizontal: 25.0),
                                                          //hintText: 'Type Text Here...',
                                                          labelText: "    Enter your full address",
                                                          hintStyle: TextStyle(color: Colors.grey),
                                                          filled: true,
                                                          fillColor: Colors.white70,
                                                          enabledBorder: OutlineInputBorder(
                                                            borderRadius: BorderRadius.all(Radius.circular(12.0)),
                                                            borderSide: BorderSide(color: Colors.grey, width: 1),
                                                          ),
                                                          focusedBorder: OutlineInputBorder(
                                                            borderRadius: BorderRadius.all(Radius.circular(10.0)),
                                                            borderSide: BorderSide(color: Colors.grey),
                                                          ),

                                                          suffixIcon: IconButton(
                                                            icon: Icon(Icons.ac_unit),
                                                            onPressed: (){

                                                            },

                                                          )
                                                      ),


                                                    ),
                                                    // child: SearchScreenWeb(),

                                                    width:context.width/1.7
                                                ),
                                              ),


                                              InkWell(
                                                onTap: (){

                                                  Navigator.of(context).push(MaterialPageRoute(builder: (context) => DashboardScreenWeb(pageIndex: 0,)));


                                                  // if(Get.find<AuthController>().isLoggedIn()){
                                                  //   Navigator.of(context).push(MaterialPageRoute(builder: (context) => DashboardScreenWeb(pageIndex: 0,)));
                                                  // }else{
                                                  //   Navigator.of(context).push(MaterialPageRoute(builder: (context) => SignInScreen(exitFromApp: false,)));
                                                  // }
                                                },
                                                child: Container(
                                                  margin: EdgeInsets.fromLTRB(15, 0, 10, 0),
                                                  padding: EdgeInsets.fromLTRB(25, 5, 25, 5),
                                                  height: 55,
                                                  //width: 100,
                                                  decoration: BoxDecoration(

                                                    color: Color(0xFFE34A28),
                                                    borderRadius: BorderRadius.all(
                                                      Radius.circular(5),
                                                    ),
                                                    border: Border.all(
                                                      width: 1,
                                                      color: Colors.white,
                                                      style: BorderStyle.solid,
                                                    ),
                                                  ),
                                                  child: Center(
                                                    child: Text(
                                                      "Delivery",style: TextStyle(fontSize: 15,color: Colors.white),
                                                    ),
                                                  ),
                                                ),
                                              )



                                            ],
                                          )


                                      ),
                                    )



                                ),
                                // ),
                              )

                          ),
                          flex: 4,),
                        Flexible(child:Image.asset(
                          Images.foods,height: context.width/2.4,
                          fit: BoxFit.fill,), flex: 1,)
                      ],
                    ),

                    Stack(
                      children: [
                        Container(
                          height: 400,
                          width: context.width,
                          child:Image.asset(
                            Images.chef,height: 400,
                            width: context.width,
                            fit: BoxFit.fill,),
                        ),
                        Align(
                          alignment: Alignment.bottomLeft,
                          child: Card(
                            margin: EdgeInsets.only(top: 150,left: 100),
                            elevation: 15,
                            child:Container(
                              padding: EdgeInsets.all(20),
                              color: Colors.white,
                              height: 300,
                              width: 500,
                              child: Column(
                                children: [
                                  Text('List your restaurant or shop on HalloChef',style: TextStyle(fontSize: 20),),
                                  SizedBox(height: 10,),
                                  Text('Would you like millions of new customers to enjoy your amazing food and groceries? So would we!\n \n '
                                      'Its simple: we list your menu and product lists online, help you process orders, pick them up, and deliver them to hungry pandas – in a heartbeat!\n \n Interested? Lets start our partnership today!',style: TextStyle(fontSize: 15),),


                                  Align(
                                    alignment: Alignment.bottomRight,
                                    child: Container(
                                      alignment: Alignment.bottomRight,
                                      margin: EdgeInsets.fromLTRB(15, 30, 10, 0),
                                      padding: EdgeInsets.fromLTRB(25, 5, 25, 5),
                                      height: 50,
                                      width: 200,
                                      decoration: BoxDecoration(

                                        color: Color(0xFFE34A28),
                                        borderRadius: BorderRadius.all(
                                          Radius.circular(5),
                                        ),
                                        border: Border.all(
                                          width: 1,
                                          color: Colors.white,
                                          style: BorderStyle.solid,
                                        ),
                                      ),
                                      child: Center(
                                        child: Text(
                                          "Get started",style: TextStyle(fontSize: 15,color: Colors.white),
                                        ),
                                      ),
                                    ),
                                  ),

                                ],
                              ),
                            ),

                          ),

                        )
                      ],
                    ),

                    SizedBox(
                      height: 40,
                    ),
                    Column(
                      children: [
                        Image.asset(
                          Images.citis,height: 350,
                          width: context.width,
                          fit: BoxFit.fill,),
                      ],
                    ),
                    Column(
                      children: [
                        Image.asset(
                          'assets/image/citis2.png',height: 350,
                          width: context.width,
                          fit: BoxFit.fill,),
                      ],
                    ),
                    SizedBox(
                      height: 30,
                    ),

                    Image.asset(
                      'assets/image/applinkview.png',height: 470,
                      width: context.width,
                      fit: BoxFit.fill,),

                    SizedBox(
                      height: 30,
                    ),
                    Stack(
                      children: [
                        Container(
                          height: 400,
                          width: context.width,
                          child:Image.asset(
                            'assets/image/bussiness.png',height: 400,
                            width: context.width,
                            fit: BoxFit.fill,),
                        ),
                        Align(
                          alignment: Alignment.bottomLeft,
                          child: Card(
                            margin: EdgeInsets.only(top: 150,left: 100),
                            elevation: 15,
                            child:Container(
                              padding: EdgeInsets.all(20),
                              color: Colors.white,
                              height: 300,
                              width: 500,
                              child: Column(
                                children: [
                                  Text('HalloChef for business',style: TextStyle(fontSize: 20),),
                                  SizedBox(height: 10,),
                                  Text('Order lunch or fuel for work-from-home, late nights in the office, corporate events, client meetings, and much more.',style: TextStyle(fontSize: 15),),

                                  Align(
                                    alignment: Alignment.bottomRight,
                                    child: Container(
                                      alignment: Alignment.bottomRight,
                                      margin: EdgeInsets.fromLTRB(15, 30, 10, 0),
                                      padding: EdgeInsets.fromLTRB(25, 5, 25, 5),
                                      height: 50,
                                      width: 200,
                                      decoration: BoxDecoration(

                                        color: Color(0xFFE34A28),
                                        borderRadius: BorderRadius.all(
                                          Radius.circular(5),
                                        ),
                                        border: Border.all(
                                          width: 1,
                                          color: Colors.white,
                                          style: BorderStyle.solid,
                                        ),
                                      ),
                                      child: Center(
                                        child: Text(
                                          "Get started",style: TextStyle(fontSize: 15,color: Colors.white),
                                        ),
                                      ),
                                    ),
                                  ),

                                ],
                              ),
                            ),

                          ),

                        )
                      ],
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Image.asset(
                      'assets/image/fotter.png',height: 370,
                      width: context.width,
                      fit: BoxFit.fill,),
                  ],
                ),
              ),

            ),
          )

        ],
      ),


    );



  }




  Widget buildTabWidget(int currentItemNumber,
      { int currentIndex,  String imageUrl}) =>
      SizedBox(
        //width: ((MediaQuery.of(context).size.width) - 48) / 3,
        height: 70,
        child: Stack(alignment: Alignment.bottomLeft, children: [
          // Image.network(
          //   imageUrl,
          //   fit: BoxFit.cover,
          //   width: double.infinity,
          // ),

          Image.asset( imageUrl,height:70,fit: BoxFit.fill,),

          // ClipRRect(
          //   child: BackdropFilter(
          //     filter: ImageFilter.blur(
          //         sigmaY: currentIndex == currentItemNumber ? 0 : 1,
          //         sigmaX: currentIndex == currentItemNumber ? 0 : 1),
          //     child: Container(
          //       width: ((MediaQuery.of(context).size.width) - 48) / 3,
          //       height: 70,
          //       color: Colors.black.withOpacity(0.3),
          //     ),
          //   ),
          // ),

          // Padding(
          //     padding: const EdgeInsets.all(8.0),
          //     child: Text(tabtitles[currentItemNumber]['title'],style: TextStyle(color: currentIndex == currentItemNumber ? Colors.deepOrange:Colors.black54 ),)
          // )

        ]),
      );

// void _setPage(int pageIndex) {
//   setState(() {
//     _pageController.jumpToPage(pageIndex);
//     _pageIndex = pageIndex;
//   });
// }


}
