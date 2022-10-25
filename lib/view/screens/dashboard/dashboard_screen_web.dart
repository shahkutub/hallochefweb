import 'dart:async';
import 'dart:ui';

import 'package:efood_multivendor/controller/order_controller.dart';
import 'package:efood_multivendor/helper/responsive_helper.dart';
import 'package:efood_multivendor/util/app_constants.dart';
import 'package:efood_multivendor/util/dimensions.dart';
import 'package:efood_multivendor/view/base/cart_widget.dart';
import 'package:efood_multivendor/view/screens/cart/cart_screen.dart';
import 'package:efood_multivendor/view/screens/coupon/coupon_screen.dart';
import 'package:efood_multivendor/view/screens/dashboard/widget/bottom_nav_item.dart';
import 'package:efood_multivendor/view/screens/dashboard/widget/running_order_view_widget.dart';
import 'package:efood_multivendor/view/screens/favourite/favourite_screen.dart';
import 'package:efood_multivendor/view/screens/home/home_screen.dart';
import 'package:efood_multivendor/view/screens/menu/menu_screen.dart';
import 'package:efood_multivendor/view/screens/order/order_screen.dart';
import 'package:efood_multivendor/view/screens/restaurant/all_restaurant_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../controller/auth_controller.dart';
import '../../../controller/category_controller.dart';
import '../../../controller/location_controller.dart';
import '../../../controller/splash_controller.dart';
import '../../../helper/route_helper.dart';
import '../../../util/images.dart';
import '../../../util/styles.dart';
import '../../base/title_widget.dart';
import '../address/address_screen.dart';
import '../home/delivery_home_screen.dart';
import '../home/pick_up_home_screen.dart';
import '../home/widget/category_view_before_dashboard.dart';
import '../home/widget/causines_view_dashboard.dart';
import '../language/language_screen.dart';
import '../location/access_location_screen.dart';
import '../support/support_screen.dart';

class DashboardScreenWeb extends StatefulWidget {
  final int pageIndex;
  DashboardScreenWeb({@required this.pageIndex});

