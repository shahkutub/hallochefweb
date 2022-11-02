import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:country_code_picker/country_code.dart';
import 'package:efood_multivendor/controller/auth_controller.dart';
import 'package:efood_multivendor/controller/localization_controller.dart';
import 'package:efood_multivendor/controller/splash_controller.dart';
import 'package:efood_multivendor/data/model/body/social_log_in_body.dart';
import 'package:efood_multivendor/data/model/response/config_model.dart';
import 'package:efood_multivendor/helper/responsive_helper.dart';
import 'package:efood_multivendor/helper/route_helper.dart';
import 'package:efood_multivendor/util/dimensions.dart';
import 'package:efood_multivendor/util/images.dart';
import 'package:efood_multivendor/util/styles.dart';
import 'package:efood_multivendor/view/base/custom_button.dart';
import 'package:efood_multivendor/view/base/custom_snackbar.dart';
import 'package:efood_multivendor/view/base/custom_text_field.dart';
import 'package:efood_multivendor/view/base/web_menu_bar.dart';
import 'package:efood_multivendor/view/screens/auth/widget/code_picker_widget.dart';
import 'package:efood_multivendor/view/screens/auth/widget/condition_check_box.dart';
import 'package:efood_multivendor/view/screens/auth/widget/guest_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:phone_number/phone_number.dart';
import 'package:social_login_buttons/social_login_buttons.dart';

import '../../../util/app_constants.dart';
import 'widget/social_login_widget.dart';

class SignInButtonScreen extends StatefulWidget {
  SignInButtonScreen();

  @override
  _SignInScreenState createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInButtonScreen> {

  @override
  void initState() {
    super.initState();

  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.fromLTRB(220,80,220,80),
      child: Center(
        
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              // SocialLoginButton(
              //   buttonType: SocialLoginButtonType.apple,
              //   onPressed: () {},
              // ),
              // const SizedBox(height: 10),
              // SocialLoginButton(
              //   buttonType: SocialLoginButtonType.appleBlack,
              //   onPressed: () {},
              // ),
              const SizedBox(height: 10),
              SocialLoginButton(
                buttonType: SocialLoginButtonType.facebook,
                onPressed: () {},
              ),
              // const SizedBox(height: 10),
              // SocialLoginButton(
              //   buttonType: SocialLoginButtonType.github,
              //   onPressed: () {},
              // ),
              const SizedBox(height: 10),
              SocialLoginButton(
                buttonType: SocialLoginButtonType.google,
                onPressed: () {},
              ),
              // const SizedBox(height: 10),
              // SocialLoginButton(
              //   buttonType: SocialLoginButtonType.microsoft,
              //   onPressed: () {},
              // ),
              // const SizedBox(height: 10),
              // SocialLoginButton(
              //   buttonType: SocialLoginButtonType.microsoftBlack,
              //   onPressed: () {},
              //   imageWidth: 20,
              // ),
              const SizedBox(height: 10),
              SocialLoginButton(
                backgroundColor: Colors.amber,
                height: 50,
                text: 'SignIn',
                borderRadius: 20,
                fontSize: 25,
                buttonType: SocialLoginButtonType.generalLogin,
                onPressed: () {},
              ),
              const SizedBox(height: 10),
              // Row(
              //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //   children: [
              //     SocialLoginButton(
              //       buttonType: SocialLoginButtonType.google,
              //       onPressed: () {},
              //       mode: SocialLoginButtonMode.single,
              //     ),
              //   ],
              // )
            ],
          ),
        ),
        
      ),
    );
  }

}
