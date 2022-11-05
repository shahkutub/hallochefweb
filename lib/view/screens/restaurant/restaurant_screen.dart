import 'package:cached_network_image/cached_network_image.dart';
import 'package:efood_multivendor/controller/cart_controller.dart';
import 'package:efood_multivendor/controller/category_controller.dart';
import 'package:efood_multivendor/controller/localization_controller.dart';
import 'package:efood_multivendor/controller/restaurant_controller.dart';
import 'package:efood_multivendor/controller/splash_controller.dart';
import 'package:efood_multivendor/data/model/response/category_model.dart';
import 'package:efood_multivendor/data/model/response/product_model.dart';
import 'package:efood_multivendor/data/model/response/restaurant_model.dart';
import 'package:efood_multivendor/helper/date_converter.dart';
import 'package:efood_multivendor/helper/price_converter.dart';
import 'package:efood_multivendor/helper/responsive_helper.dart';
import 'package:efood_multivendor/helper/route_helper.dart';
import 'package:efood_multivendor/util/dimensions.dart';
import 'package:efood_multivendor/util/images.dart';
import 'package:efood_multivendor/util/styles.dart';
import 'package:efood_multivendor/view/base/bottom_cart_widget.dart';
import 'package:efood_multivendor/view/base/custom_image.dart';
import 'package:efood_multivendor/view/base/product_view.dart';
import 'package:efood_multivendor/view/base/web_menu_bar.dart';
import 'package:efood_multivendor/view/screens/restaurant/recent_order.dart';
import 'package:efood_multivendor/view/screens/restaurant/widget/restaurant_description_view.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:proste_bezier_curve/proste_bezier_curve.dart';

import '../../base/custom_button.dart';

class RestaurantScreen extends StatefulWidget {
  final Restaurant restaurant;
  RestaurantScreen({@required this.restaurant});

  @override
  State<RestaurantScreen> createState() => _RestaurantScreenState();
}

class _RestaurantScreenState extends State<RestaurantScreen> {
  final ScrollController scrollController = ScrollController();
  final bool _ltr = Get.find<LocalizationController>().isLtr;

  @override
  void initState() {
    super.initState();

    Get.find<RestaurantController>().getRestaurantDetails(Restaurant(id: widget.restaurant.id));
    if(Get.find<CategoryController>().categoryList == null) {
      Get.find<CategoryController>().getCategoryList(true);
    }
    Get.find<RestaurantController>().getRestaurantProductList(widget.restaurant.id, 1, 'all', false);
    scrollController?.addListener(() {
      if (scrollController.position.pixels == scrollController.position.maxScrollExtent
          && Get.find<RestaurantController>().restaurantProducts != null
          && !Get.find<RestaurantController>().foodPaginate) {
        int pageSize = (Get.find<RestaurantController>().foodPageSize / 10).ceil();
        if (Get.find<RestaurantController>().foodOffset < pageSize) {
          Get.find<RestaurantController>().setFoodOffset(Get.find<RestaurantController>().foodOffset+1);
          print('end of the page');
          Get.find<RestaurantController>().showFoodBottomLoader();
          Get.find<RestaurantController>().getRestaurantProductList(
            widget.restaurant.id, Get.find<RestaurantController>().foodOffset, Get.find<RestaurantController>().type, false,
          );
        }
      }
    });
  }

