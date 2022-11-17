import 'dart:async';
import 'dart:collection';
import 'dart:typed_data';
import 'dart:ui';

import 'package:efood_multivendor/controller/location_controller.dart';
import 'package:efood_multivendor/controller/order_controller.dart';
import 'package:efood_multivendor/data/model/body/notification_body.dart';
import 'package:efood_multivendor/data/model/response/address_model.dart';
import 'package:efood_multivendor/data/model/response/conversation_model.dart';
import 'package:efood_multivendor/data/model/response/order_model.dart';
import 'package:efood_multivendor/data/model/response/restaurant_model.dart';
import 'package:efood_multivendor/helper/responsive_helper.dart';
import 'package:efood_multivendor/helper/route_helper.dart';
import 'package:efood_multivendor/util/dimensions.dart';
import 'package:efood_multivendor/util/images.dart';
import 'package:efood_multivendor/view/base/custom_app_bar.dart';
import 'package:efood_multivendor/view/screens/cart/widget/cart_widget_check_out.dart';
import 'package:efood_multivendor/view/screens/order/widget/track_details_view.dart';
import 'package:efood_multivendor/view/screens/order/widget/tracking_stepper_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../../data/model/body/place_order_body.dart';
import '../../../data/model/response/cart_model.dart';
import '../../../util/styles.dart';
import '../../base/custom_image.dart';
import '../cart/widget/cart_widget_delivery.dart';

class NewOrderTrackingScreen extends StatefulWidget {
  final String orderID;
  final  PlaceOrderBody orderData;
  final List<CartModel> cartList;
  NewOrderTrackingScreen({@required this.orderID,@required this.orderData,@required this.cartList});

  @override
  _OrderTrackingScreenState createState() => _OrderTrackingScreenState();
}

class _OrderTrackingScreenState extends State<NewOrderTrackingScreen> with WidgetsBindingObserver {
  GoogleMapController _controller;
  bool _isLoading = true;
  Set<Marker> _markers = HashSet<Marker>();

  bool isArrowUp = false;

   TextEditingController _text;

  void _loadData() async {
    await Get.find<LocationController>().getCurrentLocation(true, notify: false, defaultLatLng: LatLng(
      double.parse(Get.find<LocationController>().getUserAddress().latitude),
      double.parse(Get.find<LocationController>().getUserAddress().longitude),
    ));
    Get.find<OrderController>().trackOrder(widget.orderID, null, true);
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);

