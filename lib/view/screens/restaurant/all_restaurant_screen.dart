import 'package:efood_multivendor/controller/restaurant_controller.dart';
import 'package:efood_multivendor/util/app_constants.dart';
import 'package:efood_multivendor/util/dimensions.dart';
import 'package:efood_multivendor/view/base/custom_app_bar.dart';
import 'package:efood_multivendor/view/base/product_view.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../controller/location_controller.dart';
import '../../../helper/route_helper.dart';
import '../../../util/styles.dart';
import '../../base/product_view_big.dart';
import '../cart/cart_screen.dart';
import '../location/access_location_screen.dart';

class AllRestaurantScreen extends StatefulWidget {
  final bool isPopular;
  AllRestaurantScreen({@required this.isPopular});

  @override
  State<AllRestaurantScreen> createState() => _AllRestaurantScreenState();
}

class _AllRestaurantScreenState extends State<AllRestaurantScreen> {

  @override
  void initState() {
    super.initState();

    if(widget.isPopular) {
      Get.find<RestaurantController>().getPopularRestaurantList(false, 'all', false);
    }else {
      Get.find<RestaurantController>().getLatestRestaurantList(false, 'all', false);
    }
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      //appBar: CustomAppBar(title: widget.isPopular ? 'popular_restaurants'.tr : '${'new_on'.tr} ${AppConstants.APP_NAME}'),
      // appBar: AppBar(
      //   //title: const  Text('') ,
      //   title: GetBuilder<LocationController>(builder: (locationController) {
      //     return InkWell(
      //       onTap: (){
      //         Get.to(AccessLocationScreen(fromSignUp: false, fromHome: false, route: Get.currentRoute));
      //       },
      //       child: Column(
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
      //           Text('Dine-in',style: robotoRegular.copyWith(
      //             color: Colors.white, fontSize: Dimensions.fontSizeSmall,
      //           ),)
      //         ],
      //       ),
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
      //       child: InkWell(
      //         onTap: () => Get.toNamed(RouteHelper.getSearchRoute()),
      //         child:Padding(
      //           padding: const EdgeInsets.symmetric(horizontal: 15 , vertical: 10),
      //           child: Row(
      //             children:  [
      //               Expanded(child: CupertinoTextField(
      //                 enabled: false,
      //                 padding: EdgeInsets.symmetric(vertical: 12 , horizontal: 10),
      //                 placeholder: "Seach for shop & restaurants",
      //                 prefix: Padding(
      //                   padding: const EdgeInsets.only(left: 10),
      //                   child: Icon(Icons.search , color: Color(0xff7b7b7b) ,),
      //                 ),
      //                 decoration: BoxDecoration(
      //                     color: Color(0xfff7f7f7),
      //                     borderRadius : BorderRadius.circular(50)
      //                 ),
      //                 style: TextStyle(color: Color(0xff707070) ,
      //                   fontSize: 12, ) ,
      //               )),
      //             ],
      //           ),
      //         ),
      //       )
      //   ),
      // ),
      body: RefreshIndicator(
        onRefresh: () async {
          if(widget.isPopular) {
            await Get.find<RestaurantController>().getPopularRestaurantList(
              true, Get.find<RestaurantController>().type, false,
            );
          }else {
            await Get.find<RestaurantController>().getLatestRestaurantList(
              true, Get.find<RestaurantController>().type, false,
            );
          }
        },
        child: Scrollbar(
            child: SingleChildScrollView(
                child: Center(
                    child: SizedBox(
          width: Dimensions.WEB_MAX_WIDTH,
          child: GetBuilder<RestaurantController>(builder: (restController) {
            return ProductViewBig(
              isRestaurant: true, products: null, noDataText: 'no_restaurant_available'.tr,
              restaurants: widget.isPopular ? restController.popularRestaurantList : restController.latestRestaurantList,
              type: restController.type, onVegFilterTap: (String type) {
                if(widget.isPopular) {
                  Get.find<RestaurantController>().getPopularRestaurantList(true, type, true);
                }else {
                  Get.find<RestaurantController>().getLatestRestaurantList(true, type, true);
                }
              },
            );
          }),
        )))),
      ),
    );
  }
}
