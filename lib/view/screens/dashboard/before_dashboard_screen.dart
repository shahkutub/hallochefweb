import 'dart:async';

import 'package:efood_multivendor/controller/order_controller.dart';
import 'package:efood_multivendor/helper/responsive_helper.dart';
import 'package:efood_multivendor/util/dimensions.dart';
import 'package:efood_multivendor/view/base/cart_widget.dart';
import 'package:efood_multivendor/view/screens/cart/cart_screen.dart';
import 'package:efood_multivendor/view/screens/dashboard/dashboard_screen.dart';
import 'package:efood_multivendor/view/screens/dashboard/widget/bottom_nav_item.dart';
import 'package:efood_multivendor/view/screens/dashboard/widget/running_order_view_widget.dart';
import 'package:efood_multivendor/view/screens/favourite/favourite_screen.dart';
import 'package:efood_multivendor/view/screens/home/home_screen.dart';
import 'package:efood_multivendor/view/screens/menu/menu_screen.dart';
import 'package:efood_multivendor/view/screens/order/order_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../controller/category_controller.dart';
import '../../../controller/location_controller.dart';
import '../../../util/styles.dart';
import '../home/widget/category_view.dart';
import '../home/widget/category_view_before_dashboard.dart';

class BeforeDashboardScreen extends StatefulWidget {
  final int pageIndex;
  BeforeDashboardScreen({@required this.pageIndex});

  @override
  _BeforeDashboardScreenState createState() => _BeforeDashboardScreenState();
}

class _BeforeDashboardScreenState extends State<BeforeDashboardScreen> {
  PageController _pageController;
  int _pageIndex = 0;
  List<Widget> _screens;
  GlobalKey<ScaffoldMessengerState> _scaffoldKey = GlobalKey();
  bool _canExit = GetPlatform.isWeb ? true : false;

  @override
  void initState() {
    super.initState();
    //
    // _pageIndex = widget.pageIndex;
    //
    // _pageController = PageController(initialPage: widget.pageIndex);
    //
    // _screens = [
    //   HomeScreen(),
    //   FavouriteScreen(),
    //   CartScreen(fromNav: true),
    //   OrderScreen(),
    //   Container(),
    // ];
    //
    // Future.delayed(Duration(seconds: 1), () {
    //   setState(() {});
    // });

    /*if(GetPlatform.isMobile) {
      NetworkInfo.checkConnectivity(_scaffoldKey.currentContext);
    }*/

    Get.find<CategoryController>().getCategoryList(false);
  }

