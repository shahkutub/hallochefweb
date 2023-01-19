
import 'package:efood_multivendor/data/model/response/language_model.dart';
import 'package:efood_multivendor/util/images.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_google_places_web/flutter_google_places_web.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:social_login_buttons/social_login_buttons.dart';

import '../helper/route_helper.dart';
import '../view/screens/dashboard/widget/place_search.dart';

class AppConstants {
  //static const String APP_NAME = 'StackFood';
  static const String APP_NAME = 'HALLO CHEF';
  static const double APP_VERSION = 5.8;

  //static const String BASE_URL = 'https://stackfood-admin.6amtech.com';
  static const String BASE_URL = 'https://api.hallochefco.com';
  //static const String BASE_URL = 'https://app.smartcoderlab.com';
  //static const String BASE_URL = 'https://hallochefco.com';
  static const String CATEGORY_URI = '/api/v1/categories';
  static const String BANNER_URI = '/api/v1/banners';
  static const String RESTAURANT_PRODUCT_URI = '/api/v1/products/latest';
  static const String POPULAR_PRODUCT_URI = '/api/v1/products/popular';
  static const String REVIEWED_PRODUCT_URI = '/api/v1/products/most-reviewed';
  static const String SEARCH_PRODUCT_URI = '/api/v1/products/details/';
  static const String SUB_CATEGORY_URI = '/api/v1/categories/childes/';
  static const String CATEGORY_PRODUCT_URI = '/api/v1/categories/products/';
  static const String CATEGORY_RESTAURANT_URI = '/api/v1/categories/restaurants/';
  static const String CONFIG_URI = '/api/v1/config';
  static const String TRACK_URI = '/api/v1/customer/order/track?order_id=';
  static const String MESSAGE_URI = '/api/v1/customer/message/get';
  static const String FORGET_PASSWORD_URI = '/api/v1/auth/forgot-password';
  static const String VERIFY_TOKEN_URI = '/api/v1/auth/verify-token';
  static const String RESET_PASSWORD_URI = '/api/v1/auth/reset-password';
  static const String VERIFY_PHONE_URI = '/api/v1/auth/verify-phone';
  static const String CHECK_EMAIL_URI = '/api/v1/auth/check-email';
  static const String VERIFY_EMAIL_URI = '/api/v1/auth/verify-email';
  static const String REGISTER_URI = '/api/v1/auth/sign-up';
  static const String LOGIN_URI = '/api/v1/auth/login';
  static const String TOKEN_URI = '/api/v1/customer/cm-firebase-token';
  static const String PLACE_ORDER_URI = '/api/v1/customer/order/place';
  static const String ADDRESS_LIST_URI = '/api/v1/customer/address/list';
  static const String ZONE_URI = '/api/v1/config/get-zone-id';
  static const String REMOVE_ADDRESS_URI = '/api/v1/customer/address/delete?address_id=';
  static const String ADD_ADDRESS_URI = '/api/v1/customer/address/add';
  static const String UPDATE_ADDRESS_URI = '/api/v1/customer/address/update/';
  static const String SET_MENU_URI = '/api/v1/products/set-menu';
  static const String CUSTOMER_INFO_URI = '/api/v1/customer/info';
  static const String COUPON_URI = '/api/v1/coupon/list';
  static const String COUPON_APPLY_URI = '/api/v1/coupon/apply?code=';
  static const String RUNNING_ORDER_LIST_URI = '/api/v1/customer/order/running-orders';
  static const String HISTORY_ORDER_LIST_URI = '/api/v1/customer/order/list';
  static const String ORDER_CANCEL_URI = '/api/v1/customer/order/cancel';
  static const String COD_SWITCH_URL = '/api/v1/customer/order/payment-method';
  static const String ORDER_DETAILS_URI = '/api/v1/customer/order/details?order_id=';
  static const String WISH_LIST_GET_URI = '/api/v1/customer/wish-list';
  static const String ADD_WISH_LIST_URI = '/api/v1/customer/wish-list/add?';
  static const String REMOVE_WISH_LIST_URI = '/api/v1/customer/wish-list/remove?';
  static const String NOTIFICATION_URI = '/api/v1/customer/notifications';
  static const String UPDATE_PROFILE_URI = '/api/v1/customer/update-profile';
  static const String SEARCH_URI = '/api/v1/';
  static const String REVIEW_URI = '/api/v1/products/reviews/submit';
  static const String PRODUCT_DETAILS_URI = '/api/v1/products/details/';
  static const String LAST_LOCATION_URI = '/api/v1/delivery-man/last-location?order_id=';
  static const String DELIVER_MAN_REVIEW_URI = '/api/v1/delivery-man/reviews/submit';
  static const String RESTAURANT_URI = '/api/v1/restaurants/get-restaurants';
  static const String POPULAR_RESTAURANT_URI = '/api/v1/restaurants/popular';
  static const String LATEST_RESTAURANT_URI = '/api/v1/restaurants/latest';
  static const String RESTAURANT_DETAILS_URI = '/api/v1/restaurants/details/';
  static const String BASIC_CAMPAIGN_URI = '/api/v1/campaigns/basic';
  static const String ITEM_CAMPAIGN_URI = '/api/v1/campaigns/item';
  static const String BASIC_CAMPAIGN_DETAILS_URI = '/api/v1/campaigns/basic-campaign-details?basic_campaign_id=';
  static const String INTEREST_URI = '/api/v1/customer/update-interest';
  static const String SUGGESTED_FOOD_URI = '/api/v1/customer/suggested-foods';
  static const String RESTAURANT_REVIEW_URI = '/api/v1/restaurants/reviews';
  static const String DISTANCE_MATRIX_URI = '/api/v1/config/distance-api';
  static const String SEARCH_LOCATION_URI = '/api/v1/config/place-api-autocomplete';
  static const String PLACE_DETAILS_URI = '/api/v1/config/place-api-details';
  static const String GEOCODE_URI = '/api/v1/config/geocode-api';
  static const String SOCIAL_LOGIN_URL = '/api/v1/auth/social-login';
  static const String SOCIAL_REGISTER_URL = '/api/v1/auth/social-register';
  static const String UPDATE_ZONE_URL = '/api/v1/customer/update-zone';
  static const String WALLET_TRANSACTION_URL = '/api/v1/customer/wallet/transactions';
  static const String LOYALTY_TRANSACTION_URL = '/api/v1/customer/loyalty-point/transactions';
  static const String LOYALTY_POINT_TRANSFER_URL = '/api/v1/customer/loyalty-point/point-transfer';
  static const String CUSTOMER_REMOVE = '/api/v1/customer/remove-account';
  static const String CONVERSATION_LIST_URI = '/api/v1/customer/message/list';
  static const String SEARCH_CONVERSATION_LIST_URI = '/api/v1/customer/message/search-list';
  static const String MESSAGE_LIST_URI = '/api/v1/customer/message/details';
  static const String SEND_MESSAGE_URI = '/api/v1/customer/message/send';
  static const String ZONE_LIST_URI = '/api/v1/zone/list';
  static const String RESTAURANT_REGISTER_URI = '/api/v1/auth/vendor/register';
  static const String DM_REGISTER_URI = '/api/v1/auth/delivery-man/store';

