
import 'package:efood_multivendor/view/base/web_menu_bar.dart';
import 'package:flutter/material.dart';

class WebOrderTrackingScreen extends StatefulWidget {
  @override
  _WebOrderTrackingScreenState createState() => _WebOrderTrackingScreenState();

}

class _WebOrderTrackingScreenState extends State<WebOrderTrackingScreen>{
  @override
  Widget build(BuildContext context) {
            return Scaffold(
              appBar: WebMenuBar(),
              body: Container(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Card(
                            elevation: 10,
                            child: Container(
                              height: 220,
                              width: 200,
                            ),
                          )
                        ],
                      )
                    ],

                  ),
                ),
              ),
            );
        }


}