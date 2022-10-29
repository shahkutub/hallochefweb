import 'package:efood_multivendor/controller/auth_controller.dart';
import 'package:efood_multivendor/controller/restaurant_controller.dart';
import 'package:efood_multivendor/controller/splash_controller.dart';
import 'package:efood_multivendor/controller/theme_controller.dart';
import 'package:efood_multivendor/controller/wishlist_controller.dart';
import 'package:efood_multivendor/data/model/response/restaurant_model.dart';
import 'package:efood_multivendor/helper/route_helper.dart';
import 'package:efood_multivendor/util/app_constants.dart';
import 'package:efood_multivendor/util/dimensions.dart';
import 'package:efood_multivendor/util/styles.dart';
import 'package:efood_multivendor/view/base/custom_image.dart';
import 'package:efood_multivendor/view/base/custom_snackbar.dart';
import 'package:efood_multivendor/view/base/discount_tag.dart';
import 'package:efood_multivendor/view/base/not_available_widget.dart';
import 'package:efood_multivendor/view/base/rating_bar.dart';
import 'package:efood_multivendor/view/base/title_widget.dart';
import 'package:efood_multivendor/view/screens/restaurant/restaurant_screen.dart';
import 'package:flutter/material.dart';
import 'package:shimmer_animation/shimmer_animation.dart';
import 'package:get/get.dart';

class PopularRestaurantView extends StatelessWidget {
  final bool isPopular;
  PopularRestaurantView({@required this.isPopular});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<RestaurantController>(builder: (restController) {
      List<Restaurant> _restaurantList = isPopular ? restController.popularRestaurantList : restController.latestRestaurantList;
      ScrollController _scrollController = ScrollController();
      return (_restaurantList != null && _restaurantList.length == 0) ? SizedBox() : Column(
        children: [
          Padding(
            padding: EdgeInsets.fromLTRB(10, isPopular ? 2 : 15, 10, 10),
            child: TitleWidget(
              title: isPopular ? 'popular_restaurants'.tr : '${'new_on'.tr} ${AppConstants.APP_NAME}',
              onTap: () => Get.toNamed(RouteHelper.getAllRestaurantRoute(isPopular ? 'popular' : 'latest')),
            ),
          ),

          SizedBox(
            height: 230,
            child: _restaurantList != null ? ListView.builder(
              controller: _scrollController,
              physics: BouncingScrollPhysics(),
              scrollDirection: Axis.horizontal,
              padding: EdgeInsets.only(left: Dimensions.PADDING_SIZE_SMALL),
              itemCount: _restaurantList.length > 10 ? 10 : _restaurantList.length,
              itemBuilder: (context, index){
                return Padding(
                  padding: EdgeInsets.only(right: Dimensions.PADDING_SIZE_SMALL, bottom: 5),
                  child: InkWell(
                    onTap: () {
                      Get.toNamed(
                        RouteHelper.getRestaurantRoute(_restaurantList[index].id),
                        arguments: RestaurantScreen(restaurant: _restaurantList[index]),
                      );
                    },
                    child: Container(
                      height: 230,
                      width: 240,
                      decoration: BoxDecoration(
                        //color: Theme.of(context).cardColor,
                        borderRadius: BorderRadius.circular(Dimensions.RADIUS_SMALL),
                        // boxShadow: [BoxShadow(
                        //   color: Colors.grey[Get.find<ThemeController>().darkTheme ? 700 : 300],
                        //   blurRadius: 5, spreadRadius: 1,
                        // )],
                      ),
                      child: Column(crossAxisAlignment: CrossAxisAlignment.start, mainAxisAlignment: MainAxisAlignment.center, children: [

                        Stack(children: [
                          ClipRRect(
                            borderRadius: BorderRadius.vertical(top: Radius.circular(Dimensions.RADIUS_SMALL)),
                            child: CustomImage(
                              image: '${Get.find<SplashController>().configModel.baseUrls.restaurantCoverPhotoUrl}'
                                  '/${_restaurantList[index].coverPhoto}',
                              height: 150, width: 240, fit: BoxFit.cover,
                            ),
                          ),
                          DiscountTag(
                            discount: _restaurantList[index].discount != null
                                ? _restaurantList[index].discount.discount : 0,
                            discountType: 'percent', freeDelivery: _restaurantList[index].freeDelivery,
                          ),
                          restController.isOpenNow(_restaurantList[index]) ? SizedBox() : NotAvailableWidget(isRestaurant: true),
                          Positioned(
                            top: Dimensions.PADDING_SIZE_EXTRA_SMALL, right: Dimensions.PADDING_SIZE_EXTRA_SMALL,
                            child: GetBuilder<WishListController>(builder: (wishController) {
                              bool _isWished = wishController.wishRestIdList.contains(_restaurantList[index].id);
                              return InkWell(
                                onTap: () {
                                  if(Get.find<AuthController>().isLoggedIn()) {
                                    _isWished ? wishController.removeFromWishList(_restaurantList[index].id, true)
                                        : wishController.addToWishList(null, _restaurantList[index], true);
                                  }else {
                                    showCustomSnackBar('you_are_not_logged_in'.tr);
                                  }
                                },
                                child: Container(
                                  padding: EdgeInsets.all(Dimensions.PADDING_SIZE_EXTRA_SMALL),
                                  decoration: BoxDecoration(
                                    color: Theme.of(context).cardColor, borderRadius: BorderRadius.circular(Dimensions.RADIUS_SMALL),
                                  ),
                                  child: Icon(
                                    _isWished ? Icons.favorite : Icons.favorite_border,  size: 15,
                                    color: _isWished ? Theme.of(context).primaryColor : Theme.of(context).disabledColor,
                                  ),
                                ),
                              );
                            }),
                          ),

                          Positioned(top: 40, child: Container(
                            margin: EdgeInsets.all(0),

                            decoration: BoxDecoration(
                                color: Color(0xffEF7822),
                                border: Border.all(
                                  color: Color(0xffEF7822),
                                  //color: Colors.red[500],
                                ),
                                borderRadius: BorderRadius.only(topRight: Radius.circular(50),bottomRight: Radius.circular(50))
                            ),
                            padding: EdgeInsets.only(left: 5,right: 5,bottom: 3,top: 3),
                            child: Text('VOUCHER: PH200',style: TextStyle(color: Colors.white,fontSize: 10),),

                          )
                          ),

                          Positioned(top: 70, child: Container(
                            margin: EdgeInsets.all(0),

                            decoration: BoxDecoration(
                                color: Color(0xffEF7822),
                                border: Border.all(
                                  color: Color(0xffEF7822),
                                  //color: Colors.red[500],
                                ),
                                borderRadius: BorderRadius.only(topRight: Radius.circular(50),bottomRight: Radius.circular(50))
                            ),
                            padding: EdgeInsets.only(left: 5,right: 5,bottom: 3,top: 3),
                            child: Text('WELCOME GIFT: FREE DELIVERY',style: TextStyle(color: Colors.white,fontSize: 10),),

                          )
                          ),

                          Positioned(bottom: 0.0, child: Container(
                            margin: EdgeInsets.all(5),

                              decoration: BoxDecoration(
                                color: Colors.white,
                                  border: Border.all(
                                    color: Colors.white,
                                    //color: Colors.red[500],
                                  ),
                                  borderRadius: BorderRadius.all(Radius.circular(50))
                              ),
                            padding: EdgeInsets.only(left: 5,right: 5,bottom: 3,top: 3),
                            child: Text('40 min',style: TextStyle(color: Colors.black,fontSize: 10),),
                             
                          )
                          ),
                        ]),

                        Expanded(
                          child: Padding(
                            padding: EdgeInsets.symmetric(horizontal: Dimensions.PADDING_SIZE_EXTRA_SMALL),
                            child: Column(crossAxisAlignment: CrossAxisAlignment.start, mainAxisAlignment: MainAxisAlignment.center, children: [
                              Text(
                                _restaurantList[index].name,
                                style: robotoMedium.copyWith(fontSize: Dimensions.fontSizeLarge),
                                maxLines: 1, overflow: TextOverflow.ellipsis,
                              ),

                              SizedBox(height: 5,),

                              Text(
                                _restaurantList[index].address ?? '',
                                style: robotoMedium.copyWith(fontSize: Dimensions.fontSizeExtraSmall, color: Theme.of(context).disabledColor),
                                maxLines: 1, overflow: TextOverflow.ellipsis,
                              ),
                              SizedBox(height: 5,),
                              RatingBar(
                                rating: _restaurantList[index].avgRating,
                                ratingCount: _restaurantList[index].ratingCount,
                                size: 12,
                              ),
                            ]),
                          ),
                        ),

                      ]),
                    ),
                  ),
                );
              },
            ) : PopularRestaurantShimmer(restController: restController),
          ),
        ],
      );
    });
  }
}