  // Shared Key
  static const String THEME = 'theme';
  static const String TOKEN = 'multivendor_token';
  static const String COUNTRY_CODE = 'country_code';
  static const String LANGUAGE_CODE = 'language_code';
  static const String CART_LIST = 'cart_list';
  static const String USER_PASSWORD = 'user_password';
  static const String USER_ADDRESS = 'user_address';
  static const String USER_NUMBER = 'user_number';
  static const String USER_COUNTRY_CODE = 'user_country_code';
  static const String NOTIFICATION = 'notification';
  static const String SEARCH_HISTORY = 'search_history';
  static const String INTRO = 'intro';
  static const String NOTIFICATION_COUNT = 'notification_count';
  static const String TOPIC = 'all_zone_customer';
  static const String ZONE_ID = 'zoneId';
  static const String LOCALIZATION_KEY = 'X-localization';

  // Delivery Tips
  static List<int> tips = [0, 5, 10, 15, 20, 30, 50];

  //Order Status
  static const String PENDING = 'pending';
  static const String ACCEPTED = 'accepted';
  static const String PROCESSING = 'processing';
  static const String CONFIRMED = 'confirmed';
  static const String HANDOVER = 'handover';
  static const String PICKED_UP = 'picked_up';

  // Delivery Type
  static const String DELIVERY = 'delivery';
  static const String TAKE_AWAY = 'take_away';

