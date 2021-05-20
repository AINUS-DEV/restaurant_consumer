import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:restaurant_consumer/data/datasource/remote/dio/dio_client.dart';
import 'package:restaurant_consumer/data/datasource/remote/exception/api_error_handler.dart';
import 'package:restaurant_consumer/data/model/response/base/api_response.dart';
import 'package:restaurant_consumer/data/model/response/product_model.dart';
import 'package:restaurant_consumer/data/repository/products.dart';

class ProductRepo {
  final DioClient dioClient;

  ProductRepo({@required this.dioClient});

  Future<ApiResponse> getPopularProductList(String offset) async {
    try {
      final response = Response(requestOptions: RequestOptions(path: ''), data: Products.products, statusCode: 200);
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

  Future<ApiResponse> searchProduct(String productId) async {
    try {
      Product _product = Products.products.products[0];
      final response = Response(requestOptions: RequestOptions(path: ''), data: _product, statusCode: 200);
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }
}
