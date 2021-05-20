import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:restaurant_consumer/data/datasource/remote/dio/dio_client.dart';
import 'package:restaurant_consumer/data/datasource/remote/exception/api_error_handler.dart';
import 'package:restaurant_consumer/data/model/response/base/api_response.dart';
import 'package:restaurant_consumer/data/model/response/category_model.dart';
import 'package:restaurant_consumer/data/model/response/product_model.dart';
import 'package:restaurant_consumer/data/repository/products.dart';
import 'package:restaurant_consumer/utill/images.dart';

class CategoryRepo {
  final DioClient dioClient;
  CategoryRepo({@required this.dioClient});

  Future<ApiResponse> getCategoryList() async {
    try {
      List<CategoryModel> _categoryList = [
        CategoryModel(image: Images.product_7, id: 1, name: 'Bengali', parentId: 0, position: 0),
        CategoryModel(image: Images.product_4, id: 2, name: 'First-Food', parentId: 0, position: 0),
        CategoryModel(image: Images.product_11, id: 3, name: 'Breakfast', parentId: 0, position: 0),
        CategoryModel(image: Images.product_2, id: 4, name: 'Pizza', parentId: 0, position: 0),
        CategoryModel(image: Images.product_9, id: 5, name: 'Lunch', parentId: 0, position: 0),
        CategoryModel(image: Images.product_6, id: 6, name: 'Burger', parentId: 0, position: 0),
        CategoryModel(image: Images.product_3, id: 7, name: 'Dinner', parentId: 0, position: 0),
      ];
      final response = Response(requestOptions: RequestOptions(path: ''), data: _categoryList, statusCode: 200);
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

  Future<ApiResponse> getSubCategoryList(String parentID) async {
    try {
      List<CategoryModel> _categoryList = [
        CategoryModel(image: Images.product_1, id: 1, name: 'Bengali', parentId: 0, position: 0),
        CategoryModel(image: Images.product_2, id: 1, name: 'First-Food', parentId: 0, position: 0),
      ];
      final response = Response(requestOptions: RequestOptions(path: ''), data: _categoryList, statusCode: 200);
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

  Future<ApiResponse> getCategoryProductList(String categoryID) async {
    try {
      List<Product> _productList = [];
      _productList.addAll(Products.products.products);
      _productList.addAll(Products.products.products);
      final response = Response(requestOptions: RequestOptions(path: ''), data: _productList, statusCode: 200);
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }
}
