import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:restaurant_consumer/data/datasource/remote/dio/dio_client.dart';
import 'package:restaurant_consumer/data/datasource/remote/exception/api_error_handler.dart';
import 'package:restaurant_consumer/data/model/response/base/api_response.dart';
import 'package:restaurant_consumer/data/model/response/product_model.dart';
import 'package:restaurant_consumer/data/repository/products.dart';

class SetMenuRepo {
  final DioClient dioClient;
  SetMenuRepo({@required this.dioClient});

  Future<ApiResponse> getSetMenuList() async {
    try {
      List<Product> _setMenuList = [];
      _setMenuList.add(Products.products.products[7]);
      _setMenuList.add(Products.products.products[11]);
      _setMenuList.add(Products.products.products[9]);
      _setMenuList.add(Products.products.products[4]);
      _setMenuList.add(Products.products.products[2]);
      final response = Response(requestOptions: RequestOptions(path: ''), data: _setMenuList, statusCode: 200);
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }
}
