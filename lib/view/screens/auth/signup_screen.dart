import 'package:flutter/material.dart';
import 'package:restaurant_consumer/helper/email_checker.dart';
import 'package:restaurant_consumer/localization/language_constrants.dart';
import 'package:restaurant_consumer/provider/auth_provider.dart';
import 'package:restaurant_consumer/utill/color_resources.dart';
import 'package:restaurant_consumer/utill/dimensions.dart';
import 'package:restaurant_consumer/utill/images.dart';
import 'package:restaurant_consumer/view/base/custom_button.dart';
import 'package:restaurant_consumer/view/base/custom_snackbar.dart';
import 'package:restaurant_consumer/view/base/custom_text_field.dart';
import 'package:restaurant_consumer/view/screens/auth/login_screen.dart';
import 'package:restaurant_consumer/view/screens/forgot_password/verification_screen.dart';
import 'package:provider/provider.dart';

class SignUpScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    TextEditingController _emailController = TextEditingController();

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(Dimensions.PADDING_SIZE_LARGE),
        child: Consumer<AuthProvider>(
          builder: (context, authProvider, child) => ListView(
            physics: BouncingScrollPhysics(),
            children: [
              SizedBox(height: 30),
              Padding(
                padding: const EdgeInsets.all(15.0),
                child: Image.asset(Images.efood_bike_with_person, matchTextDirection: true),
              ),
              SizedBox(height: 20),
              Center(
                  child: Text(
                getTranslated('signup', context),
                style: Theme.of(context).textTheme.headline3.copyWith(fontSize: 24, color: ColorResources.getGreyBunkerColor(context)),
              )),
              SizedBox(height: 35),
              Text(
                getTranslated('email', context),
                style: Theme.of(context).textTheme.headline2.copyWith(color: ColorResources.getHintColor(context)),
              ),
              SizedBox(height: Dimensions.PADDING_SIZE_SMALL),
              CustomTextField(
                hintText: getTranslated('demo_gmail', context),
                isShowBorder: true,
                inputAction: TextInputAction.done,
                inputType: TextInputType.emailAddress,
                controller: _emailController,
              ),
              SizedBox(height: 6),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox.shrink(),
                  SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      "",
                      style: Theme.of(context).textTheme.headline2.copyWith(
                            fontSize: Dimensions.FONT_SIZE_SMALL,
                            color: ColorResources.getPrimaryColor(context),
                          ),
                    ),
                  )
                ],
              ),
              // for continue button
              SizedBox(height: 12),
              CustomButton(
                      btnTxt: getTranslated('continue', context),
                      onTap: () {
                        String _email = _emailController.text.trim();
                        if (_email.isEmpty) {
                          showCustomSnackBar(getTranslated('enter_email_address', context), context);
                        }else if (EmailChecker.isNotValid(_email)) {
                          showCustomSnackBar(getTranslated('enter_valid_email', context), context);
                        }else {
                          Navigator.of(context).push(MaterialPageRoute(builder: (_) => VerificationScreen(emailAddress: _email, fromSignUp: true)));
                        }
                      },
                    ),

              // for create an account
              SizedBox(height: 10),
              InkWell(
                onTap: () {
                  Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (_) => LoginScreen()));
                },
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        getTranslated('already_have_account', context),
                        style: Theme.of(context).textTheme.headline2.copyWith(fontSize: Dimensions.FONT_SIZE_SMALL, color: ColorResources.getGreyColor(context)),
                      ),
                      SizedBox(width: Dimensions.PADDING_SIZE_SMALL),
                      Text(
                        getTranslated('login', context),
                        style: Theme.of(context)
                            .textTheme
                            .headline3
                            .copyWith(fontSize: Dimensions.FONT_SIZE_SMALL, color: ColorResources.getGreyBunkerColor(context)),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
