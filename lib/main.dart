import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:restaurant_consumer/localization/app_localization.dart';
import 'package:restaurant_consumer/provider/auth_provider.dart';
import 'package:restaurant_consumer/provider/banner_provider.dart';
import 'package:restaurant_consumer/provider/cart_provider.dart';
import 'package:restaurant_consumer/provider/category_provider.dart';
import 'package:restaurant_consumer/provider/chat_provider.dart';
import 'package:restaurant_consumer/provider/coupon_provider.dart';
import 'package:restaurant_consumer/provider/localization_provider.dart';
import 'package:restaurant_consumer/provider/notification_provider.dart';
import 'package:restaurant_consumer/provider/order_provider.dart';
import 'package:restaurant_consumer/provider/location_provider.dart';
import 'package:restaurant_consumer/provider/product_provider.dart';
import 'package:restaurant_consumer/provider/language_provider.dart';
import 'package:restaurant_consumer/provider/onboarding_provider.dart';
import 'package:restaurant_consumer/provider/profile_provider.dart';
import 'package:restaurant_consumer/provider/search_provider.dart';
import 'package:restaurant_consumer/provider/set_menu_provider.dart';
import 'package:restaurant_consumer/provider/splash_provider.dart';
import 'package:restaurant_consumer/provider/theme_provider.dart';
import 'package:restaurant_consumer/provider/wishlist_provider.dart';
import 'package:restaurant_consumer/theme/dark_theme.dart';
import 'package:restaurant_consumer/theme/light_theme.dart';
import 'package:restaurant_consumer/utill/app_constants.dart';
import 'package:restaurant_consumer/view/screens/splash/splash_screen.dart';
import 'package:provider/provider.dart';
import 'di_container.dart' as di;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await di.init();

  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (context) => di.sl<ThemeProvider>()),
      ChangeNotifierProvider(create: (context) => di.sl<SplashProvider>()),
      ChangeNotifierProvider(create: (context) => di.sl<LanguageProvider>()),
      ChangeNotifierProvider(create: (context) => di.sl<OnBoardingProvider>()),
      ChangeNotifierProvider(create: (context) => di.sl<CategoryProvider>()),
      ChangeNotifierProvider(create: (context) => di.sl<BannerProvider>()),
      ChangeNotifierProvider(create: (context) => di.sl<ProductProvider>()),
      ChangeNotifierProvider(create: (context) => di.sl<LocalizationProvider>()),
      ChangeNotifierProvider(create: (context) => di.sl<AuthProvider>()),
      ChangeNotifierProvider(create: (context) => di.sl<LocationProvider>()),
      ChangeNotifierProvider(create: (context) => di.sl<LocalizationProvider>()),
      ChangeNotifierProvider(create: (context) => di.sl<CartProvider>()),
      ChangeNotifierProvider(create: (context) => di.sl<OrderProvider>()),
      ChangeNotifierProvider(create: (context) => di.sl<ChatProvider>()),
      ChangeNotifierProvider(create: (context) => di.sl<SetMenuProvider>()),
      ChangeNotifierProvider(create: (context) => di.sl<ProfileProvider>()),
      ChangeNotifierProvider(create: (context) => di.sl<NotificationProvider>()),
      ChangeNotifierProvider(create: (context) => di.sl<CouponProvider>()),
      ChangeNotifierProvider(create: (context) => di.sl<WishListProvider>()),
      ChangeNotifierProvider(create: (context) => di.sl<SearchProvider>()),
    ],
    child: MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  static final navigatorKey = new GlobalKey<NavigatorState>();

  @override
  Widget build(BuildContext context) {
    List<Locale> _locals = [];
    AppConstants.languages.forEach((language) {
      _locals.add(Locale(language.languageCode, language.countryCode));
    });
    return MaterialApp(
      title: 'eFood UI Kit',
      debugShowCheckedModeBanner: false,
      navigatorKey: navigatorKey,
      theme: Provider.of<ThemeProvider>(context).darkTheme ? dark : light,
      locale: Provider.of<LocalizationProvider>(context).locale,
      localizationsDelegates: [
        AppLocalization.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: _locals,
      home: SplashScreen(),
    );
  }
}
