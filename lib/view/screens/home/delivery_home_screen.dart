import 'package:efood_multivendor/controller/auth_controller.dart';
import 'package:efood_multivendor/controller/banner_controller.dart';
import 'package:efood_multivendor/controller/campaign_controller.dart';
import 'package:efood_multivendor/controller/category_controller.dart';
import 'package:efood_multivendor/controller/location_controller.dart';
import 'package:efood_multivendor/controller/notification_controller.dart';
import 'package:efood_multivendor/controller/order_controller.dart';
import 'package:efood_multivendor/controller/product_controller.dart';
import 'package:efood_multivendor/controller/restaurant_controller.dart';
import 'package:efood_multivendor/controller/splash_controller.dart';
import 'package:efood_multivendor/controller/user_controller.dart';
import 'package:efood_multivendor/data/model/response/config_model.dart';
import 'package:efood_multivendor/helper/responsive_helper.dart';
import 'package:efood_multivendor/helper/route_helper.dart';
import 'package:efood_multivendor/util/dimensions.dart';
import 'package:efood_multivendor/util/styles.dart';
import 'package:efood_multivendor/view/base/paginated_list_view.dart';
import 'package:efood_multivendor/view/base/product_view.dart';
import 'package:efood_multivendor/view/base/product_view_big.dart';
import 'package:efood_multivendor/view/base/web_menu_bar.dart';
import 'package:efood_multivendor/view/screens/home/theme1/theme1_home_screen.dart';
import 'package:efood_multivendor/view/screens/home/web_home_screen.dart';
import 'package:efood_multivendor/view/screens/home/widget/category_view_before_dashboard.dart';
import 'package:efood_multivendor/view/screens/home/widget/filter_view.dart';
import 'package:efood_multivendor/view/screens/home/widget/near_by_button_view.dart';
import 'package:efood_multivendor/view/screens/home/widget/popular_food_view.dart';
import 'package:efood_multivendor/view/screens/home/widget/item_campaign_view.dart';
import 'package:efood_multivendor/view/screens/home/widget/popular_restaurant_view.dart';
import 'package:efood_multivendor/view/screens/home/widget/banner_view.dart';
import 'package:efood_multivendor/view/screens/home/widget/category_view.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../cart/cart_screen.dart';
import '../location/access_location_screen.dart';

class DeliveryHomeScreen extends StatefulWidget {

  static Future<void> loadData(bool reload) async {
    Get.find<BannerController>().getBannerList(reload);
    Get.find<CategoryController>().getCategoryList(reload);
    if(Get.find<SplashController>().configModel.popularRestaurant == 1) {
      Get.find<RestaurantController>().getPopularRestaurantList(reload, 'all', false);
    }
    Get.find<CampaignController>().getItemCampaignList(reload);
    if(Get.find<SplashController>().configModel.popularFood == 1) {
      Get.find<ProductController>().getPopularProductList(reload, 'all', false);
    }
    if(Get.find<SplashController>().configModel.newRestaurant == 1) {
      Get.find<RestaurantController>().getLatestRestaurantList(reload, 'all', false);
    }
    if(Get.find<SplashController>().configModel.mostReviewedFoods == 1) {
      Get.find<ProductController>().getReviewedProductList(reload, 'all', false);
    }
    Get.find<RestaurantController>().getRestaurantList(1, reload);
    if(Get.find<AuthController>().isLoggedIn()) {
      Get.find<UserController>().getUserInfo();
      Get.find<NotificationController>().getNotificationList(reload);
      Get.find<OrderController>().getRunningOrders(1, notify: false, fromHome: true);
    }
  }

  @override
  State<DeliveryHomeScreen> createState() => _HomeScreenStateDelivery();
}

class _HomeScreenStateDelivery extends State<DeliveryHomeScreen> {

  final ScrollController _scrollController = ScrollController();
  ConfigModel _configModel = Get.find<SplashController>().configModel;

  @override
  void initState() {
    super.initState();

    DeliveryHomeScreen.loadData(false);
  }