  @override
  _DashboardScreenState createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreenWeb> {
  PageController _pageController;
  int _pageIndex = 0;
  List<Widget> _screens;
  GlobalKey<ScaffoldMessengerState> _scaffoldKey = GlobalKey();
  bool _canExit = GetPlatform.isWeb ? true : false;
  int currentIndex = 0;
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

  @override
  void initState() {
    super.initState();

    _pageIndex = widget.pageIndex;

    _pageController = PageController(initialPage: widget.pageIndex);

    _screens = [
      HomeScreen(),
      FavouriteScreen(),
      CartScreen(fromNav: true),
      OrderScreen(),
      Container(),
    ];
    //
    // Future.delayed(Duration(seconds: 1), () {
    //   setState(() {});
    // });

    /*if(GetPlatform.isMobile) {
      NetworkInfo.checkConnectivity(_scaffoldKey.currentContext);
    }*/


    Get.find<CategoryController>().getCategoryList(true);
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        if (_pageIndex != 0) {
          _setPage(0);
          return false;
        } else {
          if(_canExit) {
            return true;
          }else {
            // ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            //   content: Text('back_press_again_to_exit'.tr, style: TextStyle(color: Colors.white)),
            //   behavior: SnackBarBehavior.floating,
            //   backgroundColor: Colors.green,
            //   duration: Duration(seconds: 2),
            //   margin: EdgeInsets.all(Dimensions.PADDING_SIZE_SMALL),
            // ));
            _canExit = true;
            // Timer(Duration(seconds: 2), () {
            //   _canExit = false;
            // });
            return true;
          }
        }
      },
      child: Scaffold(
        key: _scaffoldKey,

        // floatingActionButton: GetBuilder<OrderController>(builder: (orderController) {
        //     return ResponsiveHelper.isDesktop(context) ? SizedBox() : (orderController.isRunningOrderViewShow && (orderController.runningOrderList != null && orderController.runningOrderList.length > 0))
        //     ? SizedBox.shrink() : FloatingActionButton(
        //       elevation: 5,
        //       backgroundColor: _pageIndex == 2 ? Theme.of(context).primaryColor : Theme.of(context).cardColor,
        //       onPressed: () => _setPage(2),
        //       child: CartWidget(color: _pageIndex == 2 ? Theme.of(context).cardColor : Theme.of(context).disabledColor, size: 30),
        //     );
        //   }
        // ),
        // floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        //
        // bottomNavigationBar: ResponsiveHelper.isDesktop(context) ? SizedBox() : GetBuilder<OrderController>(builder: (orderController) {
        //
        //     return (orderController.isRunningOrderViewShow && (orderController.runningOrderList != null && orderController.runningOrderList.length > 0))
        //     ? RunningOrderViewWidget() : BottomAppBar(
        //       elevation: 5,
        //       notchMargin: 5,
        //       clipBehavior: Clip.antiAlias,
        //       shape: CircularNotchedRectangle(),
        //
        //       child: Padding(
        //         padding: EdgeInsets.all(Dimensions.PADDING_SIZE_EXTRA_SMALL),
        //         child: Row(children: [
        //           BottomNavItem(iconData: Icons.home, isSelected: _pageIndex == 0, onTap: () => _setPage(0)),
        //           BottomNavItem(iconData: Icons.favorite, isSelected: _pageIndex == 1, onTap: () => _setPage(1)),
        //           Expanded(child: SizedBox()),
        //           BottomNavItem(iconData: Icons.shopping_bag, isSelected: _pageIndex == 3, onTap: () => _setPage(3)),
        //           BottomNavItem(iconData: Icons.menu, isSelected: _pageIndex == 4, onTap: () {
        //             Get.bottomSheet(MenuScreen(), backgroundColor: Colors.transparent, isScrollControlled: true);
        //           }),
        //         ]),
        //       ),
        //     );
        //   }
        // ),
        backgroundColor: Color(0xffEEF2F5),
        appBar: AppBar(
          //backgroundColor: Color(0xffEEF2F5),
          toolbarHeight: 140,
          //title: const  Text('') ,
          title: GetBuilder<LocationController>(builder: (locationController) {
            return Column(
              children: [
                Stack(
                  children: [
                    Align(
                      alignment: Alignment.topLeft,
                      child: Stack(
                        children: [
                          Align(alignment: Alignment.topLeft,
                            child: Container(
                              width: 300,
                              child:Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [

                                  Image.asset(Images.logo,height: 70,width: 70,fit: BoxFit.fill,),
                                  Text('HalloChef',style: TextStyle(fontSize: 30),),
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
                              width: 300,
                              child:Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [

                                  Container(
                                    margin: EdgeInsets.only(left: 5,right: 5),
                                    height: 45,
                                    width: 1,
                                    color: Colors.white,
                                  ),

                                  InkWell(
                                    child: Row(
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        Icon(
                                            Icons.account_circle_sharp,
                                            color: Colors.white,
                                            size: 50, // also decreased the size of the icon a bit
                                          ),

                                        Text("Login",style: TextStyle(fontSize: 12),), // here, inside the column
                                      ],
                                    ),
                                  ),

                                  Container(
                                    margin: EdgeInsets.only(left: 5,right: 15),
                                    height: 45,
                                    width: 1,
                                    color: Colors.white,
                                  ),

                                  InkWell(
                                    onTap: (){
                                      Get.to(CartScreen(fromNav: true),);
                                    },
                                    child: Icon(Icons.shopping_bag_outlined),
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

                Stack(
                  children: [
                    Align(
                      alignment: Alignment.topLeft,
                      child: Stack(
                        children: [
                          Align(alignment: Alignment.topLeft,
                            child: Container(
                              //width: 500,
                              child: InkWell(
                                  onTap: (){
                                    //Get.to(RouteHelper.getAccessLocationRoute(''));
                                    Get.to(AccessLocationScreen(fromSignUp: false, fromHome: false, route: Get.currentRoute));
                                  },
                                  child: Row(crossAxisAlignment: CrossAxisAlignment.center, mainAxisAlignment: MainAxisAlignment.start,
                                    children: [

                                      Text('Delivering to : ',style: TextStyle(fontSize: 12),),

                                      // Container(
                                      //   height: 60,
                                      //     width: 60,
                                      //     decoration: BoxDecoration(
                                      //         border: Border.all(
                                      //           color: Colors.red[500].withOpacity(2.0),
                                      //         ),
                                      //         borderRadius: BorderRadius.all(Radius.circular(20))
                                      //     ),
                                      //
                                      // ),
                                      Icon(
                                        locationController.getUserAddress().addressType == 'home' ? Icons.home_filled
                                            : locationController.getUserAddress().addressType == 'office' ? Icons.work : Icons.location_on,
                                        size: 20, color: Colors.white,
                                      ),

                                      SizedBox(width: 10),
                                      Flexible(
                                        child: Text(
                                          locationController.getUserAddress().address,
                                          style: robotoRegular.copyWith(
                                            color: Colors.white, fontSize: Dimensions.fontSizeSmall,
                                          ),
                                          maxLines: 1, overflow: TextOverflow.ellipsis,
                                        ),
                                      ),
                                      Icon(Icons.arrow_drop_down, color: Theme.of(context).textTheme.bodyText1.color),

                                      Container(
                                        margin: EdgeInsets.only(left: 15,right: 15),
                                        height: 45,
                                        width: 1,
                                        color: Colors.white,
                                      ),

                                      Text('WHEN : ',style: TextStyle(fontSize: 12),),

                                      Text('ASAP  ',style: TextStyle(fontSize: 12),),
                                      Icon(Icons.keyboard_arrow_down_sharp, color: Colors.white)

                                    ],
                                  )
                              ),
                            )
                          ),
                          // Align(
                          //   alignment: Alignment.topRight,
                          //   child: Image.asset(Images.logo,height: 50,width: 50,),
                          //
                          //
                          // )
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
                )
              ],
            );

          }
          ),
          // actions: [
          //   InkWell(
          //     onTap: (){
          //       Get.to(CartScreen(fromNav: true),);
          //     },
          //     child: Icon(Icons.shopping_bag_outlined),
          //   ),
          //
          //   SizedBox(width: 10,)
          // ],
         // bottom: PreferredSize(
         //    preferredSize:const Size.fromHeight(40),
         //    child: GetBuilder<LocationController>(builder: (locationController) {
         //      return Container(
         //        margin: EdgeInsets.fromLTRB(70, 0, 70, 0),
         //        child: Row(
         //          children: [
         //            InkWell(
         //                onTap: (){
         //                  //Get.to(RouteHelper.getAccessLocationRoute(''));
         //                  Get.to(AccessLocationScreen(fromSignUp: false, fromHome: false, route: Get.currentRoute));
         //                },
         //                child: Row(crossAxisAlignment: CrossAxisAlignment.center, mainAxisAlignment: MainAxisAlignment.start,
         //                  children: [
         //                    Icon(
         //                      locationController.getUserAddress().addressType == 'home' ? Icons.home_filled
         //                          : locationController.getUserAddress().addressType == 'office' ? Icons.work : Icons.location_on,
         //                      size: 20, color: Theme.of(context).textTheme.bodyText1.color,
         //                    ),
         //                    SizedBox(width: 10),
         //                    Flexible(
         //                      child: Text(
         //                        locationController.getUserAddress().address,
         //                        style: robotoRegular.copyWith(
         //                          color: Colors.white, fontSize: Dimensions.fontSizeSmall,
         //                        ),
         //                        maxLines: 1, overflow: TextOverflow.ellipsis,
         //                      ),
         //                    ),
         //                    Icon(Icons.arrow_drop_down, color: Theme.of(context).textTheme.bodyText1.color),
         //                  ],
         //                )
         //            )
         //          ],
         //        )
         //      );
         //
         //    }
         //    ),
         //
         // ),
        ),
        body:  DefaultTabController(
          length: 3,
          child: Column(
            children: <Widget>[
              Container(
                color: Color(0xFFFFFFFF),
                child:
                TabBar(
                  indicatorColor: Color(0xFFFF7600),
                  onTap: (value) => setState(() {
                    currentIndex = value;
                  }),
                  //indicatorSize: TabBarIndicatorSize.label,
                  padding: const EdgeInsets.all(0),
                  labelPadding: const EdgeInsets.all(0),
                  tabs: [
                    for (int tabItem = 0; tabItem < 4; tabItem++)
                      buildTabWidget(tabItem,
                          currentIndex: currentIndex,
                          imageUrl: tabtitles[tabItem]['img'])
                  ],

                ),


                // TabBar(
                //     indicatorColor: Color(0xFFFF7600),
                //     tabs: [
                //   Tab(
                //     //text: "Home",
                //     child: Container(
                //       width: 100,
                //       height: 50,
                //
                //         decoration: BoxDecoration(
                //             image: DecorationImage(
                //               image: AssetImage(Images.deliverytab),
                //               fit: BoxFit.fill,
                //               // colorFilter: ColorFilter.mode(
                //               //     Colors.black.withOpacity(0.4), BlendMode.dstATop),
                //     )
                //
                //   ),
                //     ),),
                //   Tab(
                //     //text: "Home",
                //     child: Container(
                //       decoration: BoxDecoration(
                //           image: DecorationImage(
                //             image: AssetImage(Images.pick_up_tab),
                //             fit: BoxFit.fill,
                //             // colorFilter: ColorFilter.mode(
                //             //     Colors.black.withOpacity(0.4), BlendMode.dstATop),
                //           )
                //
                //       ),
                //     ),),
                //       Tab(
                //         //text: "Home",
                //         child: Container(
                //           decoration: BoxDecoration(
                //               image: DecorationImage(
                //                 image: AssetImage(Images.pick_up_tab),
                //                 fit: BoxFit.fill,
                //                 // colorFilter: ColorFilter.mode(
                //                 //     Colors.black.withOpacity(0.4), BlendMode.dstATop),
                //               )
                //
                //           ),
                //         ),),
                // ]),
              ),

              InkWell(
                onTap: () => Get.toNamed(RouteHelper.getSearchRoute()),
                child: Container(
                  width: context.width,
                  height: 60,
                  margin: EdgeInsets.fromLTRB(50, 10, 50, 10),

                  padding: const EdgeInsets.symmetric(horizontal: 15 , vertical: 10),
                    child: CupertinoTextField(
                      enabled: false,
                      padding: EdgeInsets.symmetric(vertical: 12 , horizontal: 10),
                      placeholder: "Seach for shop & restaurants",
                      prefix: Padding(
                        padding: const EdgeInsets.only(left: 10),
                        child: Icon(Icons.search , color: Color(0xff7b7b7b) ,),
                      ),
                      decoration: BoxDecoration(
                          color: Color(0xfff7f7f7),
                          borderRadius : BorderRadius.circular(50)
                      ),
                      style: TextStyle(color: Color(0xff707070) ,
                        fontSize: 12, ) ,
                    )


                ),
              ),

              Expanded(
                child: Container(
                  child: TabBarView(children: [
                    DeliveryHomeScreen(),
                    AllRestaurantScreen(isPopular: true),
                    PickUpHomeScreen()
                  ]),
                ),
              )
            ],
          ),
        ),

        // SingleChildScrollView(
        //   child: Padding(
        //     padding: const EdgeInsets.symmetric(horizontal: 15 ,vertical: 15),
        //     child: Column(
        //       crossAxisAlignment: CrossAxisAlignment.start,
        //       children: [
        //         Padding(
        //           padding: const EdgeInsets.symmetric(vertical: 10),
        //           child: Row(
        //             children: [
        //               Expanded(
        //                 flex: 1,
        //                 child: Material(
        //                   child: InkWell(
        //                     splashColor: Colors.black45,
        //                     onTap: (){
        //                       AppConstants.pagename = 'delivery';
        //                       Get.to(DeliveryHomeScreen());
        //                       //Navigator.push(context, MaterialPageRoute(builder: (context) => DeliveryHomeScreen()));
        //                     },
        //                     child: Container(
        //                       height: MediaQuery.of(context).size.height * .35,
        //                       decoration: BoxDecoration(
        //                           color: Colors.white,
        //                           borderRadius: BorderRadius.circular(10)
        //                       ),
        //                       child: Padding(
        //                         padding:  EdgeInsets.all(10.0),
        //                         child: Stack(
        //                           children: [
        //                             Align(
        //                               alignment: Alignment.topLeft,
        //                               child: Column(
        //                                 mainAxisAlignment: MainAxisAlignment.start,
        //                                 crossAxisAlignment: CrossAxisAlignment.start,
        //                                 children: [
        //                                   Text('Food Delivery' , style: TextStyle(color: Colors.black , fontWeight: FontWeight.bold, fontSize: 18 ),),
        //                                   Text('Order food you love' , style: TextStyle(color: Colors.black , fontWeight: FontWeight.w500 ,height:1 ,  fontSize: 14  )),
        //                                 ],
        //                               ),
        //                             ),
        //                             Align(
        //                               alignment: Alignment.bottomRight,
        //                               child: CircleAvatar(
        //                                 backgroundColor: Colors.white,
        //                                 radius: 60,
        //                                 backgroundImage: AssetImage('assets/image/foodboul.png'),
        //                               ),
        //                             ),
        //
        //                           ],
        //                         ),
        //
        //                         // child: Stack(
        //                         //   alignment: Alignment.center,
        //                         //   children: const [
        //                         //     CircleAvatar(
        //                         //       radius: 50,
        //                         //       backgroundImage: AssetImage('assets/pandamart.jpg'),
        //                         //     ),
        //                         //     Positioned(
        //                         //         bottom: 15,
        //                         //         left: 0,
        //                         //         child: Text('Food Delivery' , style: TextStyle(color: Colors.black , fontWeight: FontWeight.bold, fontSize: 18 ),)),
        //                         //     Positioned(
        //                         //         bottom: 0,
        //                         //         left: 0,
        //                         //         child: Text('Order food you love' , style: TextStyle(color: Colors.black , fontWeight: FontWeight.w500 ,height:1 ,  fontSize: 14  ))),
        //                         //
        //                         //   ],
        //                         // ),
        //                       ),
        //                     ),
        //                   )
        //                 )
        //
        //
        //               ),
        //               SizedBox(width: 8,),
        //               Expanded(
        //                 flex: 1,
        //                 child: Column(
        //                   children: [
        //                     InkWell(
        //                       onTap: (){
        //                         AppConstants.pagename = 'table';
        //                         Navigator.push(context, MaterialPageRoute(builder: (context) => DashboardScreen(pageIndex: 0)));
        //                       },
        //                       child: Container(
        //                         padding:  EdgeInsets.all(10.0),
        //                         height: MediaQuery.of(context).size.height * .20,
        //                         width: double.infinity,
        //                         decoration: BoxDecoration(
        //                           color: Colors.white,
        //                           borderRadius: BorderRadius.circular(10),
        //
        //                         ),
        //                         child: Stack(
        //
        //                           children: [
        //
        //                             Align(
        //                               alignment: Alignment.topLeft,
        //                               child: Column(
        //                                 mainAxisAlignment: MainAxisAlignment.start,
        //                                 crossAxisAlignment: CrossAxisAlignment.start,
        //                                 children: [
        //                                   Text('Book table' , style: TextStyle(color: Colors.black , fontWeight: FontWeight.bold, fontSize: 18 ),),
        //                                   //Text('Order food you love' , style: TextStyle(color: Colors.black , fontWeight: FontWeight.w500 ,height:1 ,  fontSize: 14  )),
        //
        //                                 ],
        //                               ),
        //                             ),
        //
        //
        //                             Align(
        //                                 alignment: Alignment.bottomRight,
        //                                 // child: CircleAvatar(
        //                                 //   backgroundColor: Colors.white,
        //                                 //   radius: 50,
        //                                 //   backgroundImage: AssetImage('assets/image/booktable.png'),
        //                                 // ),
        //
        //                                 child: Image.asset(
        //                                   'assets/image/booktable.png',
        //                                   width: 80,
        //                                   height: 80,
        //                                   fit: BoxFit.fill,
        //                                 )
        //
        //                             ),
        //
        //
        //
        //                           ],
        //                         ),
        //                       ),
        //                     ),
        //
        //                     SizedBox(height: 5),
        //
        //                     InkWell(
        //                         onTap: (){
        //                           AppConstants.pagename = 'dine';
        //                           Navigator.push(context, MaterialPageRoute(builder: (context) => AllRestaurantScreen(isPopular: true)));
        //                         },
        //                         child: Container(
        //                           height: MediaQuery.of(context).size.height * .15,
        //                           width: double.infinity,
        //                           decoration: BoxDecoration(
        //                               color: Colors.white,
        //                               borderRadius: BorderRadius.circular(10)
        //                           ),
        //                           child: Padding(
        //                             padding: const EdgeInsets.all(10.0),
        //                             child: Stack(
        //
        //                               children: [
        //
        //                                 Align(
        //                                   alignment: Alignment.topLeft,
        //                                   child: Column(
        //                                     mainAxisAlignment: MainAxisAlignment.start,
        //                                     crossAxisAlignment: CrossAxisAlignment.start,
        //                                     children: [
        //                                       Text('Dine-in' , style: TextStyle(color: Colors.black , fontWeight: FontWeight.bold, fontSize: 18 ),),
        //                                       //Text('Order food you love' , style: TextStyle(color: Colors.black , fontWeight: FontWeight.w500 ,height:1 ,  fontSize: 14  )),
        //
        //                                     ],
        //                                   ),
        //                                 ),
        //
        //
        //                                 Align(
        //                                   alignment: Alignment.bottomRight,
        //                                   child: CircleAvatar(
        //                                     backgroundColor: Colors.white,
        //                                     radius: 35,
        //                                     backgroundImage: AssetImage('assets/image/dinein.png'),
        //                                   ),
        //                                 ),
        //
        //
        //
        //                               ],
        //                             ),
        //                           ),
        //
        //                         )
        //                     ),
        //
        //                   ],
        //                 ),
        //               ),
        //
        //             ],
        //           ),
        //         ),
        //
        //         GestureDetector(
        //           onTap: (){
        //             AppConstants.pagename = 'pick';
        //             Navigator.push(context, MaterialPageRoute(builder: (context) => PickUpHomeScreen()));
        //           },
        //           child: Container(
        //             height: MediaQuery.of(context).size.height * .15,
        //             width: MediaQuery.of(context).size.width,
        //             decoration: BoxDecoration(
        //                 color: Colors.white,
        //                 borderRadius: BorderRadius.circular(10)
        //             ),
        //             child: Padding(
        //               padding: const EdgeInsets.all(10.0),
        //               child: Stack(
        //
        //                 children: [
        //
        //                   Align(
        //                     alignment: Alignment.topLeft,
        //                     child: Column(
        //                       mainAxisAlignment: MainAxisAlignment.start,
        //                       crossAxisAlignment: CrossAxisAlignment.start,
        //                       children: [
        //                         Text('Pick-up' , style: TextStyle(color: Colors.black , fontWeight: FontWeight.bold, fontSize: 18 ),),
        //                         //Text('Order food you love' , style: TextStyle(color: Colors.black , fontWeight: FontWeight.w500 ,height:1 ,  fontSize: 14  )),
        //
        //                       ],
        //                     ),
        //                   ),
        //
        //
        //                   Align(
        //                       alignment: Alignment.bottomRight,
        //                       child: Image.asset(
        //                         'assets/image/pick_up.png',
        //                         width: 60,
        //                         height: 60,
        //                         fit: BoxFit.fill,
        //                       )
        //
        //                   ),
        //
        //                 ],
        //               ),
        //             ),
        //
        //           ),
        //         ),
        //        Padding(
        //           padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
        //           child: TitleWidget(title: 'Cuisines'.tr, onTap: () => Get.toNamed(RouteHelper.getCategoryRoute())),
        //         ),
        //         //Get.find<CategoryController>().getCategoryListDasboar(true) != null ?
        //         CuisinesViewDashboard()
        //             //: Container()
        //       ],
        //     ),
        //   ),
        // ),
        drawer: Drawer(
          child: ListView(
            // Important: Remove any padding from the ListView.
            padding: EdgeInsets.zero,
            children: [
              const DrawerHeader(
                decoration: BoxDecoration(
                  color: Color(0xffEF7822),
                ),
                child: CircleAvatar(
                  radius: 24,
                  //backgroundImage: NetworkImage('https://media-exp1.licdn.com/dms/image/C5603AQFtuW78eNazIw/profile-displayphoto-shrink_800_800/0/1567442703746?e=2147483647&v=beta&t=N5dGxws3xJIhwPM8w_i4dlX8qLmxznmVykPCTccYHj8'),
                  backgroundImage: NetworkImage(''),

                ),
              ),


              ListTile(
                title:  Text('my_address'.tr, style: TextStyle( color : Colors.black)),
                //leading: Icon(Icons.location_on ,),
                leading: Image.asset('assets/image/location.png',height: 25,width: 25,),
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => AddressScreen()));

                  //Navigator.pop(context);
                },
              ),
              ListTile(
                title:  Text('language'.tr, style: TextStyle( color : Colors.black)),
                //leading: Icon(Icons.language ,),
                leading: Image.asset('assets/image/language.png',height: 22,width: 22,),
                onTap: () {
                  //Get.offNamed(RouteHelper.getLanguageRoute('splash'));
                  Navigator.push(context, MaterialPageRoute(builder: (context) => ChooseLanguageScreen()));
                  // Update the state of the app
                  // ...
                  // Then close the drawer
                  //Navigator.pop(context);
                },
              ),

               ListTile(
                title:  Text('coupon'.tr, style: TextStyle( color : Colors.black)),
                leading: Image.asset( 'assets/image/coupon.png',height: 25,width: 25,),
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => CouponScreen(fromCheckout: false)));

                  // Update the state of the app
                  // ...
                  // Then close the drawer
                  //Navigator.pop(context);
                },
              ),

              ListTile(
                title:  Text('help_support'.tr, style: TextStyle( color : Colors.black)),
                leading: Image.asset( 'assets/image/support.png',height: 25,width: 25,),
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => SupportScreen()));

                  // Update the state of the app
                  // ...
                  // Then close the drawer
                  //Navigator.pop(context);
                },
              ),

              ListTile(
                title:  Text('privacy_policy'.tr, style: TextStyle( color : Colors.black)),
                leading: Image.asset( 'assets/image/policy.png',height: 25,width: 25,),
                onTap: () {
                  Get.toNamed(RouteHelper.getHtmlRoute('privacy-policy'));
                 // Navigator.push(context, MaterialPageRoute(builder: (context) => SupportScreen()));

                  // Update the state of the app
                  // ...
                  // Then close the drawer
                  //Navigator.pop(context);
                },
              ),

              ListTile(
                title:  Text('about_us'.tr, style: TextStyle( color : Colors.black)),
                leading: Image.asset( Images.about_us,height: 25,width: 25,),
                onTap: () {
                  Get.toNamed(RouteHelper.getHtmlRoute('about-us'));
                  // Update the state of the app
                  // ...
                  // Then close the drawer
                  //Navigator.pop(context);
                },
              ),
              ListTile(
                title:  Text('terms_conditions'.tr, style: TextStyle( color : Colors.black)),
                leading: Image.asset( Images.terms,height: 25,width: 25,),
                onTap: () {
                  Get.toNamed(RouteHelper.getHtmlRoute('terms-and-condition'));
                  // Update the state of the app
                  // ...
                  // Then close the drawer
                  //Navigator.pop(context);
                },
              ),

              ListTile(
                title:  Text('live_chat'.tr, style: TextStyle( color : Colors.black)),
                leading: Image.asset( Images.chat,height: 25,width: 25,),
                onTap: () {
                  Get.toNamed(RouteHelper.getConversationRoute());

                  // Update the state of the app
                  // ...
                  // Then close the drawer
                  //Navigator.pop(context);
                },
              ),

              Get.find<SplashController>().configModel.refEarningStatus == 1 ? ListTile(
                title:  Text('refer'.tr, style: TextStyle( color : Colors.black)),
                leading: Image.asset( Images.refer_code,height: 25,width: 25,),
                onTap: () {
                  Get.toNamed(RouteHelper.getReferAndEarnRoute());
                  // Update the state of the app
                  // ...
                  // Then close the drawer
                  //Navigator.pop(context);
                },
              ) : SizedBox(height: 5,),

              Get.find<SplashController>().configModel.customerWalletStatus == 1 ? ListTile(
                title:  Text('wallet'.tr, style: TextStyle( color : Colors.black)),
                leading: Image.asset( Images.wallet,height: 25,width: 25,),
                onTap: () {
                  Get.toNamed(RouteHelper.getWalletRoute(true));
                  // Update the state of the app
                  // ...
                  // Then close the drawer
                 // Navigator.pop(context);
                },
              ) : SizedBox(height: 5,),

              Get.find<SplashController>().configModel.loyaltyPointStatus == 1 ? ListTile(
                title:  Text('loyalty_points'.tr, style: TextStyle( color : Colors.black)),
                leading: Image.asset( Images.loyal,height: 25,width: 25,),
                onTap: () {
                  Get.toNamed(RouteHelper.getWalletRoute(false));
                  // Update the state of the app
                  // ...
                  // Then close the drawer
                  //Navigator.pop(context);
                },
              ) : SizedBox(height: 5,),

              Get.find<SplashController>().configModel.toggleDmRegistration && !ResponsiveHelper.isDesktop(context) ? ListTile(
                title:  Text('join_as_a_delivery_man'.tr, style: TextStyle( color : Colors.black)),
                leading: Image.asset( Images.delivery_man_join,height: 25,width: 25,),
                onTap: () {
                  Get.toNamed(RouteHelper.getDeliverymanRegistrationRoute());

                  // Update the state of the app
                  // ...
                  // Then close the drawer
                  //Navigator.pop(context);
                },
              ) : SizedBox(height: 5,),

              Get.find<SplashController>().configModel.toggleRestaurantRegistration && !ResponsiveHelper.isDesktop(context) ? ListTile(
                title:  Text('join_as_a_restaurant'.tr, style: TextStyle( color : Colors.black)),
                leading: Image.asset( Images.restaurant_join,height: 25,width: 25,),
                onTap: () {
                  Get.toNamed(RouteHelper.getRestaurantRegistrationRoute());
                  // Update the state of the app
                  // ...
                  // Then close the drawer
                 // Navigator.pop(context);
                },
              ) : SizedBox(height: 5,),

              Get.find<AuthController>().isLoggedIn()  ? ListTile(
                title:  Text('logout'.tr, style: TextStyle( color : Colors.black)),
                leading: Image.asset( Images.restaurant_join,height: 25,width: 25,),
                onTap: () {
                  // Update the state of the app
                  // ...
                  // Then close the drawer
                  Navigator.pop(context);
                },
              ) : ListTile(
                title:  Text('logout'.tr, style: TextStyle( color : Colors.black)),
                leading: Image.asset( Images.log_out,height: 25,width: 25,),
                onTap: () {
                  // Update the state of the app
                  // ...
                  // Then close the drawer
                  //Navigator.pop(context);
                },
              ),


              ListTile(
                title: const Text('Setting' , style: TextStyle( color : Colors.black)),
                leading: Icon(Icons.settings_outlined ,),
                onTap: () {
                  // Update the state of the app
                  // ...
                  // Then close the drawer
                  Navigator.pop(context);
                },
              ),
              ListTile(
                title: const Text('Help center 2' , style: TextStyle( color : Colors.black)),
                leading: Icon(Icons.help_outline, ),

                onTap: () {
                  // Update the state of the app
                  // ...
                  // Then close the drawer
                  Navigator.pop(context);
                },
              ),
              ListTile(
                title: const Text('More' , style: TextStyle( color : Colors.black)),
                leading: Icon(Icons.more_horiz, ),
                onTap: () {
                  // Update the state of the app
                  // ...
                  // Then close the drawer
                  Navigator.pop(context);
                },
              ),
              ListTile(
                title: const Text('Sign up or Login in' , style: TextStyle( color : Colors.black)),
                leading: Icon(Icons.login_outlined, ),
                onTap: () {
                  // Update the state of the app
                  // ...
                  // Then close the drawer
                  Navigator.pop(context);
                },
              ),
            ],
          ),
        ),
        // body: PageView.builder(
        //   controller: _pageController,
        //   itemCount: _screens.length,
        //   physics: NeverScrollableScrollPhysics(),
        //   itemBuilder: (context, index) {
        //     return _screens[index];
        //   },
        // ),
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
          Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(tabtitles[currentItemNumber]['title'],style: TextStyle(color: currentIndex == currentItemNumber ? Colors.deepOrange:Colors.black54 ),))
        ]),
      );

  void _setPage(int pageIndex) {
    setState(() {
      _pageController.jumpToPage(pageIndex);
      _pageIndex = pageIndex;
    });
  }
}
