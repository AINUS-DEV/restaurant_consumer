import 'package:flutter/material.dart';
import 'package:restaurant_consumer/localization/language_constrants.dart';
import 'package:restaurant_consumer/utill/color_resources.dart';
import 'package:restaurant_consumer/utill/dimensions.dart';
import 'package:restaurant_consumer/utill/images.dart';
import 'package:restaurant_consumer/view/base/custom_button.dart';
import 'package:restaurant_consumer/view/screens/auth/login_screen.dart';
import 'package:restaurant_consumer/view/screens/auth/signup_screen.dart';

class WelcomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: [
          SizedBox(height: 50),
          Container(alignment: Alignment.bottomCenter, padding: EdgeInsets.all(30), child: Image.asset(Images.efood_bike_with_grasp, height: 200)),
          SizedBox(height: 30),
          Text(
            getTranslated('welcome', context),
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.headline3.copyWith(color: Theme.of(context).textTheme.bodyText1.color, fontSize: 32),
          ),
          Padding(
            padding: const EdgeInsets.all(Dimensions.PADDING_SIZE_DEFAULT),
            child: Text(
              getTranslated('welcome_to_efood', context),
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.headline2.copyWith(color: ColorResources.getGreyColor(context)),
            ),
          ),
          SizedBox(height: 50),
          Padding(
            padding: const EdgeInsets.all(Dimensions.PADDING_SIZE_DEFAULT),
            child: CustomButton(
              btnTxt: getTranslated('login', context),
              onTap: () {
                Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (_) => LoginScreen()));
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(
                left: Dimensions.PADDING_SIZE_DEFAULT,
                right: Dimensions.PADDING_SIZE_DEFAULT,
                bottom: Dimensions.PADDING_SIZE_DEFAULT,
                top: 12),
            child: CustomButton(
              btnTxt: getTranslated('signup', context),
              onTap: () {
                Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (_) => SignUpScreen()));
              },
              backgroundColor: Colors.black,
            ),
          )
        ],
      ),
    );
  }
}