  @override
  Widget build(BuildContext context) {
    final height  = MediaQuery.of(context).size.height * 1 ;
    final width  = MediaQuery.of(context).size.width * 1 ;
    return Scaffold(
      backgroundColor: Color(0xffEEF2F5),
      appBar: AppBar(
        //title: const  Text('') ,
        title: GetBuilder<LocationController>(builder: (locationController) {
          return Row(crossAxisAlignment: CrossAxisAlignment.center, mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Icon(
                locationController.getUserAddress().addressType == 'home' ? Icons.home_filled
                    : locationController.getUserAddress().addressType == 'office' ? Icons.work : Icons.location_on,
                size: 20, color: Theme.of(context).textTheme.bodyText1.color,
              ),
              SizedBox(width: 10),
              Flexible(
                child: Text(
                  locationController.getUserAddress().address,
                  style: robotoRegular.copyWith(
                    color: Theme.of(context).textTheme.bodyText1.color, fontSize: Dimensions.fontSizeSmall,
                  ),
                  maxLines: 1, overflow: TextOverflow.ellipsis,
                ),
              ),
              Icon(Icons.arrow_drop_down, color: Theme.of(context).textTheme.bodyText1.color),
            ],
          );
        }),
        actions: const[
          Icon(Icons.shopping_bag_outlined),
          SizedBox(width: 10,)
        ],
        bottom: PreferredSize(
          preferredSize:const Size.fromHeight(40),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15 , vertical: 10),
            child: Row(
              children:  [
                Expanded(child: CupertinoTextField(
                  padding: EdgeInsets.symmetric(vertical: 12 , horizontal: 10),
                  placeholder: "Seach for shop & restaurants",
                  prefix: Padding(
                    padding: const EdgeInsets.only(left: 10),
                    child: Icon(Icons.search , color: Color(0xff7b7b7b) ,),
                  ),
                  decoration: BoxDecoration(
                      color: Color(0xfff7f7f7),
                      borderRadius : BorderRadius.circular(50)
                  ),
                  style: TextStyle(color: Color(0xff707070) ,
                    fontSize: 12, ) ,
                )),
              ],
            ),
          ),
        ),
      ),
      body:  SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15 ,vertical: 15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // ClipRRect(
              //   borderRadius: BorderRadius.circular(10),
              //   child: InkWell(
              //     onTap: (){
              //       Navigator.push(context, MaterialPageRoute(builder: (context) => DashboardScreen(pageIndex: 0)));
              //     },
              //     child: Container(
              //       height: MediaQuery.of(context).size.height * .18,
              //       width: double.infinity,
              //       decoration: BoxDecoration(
              //           //color: MyColors.primaryColor,
              //           borderRadius: BorderRadius.circular(10)
              //       ),
              //       child: Stack(
              //         alignment: Alignment.bottomLeft,
              //         children: [
              //           Image(
              //               fit: BoxFit.fitWidth,
              //               width: double.infinity,
              //               image: NetworkImage('https://cdn.pixabay.com/photo/2021/01/16/09/05/meal-5921491_960_720.jpg')),
              //           Padding(
              //             padding: const EdgeInsets.all(6.0),
              //             child: Container(
              //
              //               child: Padding(
              //                 padding: const EdgeInsets.all(8.0),
              //                 child: Column(
              //                   mainAxisAlignment: MainAxisAlignment.start,
              //                   crossAxisAlignment: CrossAxisAlignment.start,
              //                   mainAxisSize: MainAxisSize.min,
              //                   children: [
              //                     Text('Food delivery' , style: TextStyle(color: Colors.white , fontWeight:FontWeight.bold , fontSize: 18 ),),
              //                     Text('Order from your faviruite\nrestaurants and home chefs' , style: TextStyle(color: Colors.white , fontWeight: FontWeight.w500 ,height:1 ,  fontSize: 14  )),
              //
              //                   ],
              //                 ),
              //               ),
              //             ),
              //           )
              //         ],
              //       ),
              //     ),
              //   ),
              // ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: Row(
                  children: [
                    Expanded(
                      flex: 1,
                      child: Container(
                        height: MediaQuery.of(context).size.height * .35,
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10)
                        ),
                        child: Padding(
                          padding:  EdgeInsets.all(10.0),
                          child:InkWell(
                            child: Ink(
                              child: Stack(

                                children: [

                                  Align(
                                    alignment: Alignment.topLeft,
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text('Food Delivery' , style: TextStyle(color: Colors.black , fontWeight: FontWeight.bold, fontSize: 18 ),),
                                        Text('Order food you love' , style: TextStyle(color: Colors.black , fontWeight: FontWeight.w500 ,height:1 ,  fontSize: 14  )),

                                      ],
                                    ),
                                  ),


                                  Align(
                                    alignment: Alignment.bottomRight,
                                    child: CircleAvatar(
                                      backgroundColor: Colors.white,
                                      radius: 60,
                                      backgroundImage: AssetImage('assets/image/foodboul.png'),
                                    ),
                                  ),



                                ],
                              ),
                              color: Colors.white,
                            ),

                            onTap: (){
                              Navigator.push(context, MaterialPageRoute(builder: (context) => DashboardScreen(pageIndex: 0)));
                            },
                          ),


                          // child: Stack(
                          //   alignment: Alignment.center,
                          //   children: const [
                          //     CircleAvatar(
                          //       radius: 50,
                          //       backgroundImage: AssetImage('assets/pandamart.jpg'),
                          //     ),
                          //     Positioned(
                          //         bottom: 15,
                          //         left: 0,
                          //         child: Text('Food Delivery' , style: TextStyle(color: Colors.black , fontWeight: FontWeight.bold, fontSize: 18 ),)),
                          //     Positioned(
                          //         bottom: 0,
                          //         left: 0,
                          //         child: Text('Order food you love' , style: TextStyle(color: Colors.black , fontWeight: FontWeight.w500 ,height:1 ,  fontSize: 14  ))),
                          //
                          //   ],
                          // ),
                        ),
                      ),
                    ),
                    SizedBox(width: 8,),
                    Expanded(
                      flex: 1,
                      child: Column(
                        children: [
                          InkWell(
                            onTap: (){
                              Navigator.push(context, MaterialPageRoute(builder: (context) => DashboardScreen(pageIndex: 0)));
                            },
                            child: Container(
                              padding:  EdgeInsets.all(10.0),
                              height: MediaQuery.of(context).size.height * .20,
                              width: double.infinity,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(10),

                              ),
                              child: Stack(

                                children: [

                                  Align(
                                    alignment: Alignment.topLeft,
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text('Book table' , style: TextStyle(color: Colors.black , fontWeight: FontWeight.bold, fontSize: 18 ),),
                                        //Text('Order food you love' , style: TextStyle(color: Colors.black , fontWeight: FontWeight.w500 ,height:1 ,  fontSize: 14  )),

                                      ],
                                    ),
                                  ),


                                  Align(
                                      alignment: Alignment.bottomRight,
                                      // child: CircleAvatar(
                                      //   backgroundColor: Colors.white,
                                      //   radius: 50,
                                      //   backgroundImage: AssetImage('assets/image/booktable.png'),
                                      // ),

                                      child: Image.asset(
                                        'assets/image/booktable.png',
                                        width: 80,
                                        height: 80,
                                        fit: BoxFit.fill,
                                      )

                                  ),



                                ],
                              ),
                            ),
                          ),

                          SizedBox(height: 5),

                          InkWell(
                              onTap: (){
                                Navigator.push(context, MaterialPageRoute(builder: (context) => DashboardScreen(pageIndex: 0)));
                              },
                              child: Container(
                                height: MediaQuery.of(context).size.height * .15,
                                width: double.infinity,
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(10)
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(10.0),
                                  child: Stack(

                                    children: [

                                      Align(
                                        alignment: Alignment.topLeft,
                                        child: Column(
                                          mainAxisAlignment: MainAxisAlignment.start,
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Text('Dine-in' , style: TextStyle(color: Colors.black , fontWeight: FontWeight.bold, fontSize: 18 ),),
                                            //Text('Order food you love' , style: TextStyle(color: Colors.black , fontWeight: FontWeight.w500 ,height:1 ,  fontSize: 14  )),

                                          ],
                                        ),
                                      ),


                                      Align(
                                        alignment: Alignment.bottomRight,
                                        child: CircleAvatar(
                                          backgroundColor: Colors.white,
                                          radius: 35,
                                          backgroundImage: AssetImage('assets/image/dinein.png'),
                                        ),
                                      ),



                                    ],
                                  ),
                                ),

                              )
                          ),

                        ],
                      ),
                    ),

                  ],
                ),
              ),

              GestureDetector(
                onTap: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context) => DashboardScreen(pageIndex: 0)));
                },
                child: Container(
                  height: MediaQuery.of(context).size.height * .15,
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10)
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Stack(

                      children: [

                        Align(
                          alignment: Alignment.topLeft,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('Pick-up' , style: TextStyle(color: Colors.black , fontWeight: FontWeight.bold, fontSize: 18 ),),
                              //Text('Order food you love' , style: TextStyle(color: Colors.black , fontWeight: FontWeight.w500 ,height:1 ,  fontSize: 14  )),

                            ],
                          ),
                        ),


                        Align(
                            alignment: Alignment.bottomRight,
                            child: Image.asset(
                              'assets/image/pick_up.png',
                              width: 60,
                              height: 60,
                              fit: BoxFit.fill,
                            )

                        ),



                      ],
                    ),
                  ),

                ),
              ),


              CategoryViewBeforeDashboard(),
            ],
          ),
        ),
      ),
      drawer: Drawer(
        child: ListView(
          // Important: Remove any padding from the ListView.
          padding: EdgeInsets.zero,
          children: [
            const DrawerHeader(
              decoration: BoxDecoration(
                color: Color(0xffEF7822),
              ),
              child: CircleAvatar(
                radius: 24,
                //backgroundImage: NetworkImage('https://media-exp1.licdn.com/dms/image/C5603AQFtuW78eNazIw/profile-displayphoto-shrink_800_800/0/1567442703746?e=2147483647&v=beta&t=N5dGxws3xJIhwPM8w_i4dlX8qLmxznmVykPCTccYHj8'),
                backgroundImage: NetworkImage(''),

              ),
            ),
            ListTile(
              title: const Text('Setting' , style: TextStyle( color : Colors.black)),
              leading: Icon(Icons.settings_outlined ,),
              onTap: () {
                // Update the state of the app
                // ...
                // Then close the drawer
                Navigator.pop(context);
              },
            ),
            ListTile(
              title: const Text('Help center 2' , style: TextStyle( color : Colors.black)),
              leading: Icon(Icons.help_outline, ),

              onTap: () {
                // Update the state of the app
                // ...
                // Then close the drawer
                Navigator.pop(context);
              },
            ),
            ListTile(
              title: const Text('More' , style: TextStyle( color : Colors.black)),
              leading: Icon(Icons.more_horiz, ),
              onTap: () {
                // Update the state of the app
                // ...
                // Then close the drawer
                Navigator.pop(context);
              },
            ),
            ListTile(
              title: const Text('Sign up or Login in' , style: TextStyle( color : Colors.black)),
              leading: Icon(Icons.login_outlined, ),
              onTap: () {
                // Update the state of the app
                // ...
                // Then close the drawer
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),
    );
  }

  void _setPage(int pageIndex) {
    setState(() {
      _pageController.jumpToPage(pageIndex);
      _pageIndex = pageIndex;
    });
  }
}