class PopularRestaurantShimmer extends StatelessWidget {
  final RestaurantController restController;
  PopularRestaurantShimmer({@required this.restController});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      physics: BouncingScrollPhysics(),
      scrollDirection: Axis.horizontal,
      padding: EdgeInsets.only(left: Dimensions.PADDING_SIZE_SMALL),
      itemCount: 10,
      itemBuilder: (context, index){
        return Container(
          height: 150,
          width: 200,
          margin: EdgeInsets.only(right: Dimensions.PADDING_SIZE_SMALL, bottom: 5),
          decoration: BoxDecoration(
              color: Theme.of(context).cardColor,
              borderRadius: BorderRadius.circular(Dimensions.RADIUS_SMALL),
              boxShadow: [BoxShadow(color: Colors.grey[Get.find<ThemeController>().darkTheme ? 700 : 300], blurRadius: 10, spreadRadius: 1)]
          ),
          child: Shimmer(
            duration: Duration(seconds: 2),
            child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [

              Container(
                height: 90, width: 200,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.vertical(top: Radius.circular(Dimensions.RADIUS_SMALL)),
                    color: Colors.grey[Get.find<ThemeController>().darkTheme ? 700 : 300]
                ),
              ),

              Expanded(
                child: Padding(
                  padding: EdgeInsets.all(Dimensions.PADDING_SIZE_EXTRA_SMALL),
                  child: Column(crossAxisAlignment: CrossAxisAlignment.start, mainAxisAlignment: MainAxisAlignment.center, children: [
                    Container(height: 10, width: 100, color: Colors.grey[Get.find<ThemeController>().darkTheme ? 700 : 300]),
                    SizedBox(height: 5),

                    Container(height: 10, width: 130, color: Colors.grey[Get.find<ThemeController>().darkTheme ? 700 : 300]),
                    SizedBox(height: 5),

                    RatingBar(rating: 0.0, size: 12, ratingCount: 0),
                  ]),
                ),
              ),

            ]),
          ),
        );
      },
    );
  }
}

