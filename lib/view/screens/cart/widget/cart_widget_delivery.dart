import 'package:efood_multivendor/controller/cart_controller.dart';
import 'package:efood_multivendor/controller/coupon_controller.dart';
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


class CartWidgetDelivery extends StatefulWidget {

  CartWidgetDelivery();

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
   GetBuilder<CartController>(builder: (cartController) {
          return cartController.cartList.length > 0 ?
              Container(
                color: Colors.grey,
                height: 70,
                child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [

                  // Product
                  // SizedBox(
                  //   height: 40,
                  //   child: ListView.builder(
                  //     //physics: NeverScrollableScrollPhysics(),
                  //     shrinkWrap: false,
                  //     itemCount: cartController.cartList.length,
                  //     itemBuilder: (context, index) {
                  //       return CartProductWidgetWeb(cart: cartController.cartList[index], cartIndex: index, addOns: cartController.addOnsList[index] , isAvailable: cartController.availableList[index]);
                  //     },
                  //   ),
                  // ),

                  //SizedBox(height: Dimensions.PADDING_SIZE_SMALL),

                  // Total
                  Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                    Text('item_price'.tr, style: robotoRegular),
                    Text(PriceConverter.convertPrice(cartController.itemPrice), style: robotoRegular),
                  ]),
                 // SizedBox(height: 10),

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
          : NoDataScreen(isCart: true, text: '');
        },

    );
  }
}
