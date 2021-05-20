import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:restaurant_consumer/data/datasource/remote/dio/dio_client.dart';
import 'package:restaurant_consumer/data/datasource/remote/exception/api_error_handler.dart';
import 'package:restaurant_consumer/data/model/response/base/api_response.dart';
import 'package:restaurant_consumer/data/model/response/coupon_model.dart';

import '../../helper/date_converter.dart';

class CouponRepo {
  final DioClient dioClient;
  CouponRepo({@required this.dioClient});

  Future<ApiResponse> getCouponList() async {
    try {
      List<CouponModel> _couponList = [
        CouponModel(id: 1, discount: 5, title: 'New coupon', code: 'abcd', expireDate: DateConverter.localDateToIsoString(DateTime.now().toUtc()), minPurchase: 100, maxDiscount: 100),
        CouponModel(id: 2, discount: 5, title: 'Winter coupon', code: 'xyz', expireDate: DateConverter.localDateToIsoString(DateTime.now().toUtc()), minPurchase: 100, maxDiscount: 100),
      ];
      final response = Response(requestOptions: RequestOptions(path: ''), data: _couponList, statusCode: 200);
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }
}
