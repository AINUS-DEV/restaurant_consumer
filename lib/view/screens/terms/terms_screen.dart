import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:restaurant_consumer/localization/language_constrants.dart';
import 'package:restaurant_consumer/provider/splash_provider.dart';
import 'package:restaurant_consumer/view/base/custom_app_bar.dart';
import 'package:provider/provider.dart';

class TermsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: getTranslated('terms_and_condition', context)),
      body: Html(data: Provider.of<SplashProvider>(context, listen: false).configModel.termsAndConditions
          ?? getTranslated('no_terms_and_condition', context)),
    );
  }
}
