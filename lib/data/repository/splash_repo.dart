import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:restaurant_consumer/data/datasource/remote/dio/dio_client.dart';
import 'package:restaurant_consumer/data/datasource/remote/exception/api_error_handler.dart';
import 'package:restaurant_consumer/data/model/response/base/api_response.dart';
import 'package:restaurant_consumer/utill/app_constants.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../model/response/config_model.dart';

class SplashRepo {
  final DioClient dioClient;
  final SharedPreferences sharedPreferences;
  SplashRepo({@required this.sharedPreferences, @required this.dioClient});

  Future<ApiResponse> getConfig() async {
    try {
      ConfigModel configModel = ConfigModel(
        branches: [Branches(id: 1, latitude: '23.984814', longitude: '90.142450', name: 'Bangladesh', coverage: 1000), Branches(id: 2, latitude: '42.457335', longitude: '-102.473607', name: 'USA', coverage: 1000)],
        cashOnDelivery: 'true', currencySymbol: '\$', deliveryCharge: '10', digitalPayment: 'true', minimumOrderValue: 100, restaurantCloseTime: '23:59',
        restaurantOpenTime: '00:01', restaurantPhone: '123456789', termsAndConditions: 'Terms and Conditions', restaurantAddress: 'New york, USA'
      );
      final response = Response(requestOptions: RequestOptions(path: ''), data: configModel, statusCode: 200);
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

  Future<bool> initSharedData() {
    if(!sharedPreferences.containsKey(AppConstants.THEME)) {
      return sharedPreferences.setBool(AppConstants.THEME, false);
    }
    if(!sharedPreferences.containsKey(AppConstants.COUNTRY_CODE)) {
      return sharedPreferences.setString(AppConstants.COUNTRY_CODE, 'US');
    }
    if(!sharedPreferences.containsKey(AppConstants.LANGUAGE_CODE)) {
      return sharedPreferences.setString(AppConstants.LANGUAGE_CODE, 'en');
    }
    if(!sharedPreferences.containsKey(AppConstants.CART_LIST)) {
      return sharedPreferences.setStringList(AppConstants.CART_LIST, []);
    }
    return Future.value(true);
  }

  Future<bool> removeSharedData() {
    return sharedPreferences.clear();
  }
}