    _loadData();
    // Get.find<OrderController>().callTrackOrderApi(orderModel: Get.find<OrderController>().trackModel, orderId: widget.orderID.toString());
  }

  @override
  void didChangeAppLifecycleState(final AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      Get.find<OrderController>().callTrackOrderApi(orderModel: Get.find<OrderController>().trackModel, orderId: widget.orderID.toString());
    }else if(state == AppLifecycleState.paused){
      Get.find<OrderController>().cancelTimer();
    }
  }

  @override
  void dispose() {
    super.dispose();
    _controller?.dispose();
    Get.find<OrderController>().cancelTimer();
    WidgetsBinding.instance.removeObserver(this);
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: CustomAppBar(title: 'order_tracking'.tr),
      body: GetBuilder<OrderController>(builder: (orderController) {
        OrderModel _track;
        if(orderController.trackModel != null) {
          _track = orderController.trackModel;

          print('orderStatus: '+_track.orderStatus);

          /*if(_controller != null && GetPlatform.isWeb) {
            if(_track.deliveryAddress != null) {
              _controller.showMarkerInfoWindow(MarkerId('destination'));
            }
            if(_track.restaurant != null) {
              _controller.showMarkerInfoWindow(MarkerId('restaurant'));
            }
            if(_track.deliveryMan != null) {
              _controller.showMarkerInfoWindow(MarkerId('delivery_boy'));
            }
          }*/
        }

        return _track != null ?
        Container(
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                    width: width,
                    alignment: Alignment.center,
                    child:Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Card(
                          elevation: 10,
                          child: Container(
                            padding: EdgeInsets.all(20),
                            height: width/3.5,
                            width: width/3.5,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text('Estimated delivery time',style: robotoRegular.copyWith(
                                  color: Color(0xFFE34A28), fontSize: 25,
                                ),),
                                SizedBox(height: 10,),
                                Text(_track.restaurant.deliveryTime+' Min',style: TextStyle(color: Colors.black,fontSize: 35,fontWeight: FontWeight.bold),),


                                SizedBox(height: 10,),
                                Image.asset(Images.delivery_paking,),

                                SizedBox(height: 20,),

                                Row(
                                  children: [
                                    Flexible(child:  LinearProgressIndicator(
                                      minHeight: 5,
                                      backgroundColor: Colors.grey,
                                      valueColor: new AlwaysStoppedAnimation<Color>(Colors.red),
                                    ),flex: 1,),

                                    SizedBox(width: 10,),
                                    Flexible(child:  LinearProgressIndicator(
                                      minHeight: 5,
                                      value: 0,
                                      backgroundColor: Colors.grey,
                                      valueColor: new AlwaysStoppedAnimation<Color>(Colors.red),
                                    ),flex: 1,),
                                    SizedBox(width: 10,),
                                    Flexible(child:  LinearProgressIndicator(
                                      minHeight: 5,
                                      value: 0,
                                      backgroundColor: Colors.grey,
                                      valueColor: new AlwaysStoppedAnimation<Color>(Colors.red),
                                    ),flex: 1,),
                                    SizedBox(width: 10,),
                                    Flexible(child:  LinearProgressIndicator(
                                      minHeight: 5,
                                      value: 0,
                                      backgroundColor: Colors.grey,
                                      valueColor: new AlwaysStoppedAnimation<Color>(Colors.red),
                                    ),flex: 1,),
                                  ],
                                ),

                                SizedBox(
                                  height: 20,
                                ),
                                Text('Preparing your food.Your rider will pack it up once it\'s ready.',style: TextStyle(color: Colors.grey,fontSize: 15),),
                              ],
                            ),

                          ),

                        ),
                        SizedBox(width: 10,),
                        Container(
                          height: width/3.5,
                          width: width/3.5,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Card(
                                elevation: 10,
                                child: Container(
                                  padding: EdgeInsets.all(10),
                                  height: width/5.5,
                                  width: width/3.5,
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      SizedBox(height: 10,),
                                      Text('Order Details',style: TextStyle(color: Colors.black,fontSize: 20,fontWeight: FontWeight.bold),),
                                      SizedBox(height: 10,),
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.start,
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [

                                          CustomImage(
                                            image: '',
                                            height: 70, width:  70, fit: BoxFit.cover,
                                            placeholder: Images.foodboul,
                                          ),
                                          SizedBox(width: 10,),
                                          Flexible(
                                            child: Container(
                                                width: width/7,
                                                child:Column(
                                                  mainAxisSize: MainAxisSize.min,
                                                  mainAxisAlignment: MainAxisAlignment.start,
                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                  children: [
                                                    Flexible(
                                                      child:Text(''+widget.cartList[0].product.restaurantName,style: TextStyle(color: Colors.deepOrangeAccent,fontSize: 15,fontWeight: FontWeight.normal),),

                                                    ),
                                                    SizedBox(width: 10,),
                                                    Text('Order Number: #'+widget.orderID,style: TextStyle(color: Colors.grey,fontSize: 10,fontWeight: FontWeight.normal),),

                                                    SizedBox(width: 10,),
                                                    Text('Delivery address',style: TextStyle(color: Colors.grey,fontSize: 10,fontWeight: FontWeight.normal),),

                                                    Text(''+widget.orderData.address,style: TextStyle(color: Colors.black,fontSize: 12,fontWeight: FontWeight.normal),),

                                                    SizedBox(width: 20,),

                                                  ],
                                                )


                                            ),
                                          ),
                                          SizedBox(width: 10,),
                                          Text('Tk '+widget.orderData.orderAmount.toString(),style: TextStyle(color: Colors.black,fontSize: 15,fontWeight: FontWeight.normal),),

                                        ],
                                      ),

                                      SizedBox(height: 20,),
                                      Divider(
                                        height: 1,
                                        color: Colors.grey,
                                      ),

                                      Stack(
                                        children: [
                                          Align(
                                            alignment: Alignment.topLeft,
                                            child: Row(
                                              children: [
                                                Text('Order Details',style: TextStyle(color: Colors.black,fontSize: 15,fontWeight: FontWeight.normal),),
                                                Text('('+widget.cartList.length.toString()+')',style: TextStyle(color: Colors.grey,fontSize: 10,fontWeight: FontWeight.normal),),
                                              ],
                                            ),
                                          ),

                                          Align(
                                            alignment: Alignment.topRight,
                                            child: Flexible(
                                                child: InkWell(

                                                  child:Icon(!isArrowUp?Icons.keyboard_arrow_down : Icons.keyboard_arrow_up,size: 30,color: Colors.deepOrangeAccent,),
                                                  onTap: (){

                                                    setState(() {
                                                      if(!isArrowUp){
                                                        isArrowUp = true;
                                                      }else{
                                                        isArrowUp = false;
                                                      }
                                                    });


                                                  },
                                                )

                                            ),
                                          ),
                                        ],

                                      ),

                                      !isArrowUp? CartWidgetDelivery():SizedBox()

                                    ],
                                  ),
                                ),
                              ),

                              Card(
                                elevation: 10,
                                child: Container(
                                  padding: EdgeInsets.all(10),
                                  height: width/11,
                                  width: width/3.5,
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children: [
                                      SizedBox(height: 10,),
                                      Text('Need Support',style: TextStyle(color: Colors.black,fontSize: 15,fontWeight: FontWeight.bold),),

                                      Text('Question regarding your order ? Reach out to us.'),
                                      SizedBox(height: 10,),

                                      OutlinedButton(

                                        onPressed: () {
                                          showCustomDialog(context);
                                        },
                                        child: Text('Help center'),
                                        style: OutlinedButton.styleFrom(
                                          shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(12),

                                          ),
                                          side: BorderSide(width: 1.0, color: Colors.deepOrangeAccent),
                                        ),
                                      )


                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),


                      ],
                    )
                )

              ],

            ),
          ),
        )
            : Center(child: CircularProgressIndicator());
      }),
    );
  }


  void showCustomDialog(BuildContext context) {
    Dialog errorDialog = Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.0)), //this right here
      child: Container(
        padding: EdgeInsets.all(10.0),
        height: 400.0,
        width: 400.0,

        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Padding(
              padding:  EdgeInsets.all(15.0),
              child: Text('Cool', style: TextStyle(color: Colors.red),),
            ),
            Padding(
              padding: EdgeInsets.all(15.0),
              child: Text('Awesome', style: TextStyle(color: Colors.red),),
            ),
            Padding(padding: EdgeInsets.only(top: 50.0)),
            TextField(
              
             // maxLines: 20,
              controller: _text,
              decoration: InputDecoration(
                
                suffixIcon: IconButton(
                  icon: Icon(Icons.send),
                  onPressed: () {},
                ),
                // Row(
                //   crossAxisAlignment: CrossAxisAlignment.end,
                //   mainAxisSize: MainAxisSize.min,
                //   mainAxisAlignment: MainAxisAlignment.start,
                //   children: [
                //     IconButton(
                //       icon: Icon(Icons.send),
                //       onPressed: () {},
                //     ),
                //     IconButton(
                //       icon: Icon(Icons.image),
                //       onPressed: () {},
                //     ),
                //   ],
                // ),
                border: InputBorder.none,
                hintText: "enter your message",
              ),
            ),
          ],
        ),
      ),
    );
    showDialog(context: context, builder: (BuildContext context) => errorDialog);

  }

    // showGeneralDialog(
    //   context: context,
    //   barrierLabel: "Barrier",
    //   barrierDismissible: true,
    //   barrierColor: Colors.black.withOpacity(0.5),
    //   transitionDuration: Duration(milliseconds: 100),
    //   pageBuilder: (_, __, ___) {
    //     return  Container(
    //       margin: EdgeInsets.fromLTRB(100,60,100,60),
    //         color: Colors.white,
    //
    //           child: Stack(
    //             children: [
    //               Align(
    //                 alignment: Alignment.bottomCenter,
    //                 child: Container(
    //                   height: 50,
    //                   child:  Column(
    //                     children: [
    //                       Divider(height: 0, color: Colors.black26),
    //                       Material(
    //                         child: TextField(
    //                           maxLines: 20,
    //                           controller: _text,
    //                           decoration: InputDecoration(
    //                             suffixIcon: Row(
    //                               crossAxisAlignment: CrossAxisAlignment.end,
    //                               mainAxisSize: MainAxisSize.min,
    //                               mainAxisAlignment: MainAxisAlignment.start,
    //                               children: [
    //                                 IconButton(
    //                                   icon: Icon(Icons.send),
    //                                   onPressed: () {},
    //                                 ),
    //                                 IconButton(
    //                                   icon: Icon(Icons.image),
    //                                   onPressed: () {},
    //                                 ),
    //                               ],
    //                             ),
    //                             border: InputBorder.none,
    //                             hintText: "enter your message",
    //                           ),
    //                         ),
    //                       )
    //                     ],
    //                   ),
    //                 )
    //
    //
    //               )
    //
    //             ],
    //           )
    //     );
    //   },
    //   transitionBuilder: (_, anim, __, child) {
    //     Tween<Offset> tween;
    //     if (anim.status == AnimationStatus.reverse) {
    //       tween = Tween(begin: Offset(-1, 0), end: Offset.zero);
    //     } else {
    //       tween = Tween(begin: Offset(1, 0), end: Offset.zero);
    //     }
    //
    //     return SlideTransition(
    //       position: tween.animate(anim),
    //       child: FadeTransition(
    //         opacity: anim,
    //         child: child,
    //       ),
    //     );
    //   },
    // );
 // }

  void setMarker(Restaurant restaurant, DeliveryMan deliveryMan, AddressModel addressModel, bool takeAway) async {
    try {
      Uint8List restaurantImageData = await convertAssetToUnit8List(Images.restaurant_marker, width: 100);
      Uint8List deliveryBoyImageData = await convertAssetToUnit8List(Images.delivery_man_marker, width: 100);
      Uint8List destinationImageData = await convertAssetToUnit8List(
        takeAway ? Images.my_location_marker : Images.user_marker,
        width: takeAway ? 50 : 100,
      );

      // Animate to coordinate
      LatLngBounds bounds;
      double _rotation = 0;
      if(_controller != null) {
        if (double.parse(addressModel.latitude) < double.parse(restaurant.latitude)) {
          bounds = LatLngBounds(
            southwest: LatLng(double.parse(addressModel.latitude), double.parse(addressModel.longitude)),
            northeast: LatLng(double.parse(restaurant.latitude), double.parse(restaurant.longitude)),
          );
          _rotation = 0;
        }else {
          bounds = LatLngBounds(
            southwest: LatLng(double.parse(restaurant.latitude), double.parse(restaurant.longitude)),
            northeast: LatLng(double.parse(addressModel.latitude), double.parse(addressModel.longitude)),
          );
          _rotation = 180;
        }
      }
      LatLng centerBounds = LatLng(
        (bounds.northeast.latitude + bounds.southwest.latitude)/2,
        (bounds.northeast.longitude + bounds.southwest.longitude)/2,
      );

      _controller.moveCamera(CameraUpdate.newCameraPosition(CameraPosition(target: centerBounds, zoom: GetPlatform.isWeb ? 10 : 17)));
      if(!ResponsiveHelper.isWeb()) {
        zoomToFit(_controller, bounds, centerBounds, padding: 1.5);
      }

      // Marker
      _markers = HashSet<Marker>();
      addressModel != null ? _markers.add(Marker(
        markerId: MarkerId('destination'),
        position: LatLng(double.parse(addressModel.latitude), double.parse(addressModel.longitude)),
        infoWindow: InfoWindow(
          title: 'Destination',
          snippet: addressModel.address,
        ),
        icon: GetPlatform.isWeb ? BitmapDescriptor.defaultMarker : BitmapDescriptor.fromBytes(destinationImageData),
      )) : SizedBox();

      restaurant != null ? _markers.add(Marker(
        markerId: MarkerId('restaurant'),
        position: LatLng(double.parse(restaurant.latitude), double.parse(restaurant.longitude)),
        infoWindow: InfoWindow(
          title: 'restaurant'.tr,
          snippet: restaurant.address,
        ),
        icon: GetPlatform.isWeb ? BitmapDescriptor.defaultMarker : BitmapDescriptor.fromBytes(restaurantImageData),
      )) : SizedBox();

      deliveryMan != null ? _markers.add(Marker(
        markerId: MarkerId('delivery_boy'),
        position: LatLng(double.parse(deliveryMan.lat ?? '0'), double.parse(deliveryMan.lng ?? '0')),
        infoWindow: InfoWindow(
          title: 'delivery_man'.tr,
          snippet: deliveryMan.location,
        ),
        rotation: _rotation,
        icon: GetPlatform.isWeb ? BitmapDescriptor.defaultMarker : BitmapDescriptor.fromBytes(deliveryBoyImageData),
      )) : SizedBox();
    }catch(e) {}
    setState(() {});
  }

  Future<void> zoomToFit(GoogleMapController controller, LatLngBounds bounds, LatLng centerBounds, {double padding = 0.5}) async {
    bool keepZoomingOut = true;

    while(keepZoomingOut) {
      final LatLngBounds screenBounds = await controller.getVisibleRegion();
      if(fits(bounds, screenBounds)){
        keepZoomingOut = false;
        final double zoomLevel = await controller.getZoomLevel() - padding;
        controller.moveCamera(CameraUpdate.newCameraPosition(CameraPosition(
          target: centerBounds,
          zoom: zoomLevel,
        )));
        break;
      }
      else {
        // Zooming out by 0.1 zoom level per iteration
        final double zoomLevel = await controller.getZoomLevel() - 0.1;
        controller.moveCamera(CameraUpdate.newCameraPosition(CameraPosition(
          target: centerBounds,
          zoom: zoomLevel,
        )));
      }
    }
  }

  bool fits(LatLngBounds fitBounds, LatLngBounds screenBounds) {
    final bool northEastLatitudeCheck = screenBounds.northeast.latitude >= fitBounds.northeast.latitude;
    final bool northEastLongitudeCheck = screenBounds.northeast.longitude >= fitBounds.northeast.longitude;

    final bool southWestLatitudeCheck = screenBounds.southwest.latitude <= fitBounds.southwest.latitude;
    final bool southWestLongitudeCheck = screenBounds.southwest.longitude <= fitBounds.southwest.longitude;

    return northEastLatitudeCheck && northEastLongitudeCheck && southWestLatitudeCheck && southWestLongitudeCheck;
  }

  Future<Uint8List> convertAssetToUnit8List(String imagePath, {int width = 50}) async {
    ByteData data = await rootBundle.load(imagePath);
    Codec codec = await instantiateImageCodec(data.buffer.asUint8List(), targetWidth: width);
    FrameInfo fi = await codec.getNextFrame();
    return (await fi.image.toByteData(format: ImageByteFormat.png)).buffer.asUint8List();
  }
}
