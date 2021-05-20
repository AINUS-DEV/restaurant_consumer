import 'package:dio/dio.dart';
import 'package:restaurant_consumer/data/repository/banner_repo.dart';
import 'package:restaurant_consumer/data/repository/cart_repo.dart';
import 'package:restaurant_consumer/data/repository/category_repo.dart';
import 'package:restaurant_consumer/data/repository/chat_repo.dart';
import 'package:restaurant_consumer/data/repository/coupon_repo.dart';
import 'package:restaurant_consumer/data/repository/location_repo.dart';
import 'package:restaurant_consumer/data/repository/notification_repo.dart';
import 'package:restaurant_consumer/data/repository/order_repo.dart';
import 'package:restaurant_consumer/data/repository/product_repo.dart';
import 'package:restaurant_consumer/data/repository/language_repo.dart';
import 'package:restaurant_consumer/data/repository/onboarding_repo.dart';
import 'package:restaurant_consumer/data/repository/search_repo.dart';
import 'package:restaurant_consumer/data/repository/set_menu_repo.dart';
import 'package:restaurant_consumer/data/repository/profile_repo.dart';
import 'package:restaurant_consumer/data/repository/splash_repo.dart';
import 'package:restaurant_consumer/data/repository/wishlist_repo.dart';
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
import 'package:restaurant_consumer/provider/search_provider.dart';
import 'package:restaurant_consumer/provider/set_menu_provider.dart';
import 'package:restaurant_consumer/provider/profile_provider.dart';
import 'package:restaurant_consumer/provider/splash_provider.dart';
import 'package:restaurant_consumer/provider/theme_provider.dart';
import 'package:restaurant_consumer/provider/wishlist_provider.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'data/datasource/remote/dio/dio_client.dart';
import 'data/datasource/remote/dio/logging_interceptor.dart';

final sl = GetIt.instance;

Future<void> init() async {
  // Core
  sl.registerLazySingleton(() => DioClient('', sl(), loggingInterceptor: sl(), sharedPreferences: sl()));

  // Repository
  sl.registerLazySingleton(() => SplashRepo(sharedPreferences: sl(), dioClient: sl()));
  sl.registerLazySingleton(() => CategoryRepo(dioClient: sl()));
  sl.registerLazySingleton(() => BannerRepo(dioClient: sl()));
  sl.registerLazySingleton(() => ProductRepo(dioClient: sl()));
  sl.registerLazySingleton(() => LanguageRepo());
  sl.registerLazySingleton(() => OnBoardingRepo(dioClient: sl()));
  sl.registerLazySingleton(() => CartRepo(sharedPreferences: sl()));
  sl.registerLazySingleton(() => OrderRepo(dioClient: sl()));
  sl.registerLazySingleton(() => ChatRepo(dioClient: sl()));
  sl.registerLazySingleton(() => LocationRepo(dioClient: sl(), sharedPreferences: sl()));
  sl.registerLazySingleton(() => SetMenuRepo(dioClient: sl()));
  sl.registerLazySingleton(() => ProfileRepo(dioClient: sl(), sharedPreferences: sl()));
  sl.registerLazySingleton(() => SearchRepo(dioClient: sl(), sharedPreferences: sl()));
  sl.registerLazySingleton(() => NotificationRepo(dioClient: sl()));
  sl.registerLazySingleton(() => CouponRepo(dioClient: sl()));
  sl.registerLazySingleton(() => WishListRepo(dioClient: sl()));

  // Provider
  sl.registerFactory(() => ThemeProvider(sharedPreferences: sl()));
  sl.registerFactory(() => SplashProvider(splashRepo: sl()));
  sl.registerFactory(() => LocalizationProvider(sharedPreferences: sl()));
  sl.registerFactory(() => LanguageProvider(languageRepo: sl()));
  sl.registerFactory(() => OnBoardingProvider(onboardingRepo: sl()));
  sl.registerFactory(() => CategoryProvider(categoryRepo: sl()));
  sl.registerFactory(() => BannerProvider(bannerRepo: sl()));
  sl.registerFactory(() => ProductProvider(productRepo: sl()));
  sl.registerFactory(() => CartProvider(cartRepo: sl()));
  sl.registerFactory(() => OrderProvider(orderRepo: sl()));
  sl.registerFactory(() => ChatProvider(chatRepo: sl()));
  sl.registerFactory(() => AuthProvider());
  sl.registerFactory(() => LocationProvider(sharedPreferences: sl(), locationRepo: sl()));
  sl.registerFactory(() => ProfileProvider(profileRepo: sl()));
  sl.registerFactory(() => NotificationProvider(notificationRepo: sl()));
  sl.registerFactory(() => SetMenuProvider(setMenuRepo: sl()));
  sl.registerFactory(() => WishListProvider(wishListRepo: sl(), productRepo: sl()));
  sl.registerFactory(() => CouponProvider(couponRepo: sl()));
  sl.registerFactory(() => SearchProvider(searchRepo: sl()));

  // External
  final sharedPreferences = await SharedPreferences.getInstance();
  sl.registerLazySingleton(() => sharedPreferences);
  sl.registerLazySingleton(() => Dio());
  sl.registerLazySingleton(() => LoggingInterceptor());
}