  @override
  void dispose() {
    super.dispose();

    scrollController?.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: ResponsiveHelper.isDesktop(context) ? WebMenuBar() : null,
      backgroundColor: Theme.of(context).cardColor,
      body: GetBuilder<RestaurantController>(builder: (restController) {
        return GetBuilder<CategoryController>(builder: (categoryController) {
          Restaurant _restaurant;
          if(restController.restaurant != null && restController.restaurant.name != null && categoryController.categoryList != null) {
            _restaurant = restController.restaurant;
          }
          restController.setCategoryList();

          return (restController.restaurant != null && restController.restaurant.name != null && categoryController.categoryList != null) ?
          Container(
            child:Row(
              children: <Widget>[
                new Flexible(child: CustomScrollView(
                  physics: AlwaysScrollableScrollPhysics(),
                  controller: scrollController,
                  slivers: [



                    ResponsiveHelper.isDesktop(context) ? SliverToBoxAdapter(
                      child: Container(
                        color: Color(0xFF171A29),
                        padding: EdgeInsets.all(Dimensions.PADDING_SIZE_LARGE),
                        alignment: Alignment.center,
                        child: Center(child: SizedBox(width: Dimensions.WEB_MAX_WIDTH, child: Padding(
                          padding: EdgeInsets.symmetric(horizontal: Dimensions.PADDING_SIZE_SMALL),
                          child: Column(children: [

                            // Expanded(
                            //   child:
                            ClipRRect(
                              borderRadius: BorderRadius.circular(Dimensions.RADIUS_SMALL),
                              child: CustomImage(
                                fit: BoxFit.cover, placeholder: Images.restaurant_cover, height: 220,
                                image: '${Get.find<SplashController>().configModel.baseUrls.restaurantCoverPhotoUrl}/${_restaurant.coverPhoto}',
                              ),
                            ),
                            //),
                            SizedBox(height: Dimensions.PADDING_SIZE_LARGE),
                            RestaurantDescriptionView(restaurant: _restaurant)
                            //Expanded(child: RestaurantDescriptionView(restaurant: _restaurant)),

                          ]),
                        ))),
                      ),
                    ) :
                    SliverAppBar(
                      expandedHeight: 230, toolbarHeight: 50,
                      pinned: true, floating: false,
                      backgroundColor: Theme.of(context).primaryColor,
                      leading: IconButton(
                        icon: Container(
                          height: 50, width: 50,
                          decoration: BoxDecoration(shape: BoxShape.circle, color: Theme.of(context).primaryColor),
                          alignment: Alignment.center,
                          child: Icon(Icons.chevron_left, color: Theme.of(context).cardColor),
                        ),
                        onPressed: () => Get.back(),
                      ),
                      flexibleSpace: FlexibleSpaceBar(
                        background:Container(
                          child: Stack(
                            children: [
                              Align(
                                alignment: Alignment.center,
                                child:  CustomImage(
                                  height: Get.width*.7,
                                  //height: 250,
                                  fit: BoxFit.fill, placeholder: Images.restaurant_cover,
                                  image: '${Get.find<SplashController>().configModel.baseUrls.restaurantCoverPhotoUrl}/${_restaurant.coverPhoto}',
                                ),
                              ),

                              Align(
                                alignment: Alignment.bottomLeft,
                                child:
                                _restaurant.discount != null ?


                                ClipPath(
                                    clipper: ProsteBezierCurve(
                                      position: ClipPosition.top,
                                      list: [
                                        BezierCurveSection(
                                          start: Offset(context.width, 0),
                                          top: Offset(context.width/4.5, 15),
                                          end: Offset(0, 0),
                                        ),
                                      ],
                                    ),
                                    child:
                                    Container(
                                      alignment: Alignment.bottomLeft,
                                      width: context.width,
                                      height: 110,
                                      //margin: EdgeInsets.symmetric(vertical: Dimensions.PADDING_SIZE_SMALL),
                                      decoration: BoxDecoration(borderRadius: BorderRadius.circular(0), color: Color(0xFFE34A28).withOpacity(0.4)),

                                      // decoration: new BoxDecoration(
                                      //   color: Colors.orange,
                                      //   boxShadow: [
                                      //     new BoxShadow(blurRadius: 0.0)
                                      //   ],
                                      //   borderRadius: new BorderRadius.vertical(
                                      //       top: new Radius.elliptical(
                                      //           MediaQuery.of(context).size.width, 100.0)),
                                      // ),

                                      padding: EdgeInsets.all(Dimensions.PADDING_SIZE_SMALL),
                                      child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          mainAxisAlignment: MainAxisAlignment.center, children: [
                                        Text(
                                          _restaurant.discount.discountType == 'percent' ? '${_restaurant.discount.discount}% OFF'
                                              : '${PriceConverter.convertPrice(_restaurant.discount.discount)} OFF',
                                          style: robotoMedium.copyWith(fontSize: Dimensions.fontSizeLarge, color: Theme.of(context).cardColor),
                                        ),
                                        Text(
                                          _restaurant.discount.discountType == 'percent'
                                              ? '${'enjoy'.tr} ${_restaurant.discount.discount}% ${'off_on_all_categories'.tr}'
                                              : '${'enjoy'.tr} ${PriceConverter.convertPrice(_restaurant.discount.discount)}'
                                              ' ${'off_on_all_categories'.tr}',
                                          style: robotoMedium.copyWith(fontSize: Dimensions.fontSizeSmall, color: Theme.of(context).cardColor),
                                        ),
                                        SizedBox(height: (_restaurant.discount.minPurchase != 0 || _restaurant.discount.maxDiscount != 0) ? 5 : 0),

                                        Row(
                                          children: [
                                            _restaurant.discount.minPurchase != 0 ? Text(
                                              '[ ${'minimum_purchase'.tr}: ${PriceConverter.convertPrice(_restaurant.discount.minPurchase)} ]',
                                              style: robotoRegular.copyWith(fontSize: Dimensions.fontSizeExtraSmall, color: Theme.of(context).cardColor),
                                            ) : SizedBox(),
                                            _restaurant.discount.maxDiscount != 0 ? Text(
                                              '[ ${'maximum_discount'.tr}: ${PriceConverter.convertPrice(_restaurant.discount.maxDiscount)} ]',
                                              style: robotoRegular.copyWith(fontSize: Dimensions.fontSizeExtraSmall, color: Theme.of(context).cardColor),
                                            ) : SizedBox(),
                                            // Text(
                                            //   '[ ${'daily_time'.tr}: ${DateConverter.convertTimeToTime(_restaurant.discount.startTime)} '
                                            //       '- ${DateConverter.convertTimeToTime(_restaurant.discount.endTime)} ]',
                                            //   style: robotoRegular.copyWith(fontSize: Dimensions.fontSizeExtraSmall, color: Theme.of(context).cardColor),
                                            // ),
                                          ],

                                        ),


                                      ]),
                                    )
                                  // Container(
                                  //   color: Colors.black54,
                                  //   height: 150,
                                  // ),
                                ) : SizedBox(),

                              )

                            ],
                          ),
                        ),
                      ),
                      actions: [

                        Row(
                          children: [
                            IconButton(
                              onPressed: () => Get.toNamed(RouteHelper.getSearchRestaurantProductRoute(_restaurant.id)),
                              icon: Container(
                                height: 50, width: 50,
                                decoration: BoxDecoration(shape: BoxShape.circle, color: Theme.of(context).primaryColor),
                                alignment: Alignment.center,
                                child: Icon(Icons.group_add_outlined, size: 20, color: Theme.of(context).cardColor),
                              ),
                            ),
                            IconButton(
                              onPressed: () => Get.toNamed(RouteHelper.getSearchRestaurantProductRoute(_restaurant.id)),
                              icon: Container(
                                height: 50, width: 50,
                                decoration: BoxDecoration(shape: BoxShape.circle, color: Theme.of(context).primaryColor),
                                alignment: Alignment.center,
                                child: Icon(Icons.share_outlined, size: 20, color: Theme.of(context).cardColor),
                              ),
                            )
                          ],
                        )


                      ],

                    ),

                    SliverToBoxAdapter(child: Center(child: Container(
                      width: Dimensions.WEB_MAX_WIDTH,
                      padding: EdgeInsets.all(Dimensions.PADDING_SIZE_SMALL),
                      color: Theme.of(context).cardColor,
                      child: Column(children: [
                        // _restaurant.discount != null ? Container(
                        //   width: context.width,
                        //   //margin: EdgeInsets.symmetric(vertical: Dimensions.PADDING_SIZE_SMALL),
                        //   decoration: BoxDecoration(borderRadius: BorderRadius.circular(0), color: Colors.purpleAccent),
                        //   padding: EdgeInsets.all(Dimensions.PADDING_SIZE_SMALL),
                        //   child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
                        //     Text(
                        //       _restaurant.discount.discountType == 'percent' ? '${_restaurant.discount.discount}% OFF'
                        //           : '${PriceConverter.convertPrice(_restaurant.discount.discount)} OFF',
                        //       style: robotoMedium.copyWith(fontSize: Dimensions.fontSizeLarge, color: Theme.of(context).cardColor),
                        //     ),
                        //     Text(
                        //       _restaurant.discount.discountType == 'percent'
                        //           ? '${'enjoy'.tr} ${_restaurant.discount.discount}% ${'off_on_all_categories'.tr}'
                        //           : '${'enjoy'.tr} ${PriceConverter.convertPrice(_restaurant.discount.discount)}'
                        //           ' ${'off_on_all_categories'.tr}',
                        //       style: robotoMedium.copyWith(fontSize: Dimensions.fontSizeSmall, color: Theme.of(context).cardColor),
                        //     ),
                        //     SizedBox(height: (_restaurant.discount.minPurchase != 0 || _restaurant.discount.maxDiscount != 0) ? 5 : 0),
                        //     _restaurant.discount.minPurchase != 0 ? Text(
                        //       '[ ${'minimum_purchase'.tr}: ${PriceConverter.convertPrice(_restaurant.discount.minPurchase)} ]',
                        //       style: robotoRegular.copyWith(fontSize: Dimensions.fontSizeExtraSmall, color: Theme.of(context).cardColor),
                        //     ) : SizedBox(),
                        //     _restaurant.discount.maxDiscount != 0 ? Text(
                        //       '[ ${'maximum_discount'.tr}: ${PriceConverter.convertPrice(_restaurant.discount.maxDiscount)} ]',
                        //       style: robotoRegular.copyWith(fontSize: Dimensions.fontSizeExtraSmall, color: Theme.of(context).cardColor),
                        //     ) : SizedBox(),
                        //     Text(
                        //       '[ ${'daily_time'.tr}: ${DateConverter.convertTimeToTime(_restaurant.discount.startTime)} '
                        //           '- ${DateConverter.convertTimeToTime(_restaurant.discount.endTime)} ]',
                        //       style: robotoRegular.copyWith(fontSize: Dimensions.fontSizeExtraSmall, color: Theme.of(context).cardColor),
                        //     ),
                        //   ]),
                        // ) : SizedBox(),
                        ResponsiveHelper.isDesktop(context) ? SizedBox() : RestaurantDescriptionView(restaurant: _restaurant),
                        //RecentOrderView(isPopular: true,)


                      ]),
                    ))),

                    (restController.categoryList.length > 0) ? SliverPersistentHeader(
                      pinned: false,
                      delegate: SliverDelegate(child: Center(child: Container(
                        //height: 50, width: context.width*5, color: Theme.of(context).cardColor,
                        height: 50, width: Dimensions.WEB_MAX_WIDTH, color: Theme.of(context).cardColor,
                        padding: EdgeInsets.symmetric(vertical: Dimensions.PADDING_SIZE_EXTRA_SMALL),
                        child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: restController.categoryList.length,
                          padding: EdgeInsets.only(left: Dimensions.PADDING_SIZE_SMALL),
                          physics: BouncingScrollPhysics(),
                          itemBuilder: (context, index) {
                            return InkWell(
                              onTap: () => restController.setCategoryIndex(index),
                              child: Container(
                                padding: EdgeInsets.only(
                                  left: index == 0 ? Dimensions.PADDING_SIZE_LARGE : Dimensions.PADDING_SIZE_SMALL,
                                  right: index == restController.categoryList.length-1 ? Dimensions.PADDING_SIZE_LARGE : Dimensions.PADDING_SIZE_SMALL,
                                  top: Dimensions.PADDING_SIZE_SMALL,
                                ),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.horizontal(
                                    left: Radius.circular(
                                      _ltr ? index == 0 ? Dimensions.RADIUS_EXTRA_LARGE : 0 : index == restController.categoryList.length-1
                                          ? Dimensions.RADIUS_EXTRA_LARGE : 0,
                                    ),
                                    right: Radius.circular(
                                      _ltr ? index == restController.categoryList.length-1 ? Dimensions.RADIUS_EXTRA_LARGE : 0 : index == 0
                                          ? Dimensions.RADIUS_EXTRA_LARGE : 0,
                                    ),
                                  ),
                                  color: Theme.of(context).primaryColor.withOpacity(0.1),
                                ),
                                child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
                                  Text(
                                    restController.categoryList[index].name,
                                    style: index == restController.categoryIndex
                                        ? robotoMedium.copyWith(fontSize: Dimensions.fontSizeSmall, color: Theme.of(context).primaryColor)
                                        : robotoRegular.copyWith(fontSize: Dimensions.fontSizeSmall, color: Theme.of(context).disabledColor),
                                  ),
                                  index == restController.categoryIndex ? Container(
                                    height: 5, width: 5,
                                    decoration: BoxDecoration(color: Theme.of(context).primaryColor, shape: BoxShape.circle),
                                  ) : SizedBox(height: 5, width: 5),
                                ]),
                              ),
                            );
                          },
                        ),
                      ))),
                    ) : SliverToBoxAdapter(child: SizedBox()),

                    SliverToBoxAdapter(child: Center(child: Container(
                      width: Dimensions.WEB_MAX_WIDTH,
                      decoration: BoxDecoration(
                        color: Theme.of(context).cardColor,
                      ),
                      child: Column(children: [
                        ProductView(
                          isRestaurant: false, restaurants: null,
                          products: restController.categoryList.length > 0 ? restController.restaurantProducts : null,
                          inRestaurantPage: true, type: restController.type, onVegFilterTap: (String type) {
                          restController.getRestaurantProductList(restController.restaurant.id, 1, type, true);
                        },
                          padding: EdgeInsets.symmetric(
                            horizontal: Dimensions.PADDING_SIZE_SMALL,
                            vertical: ResponsiveHelper.isDesktop(context) ? Dimensions.PADDING_SIZE_SMALL : 0,
                          ),
                        ),
                        restController.foodPaginate ? Center(child: Padding(
                          padding: EdgeInsets.all(Dimensions.PADDING_SIZE_SMALL),
                          child: CircularProgressIndicator(),
                        )) : SizedBox(),

                      ]),
                    ))),
                  ],
                ) , flex: 7,),
                new Flexible(
                  //child: Container(
                  //alignment: Alignment.center,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    //mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(height: 20,),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text('Your Cart',style: TextStyle(fontSize: 15,color: Colors.black),)
                        ],
                      ),
                      SizedBox(height: 20,),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text('Start adding items to your cart',style: TextStyle(fontSize: 10,color: Colors.grey),)
                        ],
                      ),

