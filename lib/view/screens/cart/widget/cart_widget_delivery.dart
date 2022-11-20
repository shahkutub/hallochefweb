import 'package:efood_multivendor/controller/cart_controller.dart';
import 'package:efood_multivendor/controller/coupon_controller.dart';
import 'package:efood_multivendor/data/model/response/cart_model.dart';
import 'package:efood_multivendor/helper/price_converter.dart';
import 'package:efood_multivendor/helper/responsive_helper.dart';
import 'package:efood_multivendor/helper/route_helper.dart';
import 'package:efood_multivendor/util/dimensions.dart';
import 'package:efood_multivendor/util/styles.dart';
import 'package:efood_multivendor/view/base/custom_app_bar.dart';
import 'package:efood_multivendor/view/base/custom_button.dart';
import 'package:efood_multivendor/view/base/custom_snackbar.dart';
import 'package:efood_multivendor/view/base/no_data_screen.dart';
import 'package:efood_multivendor/view/screens/cart/widget/cart_product_widget.dart';
import 'package:efood_multivendor/view/screens/cart/widget/cart_product_widget_web.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../util/images.dart';
import 'cart_detail_widget_delivery.dart';


class CartWidgetDelivery extends StatefulWidget {

  final List<CartModel> cartList;
  CartWidgetDelivery({@required this.cartList});


  @override
  State<CartWidgetDelivery> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartWidgetDelivery> {
  bool isSwitched = false;
  @override
  void initState() {
    super.initState();

    Get.find<CartController>().calculationCart();
  }
  @override
  Widget build(BuildContext context) {
    return GetBuilder<CartController>(builder: (cartController) {
     print('cartlist: '+cartController.cartList.length.toString());

            return cartController.cartList.length > 0 ?
              Container(
               // color: Colors.amber,
                //height: 20,
                child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start, children: [

                 // Product
                  SizedBox(
                    height: 50,
                    child: ListView.builder(
                      //physics: NeverScrollableScrollPhysics(),
                      shrinkWrap: false,
                      itemCount: cartController.cartList.length,
                      itemBuilder: (context, index) {
                        return CartDetailWidgetDelivery(cart: cartController.cartList[index], cartIndex: index, addOns: cartController.addOnsList[index] , isAvailable: cartController.availableList[index]);
                      },
                    ),
                  ),

                  SizedBox(height: Dimensions.PADDING_SIZE_SMALL),

                  //Total
                  Flexible(
                    child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                      Text('item_price'.tr, style: robotoRegular),
                      Text(PriceConverter.convertPrice(cartController.itemPrice), style: robotoRegular),
                    ]),
                  ),
                 SizedBox(height: 10),

                  Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                    Text('addons'.tr, style: robotoRegular),
                    Text('(+) ${PriceConverter.convertPrice(cartController.addOns)}', style: robotoRegular),
                  ]),

                  Padding(
                    padding: EdgeInsets.symmetric(vertical: Dimensions.PADDING_SIZE_SMALL),
                    child: Divider(thickness: 1, color: Theme.of(context).hintColor.withOpacity(0.5)),
                  ),

                  Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                    Text('subtotal'.tr, style: robotoMedium),
                    Text(PriceConverter.convertPrice(cartController.subTotal), style: robotoMedium),
                  ]),


                ]
                )
              )
           : SizedBox(
              height: 20,
              child: Image.asset(
                Images.empty_cart,
                width: 20, height: 20,
              ),
            );
        }

    );
  }
}
