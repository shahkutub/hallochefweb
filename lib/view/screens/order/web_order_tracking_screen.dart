
import 'package:efood_multivendor/data/model/response/order_details_model.dart';
import 'package:efood_multivendor/util/images.dart';
import 'package:efood_multivendor/view/base/web_menu_bar.dart';
import 'package:flutter/material.dart';

import '../../../data/model/body/place_order_body.dart';
import '../../../data/model/response/cart_model.dart';
import '../../../data/model/response/order_model.dart';
import '../../../helper/date_converter.dart';
import '../../../util/dimensions.dart';
import '../../../util/styles.dart';
import '../../base/custom_image.dart';
import 'package:efood_multivendor/controller/order_controller.dart';
import 'package:get/get.dart';
class WebOrderTrackingScreen extends StatefulWidget {

  final  PlaceOrderBody orderData;
  final List<CartModel> cartList;
  final String orderID;
  WebOrderTrackingScreen({@required this.orderData,@required this.cartList ,@required this.orderID});

  @override
  _WebOrderTrackingScreenState createState() => _WebOrderTrackingScreenState();

}

class _WebOrderTrackingScreenState extends State<WebOrderTrackingScreen>{
  @override
  Widget build(BuildContext context) {
    
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
            return Scaffold(
              appBar: WebMenuBar(),
              body: GetBuilder<OrderController>(builder: (orderController) {
                double _deliveryCharge = 0;
                double _itemsPrice = 0;
                double _discount = 0;
                double _couponDiscount = 0;
                double _tax = 0;
                double _addOns = 0;
                double _dmTips = 0;
                OrderModel _order = orderController.trackModel;
                if(orderController.orderDetails != null) {
                  if(_order.orderType == 'delivery') {
                    _deliveryCharge = _order.deliveryCharge;
                    _dmTips = _order.dmTips;
                  }
                  _couponDiscount = _order.couponDiscountAmount;
                  _discount = _order.restaurantDiscountAmount;
                  _tax = _order.totalTaxAmount;
                  // for(OrderDetailsModel orderDetails in orderController.orderDetails) {
                  //   for(AddOn addOn in orderDetails.addOns) {
                  //     _addOns = _addOns + (addOn.price * addOn.quantity);
                  //   }
                  //   _itemsPrice = _itemsPrice + (orderDetails.price * orderDetails.quantity);
                  // }
                }
                double _subTotal = _itemsPrice + _addOns;
                double _total = _itemsPrice + _addOns - _discount + _tax + _deliveryCharge - _couponDiscount + _dmTips;


          //       GetBuilder<OrderController>(builder: (orderController) {
          //         OrderModel _track;
          //         if(orderController.trackModel != null) {
          //           _track = orderController.trackModel;
          //
          //           /*if(_controller != null && GetPlatform.isWeb) {
          //   if(_track.deliveryAddress != null) {
          //     _controller.showMarkerInfoWindow(MarkerId('destination'));
          //   }
          //   if(_track.restaurant != null) {
          //     _controller.showMarkerInfoWindow(MarkerId('restaurant'));
          //   }
          //   if(_track.deliveryMan != null) {
          //     _controller.showMarkerInfoWindow(MarkerId('delivery_boy'));
          //   }
          // }*/
          //         }



                return orderController.orderDetails != null ?
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
                                        // Text('Estimated delivery time',style: robotoRegular.copyWith(
                                        //   color: Color(0xFFE34A28), fontSize: 25,
                                        // ),),
                                        // SizedBox(height: 10,),
                                        // Text('15 - 25 Min'+orderDetails.,style: TextStyle(color: Colors.black,fontSize: 35,fontWeight: FontWeight.bold),),

                                        DateConverter.isBeforeTime(_order.scheduleAt) ? (_order.orderStatus != 'delivered' && _order.orderStatus != 'failed'&& _order.orderStatus != 'canceled') ? Column(children: [
                                          ClipRRect(borderRadius: BorderRadius.circular(10), child: Image.asset(Images.animate_delivery_man, fit: BoxFit.contain)),
                                          SizedBox(height: Dimensions.PADDING_SIZE_DEFAULT),

                                          Text('your_food_will_delivered_within'.tr, style: robotoRegular.copyWith(fontSize: Dimensions.fontSizeDefault, color: Theme.of(context).disabledColor)),
                                          SizedBox(height: Dimensions.PADDING_SIZE_EXTRA_SMALL),

                                          Center(
                                            child: Row(mainAxisSize: MainAxisSize.min, children: [

                                              Text(
                                                DateConverter.differenceInMinute(_order.restaurant.deliveryTime, _order.createdAt, _order.processingTime, _order.scheduleAt) < 5 ? '1 - 5'
                                                    : '${DateConverter.differenceInMinute(_order.restaurant.deliveryTime, _order.createdAt, _order.processingTime, _order.scheduleAt)-5} '
                                                    '- ${DateConverter.differenceInMinute(_order.restaurant.deliveryTime, _order.createdAt, _order.processingTime, _order.scheduleAt)}',
                                                style: robotoBold.copyWith(fontSize: Dimensions.fontSizeExtraLarge),
                                              ),
                                              SizedBox(width: Dimensions.PADDING_SIZE_EXTRA_SMALL),

                                              Text('min'.tr, style: robotoMedium.copyWith(fontSize: Dimensions.fontSizeLarge, color: Theme.of(context).primaryColor)),

                                            ]),
                                          ),
                                          SizedBox(height: Dimensions.PADDING_SIZE_EXTRA_LARGE),

                                        ]) : SizedBox() : SizedBox(),


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
                                                    child: Flexible(
                                                      child: Text('Order Details'+'('+widget.cartList.length.toString()+')',style: TextStyle(color: Colors.black,fontSize: 15,fontWeight: FontWeight.normal),),

                                                    ),
                                                  ),

                                                  Align(
                                                    alignment: Alignment.topRight,
                                                    child: Flexible(
                                                        child: Icon(Icons.keyboard_arrow_down,size: 30,color: Colors.deepOrangeAccent,)
                                                    ),
                                                  ),
                                                ],

                                              )

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

                                                onPressed: () {},
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
                ) : Center(child: CircularProgressIndicator());
              }),

            );
        }


}