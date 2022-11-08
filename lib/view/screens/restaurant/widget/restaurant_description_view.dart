import 'package:efood_multivendor/controller/auth_controller.dart';
import 'package:efood_multivendor/controller/restaurant_controller.dart';
import 'package:efood_multivendor/controller/splash_controller.dart';
import 'package:efood_multivendor/controller/wishlist_controller.dart';
import 'package:efood_multivendor/data/model/response/address_model.dart';
import 'package:efood_multivendor/data/model/response/distance_model.dart';
import 'package:efood_multivendor/data/model/response/restaurant_model.dart';
import 'package:efood_multivendor/helper/price_converter.dart';
import 'package:efood_multivendor/helper/responsive_helper.dart';
import 'package:efood_multivendor/helper/route_helper.dart';
import 'package:efood_multivendor/util/dimensions.dart';
import 'package:efood_multivendor/util/styles.dart';
import 'package:efood_multivendor/view/base/custom_image.dart';
import 'package:efood_multivendor/view/base/custom_snackbar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../base/rating_bar.dart';

class RestaurantDescriptionView extends StatelessWidget {
  final Restaurant restaurant;

  RestaurantDescriptionView({@required this.restaurant});

  @override
  Widget build(BuildContext context) {
    String address = restaurant.address;
    double minimumShippingCharge = restaurant.minimumShippingCharge;
    double perKmShippingCharge = restaurant.perKmShippingCharge;
    bool _isAvailable = Get.find<RestaurantController>().isRestaurantOpenNow(restaurant.active, restaurant.schedules);
    Color _textColor = ResponsiveHelper.isDesktop(context) ? Colors.black : null;

    var catList = Get.find<RestaurantController>().categoryList;

    return Container(
      color: Colors.white,
      child: Column(children: [
        Row(children: [

          // ClipRRect(
          //   borderRadius: BorderRadius.circular(Dimensions.RADIUS_SMALL),
          //   child: Stack(children: [
          //     CustomImage(
          //       image: '${Get.find<SplashController>().configModel.baseUrls.restaurantImageUrl}/${restaurant.logo}',
          //       height: ResponsiveHelper.isDesktop(context) ? 80 : 60, width: ResponsiveHelper.isDesktop(context) ? 100 : 70, fit: BoxFit.cover,
          //     ),
          //     _isAvailable ? SizedBox() : Positioned(
          //       bottom: 0, left: 0, right: 0,
          //       child: Container(
          //         height: 30,
          //         alignment: Alignment.center,
          //         decoration: BoxDecoration(
          //           borderRadius: BorderRadius.vertical(bottom: Radius.circular(Dimensions.RADIUS_SMALL)),
          //           color: Colors.black.withOpacity(0.6),
          //         ),
          //         child: Text(
          //           'closed_now'.tr, textAlign: TextAlign.center,
          //           style: robotoRegular.copyWith(color: Colors.white, fontSize: Dimensions.fontSizeSmall),
          //         ),
          //       ),
          //     ),
          //   ]),
          // ),
          SizedBox(width: Dimensions.PADDING_SIZE_SMALL),
          Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [

            Stack(
              children: [
               Align(
                 alignment: Alignment.topLeft,
                 child: Container(
                   child:Text(
                     restaurant.name, style: robotoMedium.copyWith(fontSize: Dimensions.fontSizeExtraLarge, color: _textColor),
                     maxLines: 1, overflow: TextOverflow.ellipsis,
                   ) ,
                 ),
               ),

                Align(
                  alignment: Alignment.topRight,
                  child:Container(
                    alignment: Alignment.centerRight,
                    width: context.width/3,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                          padding: EdgeInsets.all(7),
                          decoration: BoxDecoration(
                              //color:Colors.deepOrange,
                              borderRadius: BorderRadius.all(Radius.circular(20)),
                            border: Border.all(width: 1,color: Colors.deepOrange)

                          ),
                          child: Row(
                            children: [
                              Icon(
                                Icons.group_add_outlined,
                                size: 20.0,
                                color: Colors.deepOrange,
                              ),
                              SizedBox(width: 10,),
                              Text('Start group order')
                            ],
                          ),
                        ),
                        SizedBox(width: 10,),
                        Text(
                          'Reviews & more', style: robotoMedium.copyWith(fontSize: Dimensions.fontSizeSmall, color: Colors.deepOrange),
                          maxLines: 1, overflow: TextOverflow.ellipsis,
                        ),
                      ],

                    ),
                  ),

                )
              ],
            ),


            SizedBox(height: Dimensions.PADDING_SIZE_DEFAULT),



            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  padding: EdgeInsets.all(5),
                  child: Text(
                    '${restaurant.discount.discount}% Discount', maxLines: 1, overflow: TextOverflow.ellipsis,
                    style: robotoRegular.copyWith(fontSize: Dimensions.fontSizeDefault, color: Colors.white),
                  ),
                  decoration: BoxDecoration(
                      color:Colors.deepOrange,
                      borderRadius: BorderRadius.all(Radius.circular(20))

                  ),
                ),
                SizedBox(width: Dimensions.PADDING_SIZE_DEFAULT),
                RatingBar(
                  // size: 1,
                  rating: restaurant.avgRating ,
                  //ratingCount: restaurant.ratingCount ,
                  ratingCount: 1000 ,
                ),

              ],
            ),

            SizedBox(height: Dimensions.PADDING_SIZE_DEFAULT),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Icon(Icons.currency_bitcoin_outlined,size: 10,color: Colors.deepOrange,),
                //SizedBox(width: 1),
                Icon(Icons.currency_bitcoin_outlined,size: 10,color: Colors.deepOrange,),
                //SizedBox(width: 1),
                Icon(Icons.currency_bitcoin_outlined,size: 10,color: Colors.deepOrange,),
                SizedBox(width: 10),

                Flexible(
                  child: Container(
                    alignment: Alignment.centerLeft,

                    height: 50,
                    child: ListView.builder(
                      shrinkWrap: false,
                      itemCount: restaurant.categoryIds.length,
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context, i) {
                        return Container(
                          child: Text('jdfh'),
                        );

                      },
                    )
                  ),
                )


              ],
            ),

            SizedBox(height: Dimensions.PADDING_SIZE_DEFAULT),
            Container(
              height: 0.5,
              color: Colors.grey.withOpacity(0.5),
            ),

            Container(
              margin: EdgeInsets.fromLTRB(50, 50, 50, 50),
              child: Row(
                children: [
                  Flexible(child: Container(
                    decoration: BoxDecoration(
                      color: Colors.grey,
                        borderRadius: BorderRadius.all(Radius.circular(5))
                    ),
                    padding: EdgeInsets.all(15),
                    child: Row(
                      children: [

                      ],
                    )
                  ))
                ],
              ),
            ),
            
            SizedBox(height: Dimensions.PADDING_SIZE_DEFAULT),


            // SizedBox(height: Dimensions.PADDING_SIZE_DEFAULT),
            //
            //
            // Text(
            //   '0.3 km | tk ${minimumShippingCharge} minimum', maxLines: 1, overflow: TextOverflow.ellipsis,
            //   style: robotoRegular.copyWith(fontSize: Dimensions.fontSizeSmall, color: Theme.of(context).disabledColor),
            // ),
            // SizedBox(height: Dimensions.PADDING_SIZE_DEFAULT),


            // SizedBox(height: ResponsiveHelper.isDesktop(context) ? Dimensions.PADDING_SIZE_EXTRA_SMALL : 0),
            // Row(children: [
            //   Text('minimum_order'.tr, style: robotoRegular.copyWith(
            //     fontSize: Dimensions.fontSizeExtraSmall, color: Theme.of(context).disabledColor,
            //   )),
            //   SizedBox(width: Dimensions.PADDING_SIZE_EXTRA_SMALL),
            //   Text(
            //     PriceConverter.convertPrice(restaurant.minimumOrder),
            //     style: robotoMedium.copyWith(fontSize: Dimensions.fontSizeExtraSmall, color: Theme.of(context).primaryColor),
            //   ),
            // ]),
          ])),

          // SizedBox(width: Dimensions.PADDING_SIZE_SMALL),
          //
          // ResponsiveHelper.isDesktop(context) ? InkWell(
          //   onTap: () => Get.toNamed(RouteHelper.getSearchRestaurantProductRoute(restaurant.id)),
          //   child: ResponsiveHelper.isDesktop(context) ? Container(
          //     padding: EdgeInsets.all(Dimensions.PADDING_SIZE_SMALL),
          //     decoration: BoxDecoration(borderRadius: BorderRadius.circular(Dimensions.RADIUS_DEFAULT), color: Theme.of(context).primaryColor),
          //     child: Center(child: Icon(Icons.search, color: Colors.white)),
          //   ) : Icon(Icons.search, color: Theme.of(context).primaryColor),
          // ) : SizedBox(),
          // SizedBox(width: ResponsiveHelper.isDesktop(context) ? Dimensions.PADDING_SIZE_SMALL : 0),
          //
          // GetBuilder<WishListController>(builder: (wishController) {
          //   bool _isWished = wishController.wishRestIdList.contains(restaurant.id);
          //   return InkWell(
          //       onTap: () {
          //         if(Get.find<AuthController>().isLoggedIn()) {
          //           _isWished ? wishController.removeFromWishList(restaurant.id, true)
          //               : wishController.addToWishList(null, restaurant, true);
          //         }else {
          //           showCustomSnackBar('you_are_not_logged_in'.tr);
          //         }
          //       },
          //       // child: ResponsiveHelper.isDesktop(context) ? Container(
          //       //   padding: EdgeInsets.all(Dimensions.PADDING_SIZE_SMALL),
          //       //   decoration: BoxDecoration(borderRadius: BorderRadius.circular(Dimensions.RADIUS_DEFAULT), color: Theme.of(context).primaryColor),
          //       //   child: Center(child: Icon(_isWished ? Icons.favorite : Icons.favorite_border, color: Colors.white)),
          //       // ) :Icon(
          //       //   _isWished ? Icons.favorite : Icons.favorite_border,
          //       //   color: _isWished ? Theme.of(context).primaryColor : Theme.of(context).disabledColor,
          //       // ),
          //
          //       child: ResponsiveHelper.isDesktop(context) ? Container(
          //         padding: EdgeInsets.all(Dimensions.PADDING_SIZE_SMALL),
          //         decoration: BoxDecoration(borderRadius: BorderRadius.circular(Dimensions.RADIUS_DEFAULT), color: Theme.of(context).primaryColor),
          //         child: Center(child: Icon(_isWished ? Icons.favorite : Icons.favorite_border, color: Colors.white)),
          //       ) :Text('Reviews & more',style: TextStyle(color: Colors.orange,fontSize: 10,fontWeight: FontWeight.bold),)
          //
          //   );
          // }),

        ]),
        // SizedBox(height: ResponsiveHelper.isDesktop(context) ? 30 : Dimensions.PADDING_SIZE_SMALL),

        // Row(children: [
        //   //Expanded(child: SizedBox()),
        //   // InkWell(
        //   //   onTap: () => Get.toNamed(RouteHelper.getRestaurantReviewRoute(restaurant.id)),
        //   //   child: Column(children: [
        //   //     Row(children: [
        //   //       Icon(Icons.star, color: Theme.of(context).primaryColor, size: 20),
        //   //       SizedBox(width: Dimensions.PADDING_SIZE_EXTRA_SMALL),
        //   //       Text(
        //   //         restaurant.avgRating.toStringAsFixed(1),
        //   //         style: robotoMedium.copyWith(fontSize: Dimensions.fontSizeSmall, color: _textColor),
        //   //       ),
        //   //     ]),
        //   //     SizedBox(width: Dimensions.PADDING_SIZE_EXTRA_SMALL),
        //   //     Text(
        //   //       '${restaurant.ratingCount} ${'ratings'.tr}',
        //   //       style: robotoRegular.copyWith(fontSize: Dimensions.fontSizeSmall, color: _textColor),
        //   //     ),
        //   //   ]),
        //   // ),
        //   //Expanded(child: SizedBox()),
        //   // InkWell(
        //   //   onTap: () => Get.toNamed(RouteHelper.getMapRoute(
        //   //     AddressModel(
        //   //       id: restaurant.id, address: restaurant.address, latitude: restaurant.latitude,
        //   //       longitude: restaurant.longitude, contactPersonNumber: '', contactPersonName: '', addressType: '',
        //   //     ), 'restaurant',
        //   //   )),
        //   //   child: Column(children: [
        //   //     Icon(Icons.location_on, color: Theme.of(context).primaryColor, size: 20),
        //   //     SizedBox(width: Dimensions.PADDING_SIZE_EXTRA_SMALL),
        //   //     Text('location'.tr, style: robotoRegular.copyWith(fontSize: Dimensions.fontSizeSmall, color: _textColor)),
        //   //   ]),
        //   // ),
        //   //Expanded(child: SizedBox()),
        //   // Column(children: [
        //   //   Stack(
        //   //     children: [
        //   //       Align(alignment: Alignment.bottomLeft,
        //   //           child:Column(
        //   //             children: [
        //   //               Row(
        //   //                   children: [
        //   //                 Icon(Icons.watch_later_outlined, color: Theme.of(context).primaryColor, size: 20),
        //   //                 SizedBox(width: Dimensions.PADDING_SIZE_EXTRA_SMALL),
        //   //                 Text(
        //   //                   'Delivery: ${restaurant.deliveryTime} ${'min'.tr}',
        //   //                   style: robotoMedium.copyWith(fontSize: Dimensions.fontSizeSmall, color: _textColor),
        //   //                 ),
        //   //               ]),
        //   //               SizedBox(height: 10,),
        //   //               Text(
        //   //                 '${address} ${''}',
        //   //                 style: robotoMedium.copyWith(fontSize: Dimensions.fontSizeSmall, color: _textColor,),
        //   //               ),
        //   //             ],
        //   //           )
        //   //
        //   //
        //   //       ),
        //   //
        //   //       // Align(alignment: Alignment.bottomRight,
        //   //       //     child:Row(children: [
        //   //       //       Icon(Icons.watch_later_outlined, color: Theme.of(context).primaryColor, size: 20),
        //   //       //       SizedBox(width: Dimensions.PADDING_SIZE_EXTRA_SMALL),
        //   //       //       Text(
        //   //       //         'Delivery: ${restaurant.deliveryTime} ${'min'.tr}',
        //   //       //         style: robotoMedium.copyWith(fontSize: Dimensions.fontSizeSmall, color: _textColor),
        //   //       //       ),
        //   //       //     ])
        //   //       // ),
        //   //     ],
        //   //   ),
        //   //
        //   //   // SizedBox(width: Dimensions.PADDING_SIZE_EXTRA_SMALL),
        //   //   // Text('delivery_time'.tr, style: robotoRegular.copyWith(fontSize: Dimensions.fontSizeSmall, color: _textColor)),
        //   // ]),
        //   // (restaurant.delivery && restaurant.freeDelivery) ? Expanded(child: SizedBox()) : SizedBox(),
        //   // (restaurant.delivery && restaurant.freeDelivery) ? Column(children: [
        //   //   Icon(Icons.money_off, color: Theme.of(context).primaryColor, size: 20),
        //   //   SizedBox(width: Dimensions.PADDING_SIZE_EXTRA_SMALL),
        //   //   Text('free_delivery'.tr, style: robotoRegular.copyWith(fontSize: Dimensions.fontSizeSmall, color: _textColor)),
        //   // ]) : SizedBox(),
        //   // Expanded(child: SizedBox()),
        //
        //
        // ]),



      ]),
    );
  }
}
