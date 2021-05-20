import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:restaurant_consumer/data/datasource/remote/dio/dio_client.dart';
import 'package:restaurant_consumer/data/datasource/remote/exception/api_error_handler.dart';
import 'package:restaurant_consumer/data/model/response/address_model.dart';
import 'package:restaurant_consumer/data/model/response/base/api_response.dart';
import 'package:restaurant_consumer/localization/language_constrants.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LocationRepo {
  final DioClient dioClient;
  final SharedPreferences sharedPreferences;

  LocationRepo({this.dioClient, this.sharedPreferences});

  Future<ApiResponse> getAllAddress() async {
    try {
      List<AddressModel> _addressList = [
        AddressModel(id: 1, userId: 1, addressType: 'Home', address: 'Dhaka, Bangladesh', contactPersonName: 'John Doe', contactPersonNumber: '12345678', latitude: '22.845619', longitude: '91.197137'),
        AddressModel(id: 1, userId: 1, addressType: 'Home', address: 'London, USA', contactPersonName: 'John Doe', contactPersonNumber: '12345678', latitude: '37.615786', longitude: '-102.385717'),
      ];
      final response = Response(requestOptions: RequestOptions(path: ''), data: _addressList,  statusCode: 200);
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

  List<String> getAllAddressType({BuildContext context}) {
    return [
      getTranslated('home', context),
      getTranslated('workplace', context),
      getTranslated('other', context),
    ];
  }
}