  @override
  Widget build(BuildContext context) {

    return Scaffold(
      // appBar: AppBar(
      //   //title: const  Text('') ,
      //   title: GetBuilder<LocationController>(builder: (locationController) {
      //     return InkWell(
      //       onTap: (){
      //         Get.to(AccessLocationScreen(fromSignUp: false, fromHome: false, route: Get.currentRoute));
      //       },
      //       child:Column(
      //         crossAxisAlignment: CrossAxisAlignment.start,
      //         children: [
      //           Row(
      //             crossAxisAlignment: CrossAxisAlignment.center,
      //             mainAxisAlignment: MainAxisAlignment.start,
      //             children: [
      //               Icon(
      //                 locationController.getUserAddress().addressType == 'home' ? Icons.home_filled
      //                     : locationController.getUserAddress().addressType == 'office' ? Icons.work : Icons.location_on,
      //                 size: 20, color: Theme.of(context).textTheme.bodyText1.color,
      //               ),
      //               SizedBox(width: 10),
      //               Flexible(
      //                 child: Text(
      //                   locationController.getUserAddress().address,
      //                   style: robotoRegular.copyWith(
      //                     color: Colors.white, fontSize: Dimensions.fontSizeSmall,
      //                   ),
      //                   maxLines: 1, overflow: TextOverflow.ellipsis,
      //                 ),
      //               ),
      //               Icon(Icons.arrow_drop_down, color: Theme.of(context).textTheme.bodyText1.color),
      //             ],
      //           ),
      //           Text('Food Delivery',style: robotoRegular.copyWith(
      //             color: Colors.white, fontSize: Dimensions.fontSizeSmall,
      //           ),)
      //         ],
      //       )
      //     );
      //   }),
      //   actions: [
      //     GestureDetector(
      //       child: Icon(Icons.shopping_bag_outlined),
      //       onTap: (){
      //         Get.to(CartScreen(fromNav: true),);
      //       },
      //     ),
      //     SizedBox(width: 10,)
      //   ],
      //   bottom: PreferredSize(
      //     preferredSize:const Size.fromHeight(40),
      //     child: InkWell(
      //       onTap: () => Get.toNamed(RouteHelper.getSearchRoute()),
      //       child:Padding(
      //         padding: const EdgeInsets.symmetric(horizontal: 15 , vertical: 10),
      //         child: Row(
      //           children:  [
      //             Expanded(child: CupertinoTextField(
      //               enabled: false,
      //               padding: EdgeInsets.symmetric(vertical: 12 , horizontal: 10),
      //               placeholder: "Seach for shop & restaurants",
      //               prefix: Padding(
      //                 padding: const EdgeInsets.only(left: 10),
      //                 child: Icon(Icons.search , color: Color(0xff7b7b7b) ,),
      //               ),
      //               decoration: BoxDecoration(
      //                   color: Color(0xfff7f7f7),
      //                   borderRadius : BorderRadius.circular(50)
      //               ),
      //               style: TextStyle(color: Color(0xff707070) ,
      //                 fontSize: 12, ) ,
      //             )),
      //           ],
      //         ),
      //       ),
      //     )
      //
      //
      //   ),
      // ),
      // appBar: ResponsiveHelper.isDesktop(context) ? WebMenuBar() : null,
      // backgroundColor: ResponsiveHelper.isDesktop(context) ? Theme.of(context).cardColor : null,
      body: SafeArea(
        child: RefreshIndicator(
          onRefresh: () async {
            await Get.find<BannerController>().getBannerList(true);
            await Get.find<CategoryController>().getCategoryList(true);
            await Get.find<RestaurantController>().getPopularRestaurantList(true, 'all', false);
            await Get.find<CampaignController>().getItemCampaignList(true);
            await Get.find<ProductController>().getPopularProductList(true, 'all', false);
            await Get.find<RestaurantController>().getLatestRestaurantList(true, 'all', false);
            await Get.find<ProductController>().getReviewedProductList(true, 'all', false);
            await Get.find<RestaurantController>().getRestaurantList(1, true);
            if(Get.find<AuthController>().isLoggedIn()) {
              await Get.find<UserController>().getUserInfo();
              await Get.find<NotificationController>().getNotificationList(true);
            }
          },
          child:
          // ResponsiveHelper.isDesktop(context) ? WebHomeScreen(
          //   scrollController: _scrollController,
          // ) : (Get.find<SplashController>().configModel.theme == 2) ? Theme1HomeScreen(
          //   scrollController: _scrollController,
          // ) :
          CustomScrollView(
            controller: _scrollController,
            physics: AlwaysScrollableScrollPhysics(),
            slivers: [

              // App Bar
              // SliverAppBar(
              //   floating: true, elevation: 0, automaticallyImplyLeading: true,
              //   backgroundColor: Color(0xffFF8A00),
              //   //backgroundColor: ResponsiveHelper.isDesktop(context) ? Colors.transparent : Theme.of(context).backgroundColor,
              //   title: Center(child: Container(
              //     width: Dimensions.WEB_MAX_WIDTH, height: 60,
              //     //color: Theme.of(context).backgroundColor,
              //     child: Row(children: [
              //       Expanded(child: InkWell(
              //         onTap: () => Get.to(RouteHelper.getAccessLocationRoute('home')),
              //         child: Padding(
              //           padding: EdgeInsets.symmetric(
              //             vertical: Dimensions.PADDING_SIZE_SMALL,
              //             horizontal: ResponsiveHelper.isDesktop(context) ? Dimensions.PADDING_SIZE_SMALL : 0,
              //           ),
              //           child: GetBuilder<LocationController>(builder: (locationController) {
              //             return Column(
              //               crossAxisAlignment: CrossAxisAlignment.start,
              //               children: [
              //                 Row(
              //                   crossAxisAlignment: CrossAxisAlignment.center,
              //                   mainAxisAlignment: MainAxisAlignment.start,
              //                   children: [
              //                     Icon(
              //                       locationController.getUserAddress().addressType == 'home' ? Icons.home_filled
              //                           : locationController.getUserAddress().addressType == 'office' ? Icons.work : Icons.location_on,
              //                       size: 20, color: Theme.of(context).textTheme.bodyText1.color,
              //                     ),
              //                     SizedBox(width: 10),
              //                     Flexible(
              //                       child: Text(
              //                         locationController.getUserAddress().address,
              //                         style: robotoRegular.copyWith(
              //                           color: Colors.white, fontSize: Dimensions.fontSizeSmall,
              //                         ),
              //                         maxLines: 1, overflow: TextOverflow.ellipsis,
              //                       ),
              //                     ),
              //                     Icon(Icons.arrow_drop_down, color: Theme.of(context).textTheme.bodyText1.color),
              //                   ],
              //                 ),
              //                 Text('Food Delivery',style: robotoRegular.copyWith(
              //                   color: Colors.white, fontSize: Dimensions.fontSizeSmall,
              //                 ),)
              //               ],
              //             );
              //           }),
              //         ),
              //       )),
              //       InkWell(
              //         child: GetBuilder<NotificationController>(builder: (notificationController) {
              //           return Row(
              //             children: [
              //               // Stack(children: [
              //               //   Icon(Icons.notifications, size: 25, color: Colors.white,),
              //               //   notificationController.hasNotification ? Positioned(top: 0, right: 0, child: Container(
              //               //     height: 10, width: 10, decoration: BoxDecoration(
              //               //     color: Theme.of(context).primaryColor, shape: BoxShape.circle,
              //               //     border: Border.all(width: 1, color: Theme.of(context).cardColor),
              //               //   ),
              //               //   )) : SizedBox(),
              //               // ]),
              //
              //               Stack(children: [
              //                 Icon(Icons.shopping_bag_outlined, size: 25, color: Colors.white,),
              //                 notificationController.hasNotification ? Positioned(top: 0, right: 0, child: Container(
              //                   height: 10, width: 10, decoration: BoxDecoration(
              //                     color: Colors.white, shape: BoxShape.circle,
              //                     border: Border.all(width: 1, color: Colors.white,)
              //                 ),
              //                 )) : SizedBox(),
              //               ]),
              //             ],
              //           );
              //         }),
              //         //onTap: () => Get.toNamed(RouteHelper.getNotificationRoute()),
              //         onTap: () => Get.to(CartScreen(fromNav: true),),
              //       ),
              //     ]),
              //   )),
              // ),
              //
              // // Search Button
              // SliverPersistentHeader(
              //
              //   pinned: true,
              //   delegate: SliverDelegate(child: Center(child: Container(
              //     height: 50, width: Dimensions.WEB_MAX_WIDTH,
              //     color: Color(0xffFF8A00),
              //     padding: EdgeInsets.only(top: 0,bottom: 15,left: 10,right: 10),
              //     child: InkWell(
              //       onTap: () => Get.toNamed(RouteHelper.getSearchRoute()),
              //       child: Container(
              //         padding: EdgeInsets.symmetric(horizontal: Dimensions.PADDING_SIZE_SMALL),
              //         decoration: BoxDecoration(
              //           color: Theme.of(context).cardColor,
              //           borderRadius: BorderRadius.circular(Dimensions.RADIUS_LARGE),
              //           //boxShadow: [BoxShadow(color: Colors.grey[Get.isDarkMode ? 800 : 200], spreadRadius: 1, blurRadius: 5)],
              //         ),
              //         child: Row(children: [
              //           Icon(Icons.search, size: 25, color: Theme.of(context).primaryColor),
              //           SizedBox(width: Dimensions.PADDING_SIZE_EXTRA_SMALL),
              //           Expanded(child: Text('search_food_or_restaurant'.tr, style: robotoRegular.copyWith(
              //             fontSize: Dimensions.fontSizeSmall, color: Theme.of(context).hintColor,
              //           ))),
              //         ]),
              //       ),
              //     ),
              //   ))),
              // ),

              SliverToBoxAdapter(
                child: Center(child: Container(
                  margin: EdgeInsets.fromLTRB(50, 0, 50, 0),
                  width: Dimensions.WEB_MAX_WIDTH,
                  child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [

                    BannerView(),
                    CategoryViewBeforeDashboard(),
                    //CategoryView(),
                    //CategoryViewBeforeDashboard(),
                     _configModel.popularRestaurant == 1 ? PopularRestaurantView(isPopular: true) : SizedBox(),
                     NearByButtonView(),

                    ItemCampaignView(),
                    _configModel.popularFood == 1 ? PopularFoodView(isPopular: true) : SizedBox(),
                    _configModel.newRestaurant == 1 ? PopularRestaurantView(isPopular: false) : SizedBox(),
                    _configModel.mostReviewedFoods == 1 ? PopularFoodView(isPopular: false) : SizedBox(),

                    Padding(
                      padding: EdgeInsets.fromLTRB(10, 15, 0, 5),
                      child: Row(children: [
                        Expanded(child: Text(
                          'all_restaurants'.tr,
                          style: robotoMedium.copyWith(fontSize: Dimensions.fontSizeLarge),
                        )),
                        FilterView(),
                      ]),
                    ),

                    GetBuilder<RestaurantController>(builder: (restaurantController) {
                      return PaginatedListView(
                        scrollController: _scrollController,
                        totalSize: restaurantController.restaurantModel != null ? restaurantController.restaurantModel.totalSize : null,
                        offset: restaurantController.restaurantModel != null ? restaurantController.restaurantModel.offset : null,
                        onPaginate: (int offset) async => await restaurantController.getRestaurantList(offset, false),
                        productView: ProductViewBig(
                          isRestaurant: true, products: null,
                          restaurants: restaurantController.restaurantModel != null ? restaurantController.restaurantModel.restaurants : null,
                          padding: EdgeInsets.symmetric(
                            horizontal: ResponsiveHelper.isDesktop(context) ? Dimensions.PADDING_SIZE_EXTRA_SMALL : Dimensions.PADDING_SIZE_SMALL,
                            vertical: ResponsiveHelper.isDesktop(context) ? Dimensions.PADDING_SIZE_EXTRA_SMALL : 0,
                          ),
                        ),
                      );
                    }),

                  ]),
                )),
              ),

            ],
          ),
        ),
      ),
    );
  }
}

class SliverDelegate extends SliverPersistentHeaderDelegate {
  Widget child;

  SliverDelegate({@required this.child});

  @override
  Widget build(BuildContext context, double shrinkOffset, bool overlapsContent) {
    return child;
  }

  @override
  double get maxExtent => 50;

  @override
  double get minExtent => 50;

  @override
  bool shouldRebuild(SliverDelegate oldDelegate) {
    return oldDelegate.maxExtent != 50 || oldDelegate.minExtent != 50 || child != oldDelegate.child;
  }
}