  //Preference Day
  static List<String> preferenceDays = ['today', 'tomorrow'];


  static List<LanguageModel> languages = [
    LanguageModel(imageUrl: Images.english, languageName: 'English', countryCode: 'US', languageCode: 'en'),
    LanguageModel(imageUrl: Images.arabic, languageName: 'عربى', countryCode: 'SA', languageCode: 'ar'),
  ];

  static String pagename = '';

  static showDialogLogin(BuildContext context) {

    showGeneralDialog(
        context: context,
        barrierDismissible: true,
        barrierLabel: MaterialLocalizations.of(context)
            .modalBarrierDismissLabel,
        barrierColor: Colors.black45,
        transitionDuration: const Duration(milliseconds: 200),
        pageBuilder: (BuildContext buildContext,
            Animation animation,
            Animation secondaryAnimation) {
          return
            Center(
              child: Container(

                width: MediaQuery.of(context).size.width -800,
                height: MediaQuery.of(context).size.height -100,
                padding: EdgeInsets.fromLTRB(120,0,120,0),
                color: Colors.white,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [

                    SizedBox(height: 20,),
                    SocialLoginButton(
                      buttonType: SocialLoginButtonType.facebook,
                      onPressed: () {},
                    ),
                    SizedBox(height: 40,),

                    SocialLoginButton(
                      // backgroundColor: Colors.indigo,
                      buttonType: SocialLoginButtonType.google,
                      onPressed: () {},
                    ),

                    SizedBox(height: 40,),

                    SocialLoginButton(
                      buttonType: SocialLoginButtonType.generalLogin,
                      onPressed: () {
                        Get.toNamed(RouteHelper.getSignInRoute(RouteHelper.main));
                      },
                    ),


                    SizedBox(height: 20,),

                    Material(
                      child: InkWell(
                        onTap: (){
                          Get.toNamed(RouteHelper.getSignUpRoute());
                        },
                        child: Image.asset(Images.signupbtn),
                      ),
                    ),

                    SizedBox(height: 20,),
                    // Material(
                    //   child:InkWell(
                    //     onTap: () {}, // Handle your callback.
                    //     splashColor: Colors.brown.withOpacity(0.5),
                    //     child: Ink(
                    //        height: 70,
                    //       width: 200,
                    //       decoration: BoxDecoration(
                    //         image: DecorationImage(
                    //           image: AssetImage(Images.signupbtn),
                    //           fit: BoxFit.fill,
                    //         ),
                    //       ),
                    //     ),
                    //   )
                    // ),


                    // IconButton(
                    //   icon: Image.asset(Images.signupbtn),
                    //   //iconSize: 50,
                    //   onPressed: () {},
                    // ),
                    //Image.asset(Images.signupbtn),

                    // InkWell(
                    //   child: Image.asset(Images.signupbtn),
                    // )


                    //SignInButtonScreen(),

                    // TextButton(
                    //   style: ButtonStyle(backgroundColor: MaterialStateProperty.all(Colors.blue)),
                    //
                    //   onPressed: () {
                    //     Navigator.of(context).pop();
                    //   },
                    //   child: Text(
                    //     "Cancel",
                    //     style: TextStyle(color: Colors.white),
                    //   ),
                    //   //color: const Color(0xFF1BC0C5),
                    // )
                  ],
                ),
              ),
            );
        });

  }

  static showDialogWhenAsap(BuildContext context) {
    var _selectedDay ='';

    List<String> _daylist = [] ;
    var now = DateTime.now();
    print(DateFormat().format(now)); // This will return date using the default locale
    print('Current date: '+DateFormat('EEE, MMM d').format(now));
    final tomorrow = DateTime(now.year, now.month, now.day + 1);
    print('tomorrow date: '+DateFormat('EEE, MMM d').format(tomorrow));

    final aftertomorrow = DateTime(tomorrow.year, tomorrow.month, tomorrow.day + 1);
    print('aftertomorrow date: '+DateFormat('EEE, MMM d').format(aftertomorrow));

    _selectedDay = DateFormat('EEE, MMM d').format(now).toString();
    _daylist.add(DateFormat('EEE, MMM d').format(now).toString());
    _daylist.add(DateFormat('EEE, MMM d').format(tomorrow).toString());
    _daylist.add(DateFormat('EEE, MMM d').format(aftertomorrow).toString());


    showGeneralDialog(
        context: context,
        barrierDismissible: true,
        barrierLabel: MaterialLocalizations.of(context)
            .modalBarrierDismissLabel,
        barrierColor: Colors.black45,
        transitionDuration: const Duration(milliseconds: 200),
        pageBuilder: (BuildContext buildContext,
            Animation animation,

            Animation secondaryAnimation) {

          double width = MediaQuery.of(context).size.width / 3;

          List<String> times =  [];
          times.add('ASAP');
          times.add('10:30 PM');
          times.add('10:45 PM');
          times.add('11:00 PM');
          times.add('11:15 PM');
          times.add('11:30 PM');
          times.add('11:45 PM');

          return
            //Card(

            //child:
              Center(
              child: Container(

                width: MediaQuery.of(context).size.width / 3,
                height: MediaQuery.of(context).size.height -170,
               // padding: EdgeInsets.fromLTRB(10,0,10,0),
                margin: EdgeInsets.fromLTRB(MediaQuery.of(context).size.width / 2,0,0,0),
                color: Colors.white,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [

                    SizedBox(height: 20,),

                    Container(
                      height: 80,
                     // width: 70,
                      child: ListView.builder(
                        shrinkWrap: true,
                        scrollDirection: Axis.horizontal,
                        itemCount: _daylist.length,
                        itemBuilder: (BuildContext context, int index) =>

                            GestureDetector(
                              onTap: (){

                              },
                              child:Container(
                                margin: EdgeInsets.all(10),
                                alignment: Alignment.center,
                                height: 80,
                                width: 80,
                                decoration: BoxDecoration(
                                    color: Colors.red,
                                    border: Border.all(
                                      color: Colors.red[500],
                                    ),
                                    borderRadius: BorderRadius.circular(10)
                                ),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Text(''+_daylist[index],style: TextStyle(color: Colors.white,fontSize: 12,decoration: TextDecoration.none),),
                                    SizedBox(height: 5,),
                                    Text('4',style: TextStyle(color: Colors.white,fontSize: 15,decoration: TextDecoration.none),),
                                  ],
                                ),
                              ),
                            ),
                      ),
                    ),


                    SizedBox(height: 40,),

                    Container(
                      margin: EdgeInsets.only(left: 15,right: 15),
                      height: 1,
                      width: MediaQuery.of(context).size.width / 3,
                      color: Color(0xffEBEBEB),
                    ),

                    Expanded(child: ListView.builder(
                        itemCount: times.length,
                        itemBuilder: (BuildContext context, int index) {
                          String data = times[index].toString();
                          return Container(
                            margin: EdgeInsets.all(10),
                            alignment: Alignment.center,
                            width: width,
                            child: Text(''+data,style: TextStyle(fontSize: 15,color: Colors.black,decoration: TextDecoration.none),),
                              );
                        }),)


                  ],
                ),
              ),
            )
          //)
          ;
        });

  }

  static showDialogPlaceSearch(BuildContext context) {

    showGeneralDialog(
        context: context,
        barrierDismissible: true,
        barrierLabel: MaterialLocalizations.of(context)
            .modalBarrierDismissLabel,
        barrierColor: Colors.black45,
        transitionDuration: const Duration(milliseconds: 200),
        pageBuilder: (BuildContext buildContext,
            Animation animation,

            Animation secondaryAnimation) {

          // double width = MediaQuery.of(context).size.width / 3;
          //
          // List<String> times =  [];
          // times.add('ASAP');
          // times.add('10:30 PM');
          // times.add('10:45 PM');
          // times.add('11:00 PM');
          // times.add('11:15 PM');
          // times.add('11:30 PM');
          // times.add('11:45 PM');

          return
          Scaffold(
            body: FlutterGooglePlacesWeb(
              apiKey: 'AIzaSyD_7sI26H4jmNN9Wjp8ElwiLITT9U5_rWg',
              proxyURL: 'https://cors-anywhere.herokuapp.com/',
              components: 'us',
              required: true,
            ),
          );
        });

  }

}
