
import 'package:efood_multivendor/util/images.dart';
import 'package:efood_multivendor/view/base/web_menu_bar.dart';
import 'package:flutter/material.dart';

import '../../base/custom_image.dart';

class WebOrderTrackingScreen extends StatefulWidget {
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
              body: Container(
                
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
                                    Text('Estimated delivery time',style: TextStyle(color: Colors.black,fontSize: 25),),
                                    SizedBox(height: 10,),
                                    Text('15 - 25 Min',style: TextStyle(color: Colors.black,fontSize: 35,fontWeight: FontWeight.bold),),
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
                                                        child:Text('Ghorua Hotel & restaurant - Mohakhali, dhaka bangladesh',style: TextStyle(color: Colors.deepOrangeAccent,fontSize: 15,fontWeight: FontWeight.normal),),

                                                      ),
                                                      SizedBox(width: 10,),
                                                      Text('Order Number: #67565mm',style: TextStyle(color: Colors.grey,fontSize: 10,fontWeight: FontWeight.normal),),

                                                      SizedBox(width: 10,),
                                                      Text('Delivery address',style: TextStyle(color: Colors.grey,fontSize: 10,fontWeight: FontWeight.normal),),

                                                      Text('10 Rd no 1 dhaka',style: TextStyle(color: Colors.black,fontSize: 15,fontWeight: FontWeight.normal),),

                                                      SizedBox(width: 20,),

                                                    ],
                                                  )


                                                ),
                                              ),
                                              SizedBox(width: 10,),
                                              Text('Tk  5000',style: TextStyle(color: Colors.black,fontSize: 15,fontWeight: FontWeight.normal),),

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
                                                  child: Text('Order Details',style: TextStyle(color: Colors.black,fontSize: 20,fontWeight: FontWeight.bold),),

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
              ),
            );
        }


}