                      SizedBox(height: 20,),

                      Container(
                        margin: EdgeInsets.fromLTRB(5, 0, 5, 0),
                        width: context.width/5,
                        height: 1,
                        color: Colors.grey,
                      ),

                      SizedBox(height: 20,),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Text(' Tk 0   ',style: TextStyle(fontSize: 12,color: Colors.grey),)
                        ],
                      ),

                      SizedBox(height: 20,),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Text(' Tk 0   ',style: TextStyle(fontSize: 12,color: Colors.black,fontWeight: FontWeight.bold),)
                        ],
                      ),


                      SizedBox(height: 40,),
                      //Go to Checkout
                      InkWell(
                        onTap: (){
                          //Navigator.of(context).push(MaterialPageRoute(builder: (context) => DashboardScreenWeb(pageIndex: 0,)));
                        },
                        child: Container(
                          margin: EdgeInsets.fromLTRB(15, 0, 15, 0),
                          padding: EdgeInsets.fromLTRB(25, 7, 25, 7),
                         // height: 30,
                          //width: 100,
                          decoration: BoxDecoration(

                            color: Color(0xFFCACACA),
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
                              "Go to Checkout",style: TextStyle(fontSize: 15,color: Colors.white),
                            ),
                          ),
                        ),
                      )

                    ],
                  ),
                //),
                  flex: 2,)
              ],
            )


          )
          : Center(child: CircularProgressIndicator());
        });
      }),

      bottomNavigationBar: GetBuilder<CartController>(builder: (cartController) {
          return cartController.cartList.length > 0 && !ResponsiveHelper.isDesktop(context) ? BottomCartWidget() : SizedBox();
        })
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

class CategoryProduct {
  CategoryModel category;
  List<Product> products;
  CategoryProduct(this.category, this.products);
}

class CurveClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    int curveHeight = 40;
    Offset controlPoint = Offset(size.width / 2, size.height + curveHeight);
    Offset endPoint = Offset(size.width, size.height - curveHeight);

    Path path = Path()
      ..lineTo(0, size.height - curveHeight)
      ..quadraticBezierTo(controlPoint.dx, controlPoint.dy, endPoint.dx, endPoint.dy)
      ..lineTo(size.width, 0)
      ..close();

    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}
