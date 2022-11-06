import 'package:efood_multivendor/controller/auth_controller.dart';
import 'package:efood_multivendor/controller/cart_controller.dart';
import 'package:efood_multivendor/controller/location_controller.dart';
import 'package:efood_multivendor/controller/splash_controller.dart';
import 'package:efood_multivendor/helper/responsive_helper.dart';
import 'package:efood_multivendor/helper/route_helper.dart';
import 'package:efood_multivendor/util/dimensions.dart';
import 'package:efood_multivendor/util/images.dart';
import 'package:efood_multivendor/util/styles.dart';
import 'package:efood_multivendor/view/screens/menu/menu_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../util/app_constants.dart';
import '../screens/cart/cart_screen.dart';

class WebMenuBar extends StatelessWidget implements PreferredSizeWidget {
  @override
  Widget build(BuildContext context) {
    bool _showJoin = (Get.find<SplashController>().configModel.toggleDmRegistration
        || Get.find<SplashController>().configModel.toggleRestaurantRegistration) && ResponsiveHelper.isDesktop(context);
    List<PopupMenuEntry> _entryList = [];
    if(Get.find<SplashController>().configModel.toggleDmRegistration) {
      _entryList.add(PopupMenuItem<int>(child: Text('join_as_a_delivery_man'.tr), value: 0));
    }
    if(Get.find<SplashController>().configModel.toggleRestaurantRegistration) {
      _entryList.add(PopupMenuItem<int>(child: Text('join_as_a_restaurant'.tr), value: 1));
    }

    return GetBuilder<LocationController>(builder: (locationController) {
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
                                  height: 45,
                                  width: 45,
                                  decoration: BoxDecoration(
                                    ///color: Colors.deepOrangeAccent.withOpacity(0.5),
                                      color: Color(0xFFE34A28).withOpacity(0.1),
                                      shape: BoxShape.circle
                                  ),
                                  child:Image.asset(Images.logo,
                                    height: 40,width: 40,
                                    fit: BoxFit.cover,),

                                ),
                                SizedBox(width: 20,),
                                Text('HalloChef',style: TextStyle(fontSize: 20,color: Color(0xFFE34A28),fontWeight: FontWeight.bold),),
                                SizedBox(width: 20,),
                                Container(
                                  margin: EdgeInsets.only(left: 15,right: 15),
                                  height: 50,
                                  width: 1,
                                  color: Color(0xffEBEBEB),
                                ),
                                SizedBox(width: 20,),
                                Text('DELIVERING TO : ',style: TextStyle(fontSize: 10,color: Color(0xFFA2A2A2)),),

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
                                Icon(Icons.arrow_drop_down, color: Color(0xFFE34A28)),

                                Container(
                                  margin: EdgeInsets.only(left: 25,right: 15),
                                  height: 50,
                                  width: 1,
                                  color: Color(0xffEBEBEB),
                                ),

                                InkWell(
                                    onTap: (){
                                      AppConstants.showDialogWhenAsap(context);
                                    },
                                    child: Container(
                                      width: 100,
                                      child: Row(
                                        children: [
                                          Text('WHEN : ',style: TextStyle(fontSize: 10,color: Color(0xFFA2A2A2),),),

                                          Text('ASAP  ',style: TextStyle(fontSize: 12,color:Colors.black,fontWeight: FontWeight.bold),),
                                          Icon(Icons.keyboard_arrow_down_sharp, color: Color(0xFFE34A28))
                                        ],
                                      ),
                                    )

                                )


                              ],
                            ),


                          )

                        //Image.asset(Images.logo,height: 70,width: 70,fit: BoxFit.fill,),
                      ),


                      Align(
                          alignment: Alignment.topRight,
                          child: Container(
                            //margin: EdgeInsets.only(top: 10),
                            width: 300,
                            child:Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Container(
                                  margin: EdgeInsets.only(left: 5,right: 15),
                                  height: 50,
                                  width: 1,
                                  color: Color(0xffEBEBEB),
                                ),
                                Text("EN",style: TextStyle(fontSize: 10,color: Color(0xFFA2A2A2),),), // here, inside the column

                                Container(
                                  margin: EdgeInsets.only(left: 15,right: 15),
                                  height: 50,
                                  width: 1,
                                  color: Color(0xffEBEBEB),
                                ),

                                InkWell(
                                  child: Row(
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Icon(
                                        Icons.account_circle_sharp,
                                        color: Color(0xFFE34A28),
                                        size: 30, // also decreased the size of the icon a bit
                                      ),

                                      InkWell(
                                        onTap: (){
                                          AppConstants.showDialogLogin(context);
                                        },
                                        child: Text("  LOGIN",style: TextStyle(fontSize: 15,fontWeight: FontWeight.bold,color: Colors.black,),), // here, inside the column
                                      )

                                    ],
                                  ),
                                ),

                                Container(
                                  margin: EdgeInsets.only(left: 15,right: 15),
                                  height: 50,
                                  width: 1,
                                  color: Color(0xffEBEBEB),
                                ),

                                InkWell(
                                  onTap: (){
                                    Get.to(CartScreen(fromNav: true),);
                                  },
                                  child: Icon(Icons.shopping_bag_outlined, color: Color(0xFFE34A28),),
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
    );
    //   Center(child: Container(
    //   width: Dimensions.WEB_MAX_WIDTH,
    //   color: Theme.of(context).cardColor,
    //   padding: EdgeInsets.all(Dimensions.PADDING_SIZE_SMALL),
    //   child: Row(children: [
    //
    //     InkWell(
    //       onTap: () => Get.toNamed(RouteHelper.getInitialRoute()),
    //       child: Image.asset(Images.logo, height: 50, width: 50),
    //     ),
    //
    //     Get.find<LocationController>().getUserAddress() != null ? Expanded(child: InkWell(
    //       onTap: () => Get.toNamed(RouteHelper.getAccessLocationRoute('home')),
    //       child: Padding(
    //         padding: EdgeInsets.all(Dimensions.PADDING_SIZE_SMALL),
    //         child: GetBuilder<LocationController>(builder: (locationController) {
    //           return Row(crossAxisAlignment: CrossAxisAlignment.center, mainAxisAlignment: MainAxisAlignment.start,
    //             children: [
    //               Icon(
    //                 locationController.getUserAddress().addressType == 'home' ? Icons.home_filled
    //                     : locationController.getUserAddress().addressType == 'office' ? Icons.work : Icons.location_on,
    //                 size: 20, color: Theme.of(context).textTheme.bodyText1.color,
    //               ),
    //               SizedBox(width: Dimensions.PADDING_SIZE_EXTRA_SMALL),
    //               Flexible(
    //                 child: Text(
    //                   locationController.getUserAddress().address,
    //                   style: robotoRegular.copyWith(
    //                     color: Theme.of(context).textTheme.bodyText1.color, fontSize: Dimensions.fontSizeSmall,
    //                   ),
    //                   maxLines: 1, overflow: TextOverflow.ellipsis,
    //                 ),
    //               ),
    //               Icon(Icons.arrow_drop_down, color: Theme.of(context).primaryColor),
    //             ],
    //           );
    //         }),
    //       ),
    //     )) : Expanded(child: SizedBox()),
    //
    //     MenuButton(icon: Icons.home, title: 'home'.tr, onTap: () => Get.toNamed(RouteHelper.getInitialRoute())),
    //     SizedBox(width: 20),
    //     MenuButton(icon: Icons.search, title: 'search'.tr, onTap: () => Get.toNamed(RouteHelper.getSearchRoute())),
    //     SizedBox(width: 20),
    //     MenuButton(icon: Icons.notifications, title: 'notification'.tr, onTap: () => Get.toNamed(RouteHelper.getNotificationRoute())),
    //     SizedBox(width: 20),
    //     MenuButton(icon: Icons.favorite_outlined, title: 'favourite'.tr, onTap: () => Get.toNamed(RouteHelper.getMainRoute('favourite'))),
    //     SizedBox(width: 20),
    //     MenuButton(icon: Icons.shopping_cart, title: 'my_cart'.tr, isCart: true, onTap: () => Get.toNamed(RouteHelper.getCartRoute())),
    //     SizedBox(width: 20),
    //     MenuButton(icon: Icons.menu, title: 'menu'.tr, onTap: () {
    //       Get.bottomSheet(MenuScreen(), backgroundColor: Colors.transparent, isScrollControlled: true);
    //     }),
    //     SizedBox(width: 20),
    //     GetBuilder<AuthController>(builder: (authController) {
    //       return MenuButton(
    //         icon: authController.isLoggedIn() ? Icons.shopping_bag : Icons.lock,
    //         title: authController.isLoggedIn() ? 'my_orders'.tr : 'sign_in'.tr,
    //         onTap: () => Get.toNamed(authController.isLoggedIn() ? RouteHelper.getMainRoute('order') : RouteHelper.getSignInRoute(RouteHelper.main)),
    //       );
    //     }),
    //     SizedBox(width: _showJoin ? 20 : 0),
    //
    //     _showJoin ? PopupMenuButton<int>(
    //       itemBuilder: (BuildContext context) => _entryList,
    //       onSelected: (int value) {
    //         if(value == 0) {
    //           Get.toNamed(RouteHelper.getDeliverymanRegistrationRoute());
    //         }else {
    //           Get.toNamed(RouteHelper.getRestaurantRegistrationRoute());
    //         }
    //       },
    //       child: Container(
    //         padding: EdgeInsets.symmetric(horizontal: Dimensions.PADDING_SIZE_SMALL, vertical: Dimensions.PADDING_SIZE_EXTRA_SMALL),
    //         decoration: BoxDecoration(
    //           color: Theme.of(context).primaryColor, borderRadius: BorderRadius.circular(Dimensions.RADIUS_SMALL),
    //         ),
    //         child: Row(children: [
    //           Text('join_us'.tr, style: robotoMedium.copyWith(color: Colors.white)),
    //           Icon(Icons.arrow_drop_down, size: 20, color: Colors.white),
    //         ]),
    //       ),
    //     ) : SizedBox(),
    //
    //   ]),
    // ));
  }
  @override
  Size get preferredSize => Size(Dimensions.WEB_MAX_WIDTH, 70);
}

class MenuButton extends StatelessWidget {
  final IconData icon;
  final String title;
  final bool isCart;
  final Function onTap;
  MenuButton({@required this.icon, @required this.title, this.isCart = false, @required this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Row(children: [
        Stack(clipBehavior: Clip.none, children: [

          Icon(icon, size: 20),

          isCart ? GetBuilder<CartController>(builder: (cartController) {
            return cartController.cartList.length > 0 ? Positioned(
              top: -5, right: -5,
              child: Container(
                height: 15, width: 15, alignment: Alignment.center,
                decoration: BoxDecoration(shape: BoxShape.circle, color: Theme.of(context).primaryColor),
                child: Text(
                  cartController.cartList.length.toString(),
                  style: robotoRegular.copyWith(fontSize: 12, color: Theme.of(context).cardColor),
                ),
              ),
            ) : SizedBox();
          }) : SizedBox(),
        ]),
        SizedBox(width: Dimensions.PADDING_SIZE_EXTRA_SMALL),

        Text(title, style: robotoRegular.copyWith(fontSize: Dimensions.fontSizeSmall)),
      ]),
    );
  }
}

