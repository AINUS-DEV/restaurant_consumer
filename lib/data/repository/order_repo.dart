import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:restaurant_consumer/data/datasource/remote/dio/dio_client.dart';
import 'package:restaurant_consumer/data/datasource/remote/exception/api_error_handler.dart';
import 'package:restaurant_consumer/data/model/response/base/api_response.dart';
import 'package:restaurant_consumer/data/model/response/delivery_man_model.dart';
import 'package:restaurant_consumer/data/model/response/order_details_model.dart';
import 'package:restaurant_consumer/data/model/response/order_model.dart';
import 'package:restaurant_consumer/data/model/response/product_model.dart';
import 'package:restaurant_consumer/data/repository/products.dart';
import 'package:restaurant_consumer/utill/images.dart';

import '../../helper/date_converter.dart';

class OrderRepo {
  final DioClient dioClient;
  OrderRepo({@required this.dioClient});

  Future<ApiResponse> getOrderList() async {
    try {
      List<OrderModel> _orderList = [
        OrderModel(id: 1, userId: 1, deliveryAddressId: 1, orderAmount: 500, couponDiscountTitle: '', couponDiscountAmount: 10, addOnIds: [1], orderStatus: 'pending', totalTaxAmount: 20, updatedAt: DateConverter.localDateToIsoString(DateTime.now().toUtc()), createdAt: DateConverter.localDateToIsoString(DateTime.now().toUtc()), detailsCount: 2, paymentStatus: 'unpaid', paymentMethod: 'digital_payment', deliveryCharge: 10, deliveryMan: DeliveryMan(phone: '123456789', fName: 'Mr', lName: 'John', image: Images.user, id: 1, rating: [Rating(average: '4.5')]), orderType: 'delivery'),
        OrderModel(id: 2, userId: 1, deliveryAddressId: 1, orderAmount: 500, couponDiscountTitle: '', couponDiscountAmount: 10, addOnIds: [1], deliveryMan: DeliveryMan(id: 1, image: Images.user, fName: 'John', lName: 'Doe', phone: '12345678', rating: [Rating(average: '4.6')]), deliveryManId: 1, orderStatus: 'delivered', totalTaxAmount: 20, updatedAt: DateConverter.localDateToIsoString(DateTime.now().toUtc()), createdAt: DateConverter.localDateToIsoString(DateTime.now().toUtc()), detailsCount: 2, paymentStatus: 'paid', paymentMethod: 'digital_payment', deliveryCharge: 10, orderType: 'take_away'),
      ];
      final response = Response(requestOptions: RequestOptions(path: ''), data: _orderList, statusCode: 200);
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

  Future<ApiResponse> getOrderDetails(String orderID) async {
    try {
      List<OrderDetailsModel> _orderDetailsList = [
        OrderDetailsModel(id: 1, addOnIds: [1], addOnQtys: [2], productId: 5, price: 100, discountType: 'amount', discountOnProduct: 10, orderId: 100001, productDetails: Products.products.products[4], quantity: 2, taxAmount: 20, variant: '', variation: [], createdAt: DateConverter.localDateToIsoString(DateTime.now().toUtc()), updatedAt: DateConverter.localDateToIsoString(DateTime.now().toUtc())),
        OrderDetailsModel(id: 2, addOnIds: [1], addOnQtys: [4], productId: 9, price: 150, discountType: 'percent', discountOnProduct: 5, orderId: 100001, productDetails: Products.products.products[8], quantity: 3, taxAmount: 10, variant: '', variation: [], createdAt: DateConverter.localDateToIsoString(DateTime.now().toUtc()), updatedAt: DateConverter.localDateToIsoString(DateTime.now().toUtc())),
      ];
      final response = Response(requestOptions: RequestOptions(path: ''), data: _orderDetailsList, statusCode: 200);
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

  Future<ApiResponse> trackOrder(String orderID) async {
    try {
      OrderModel _orderModel = OrderModel(id: 1, userId: 1, deliveryAddressId: 1, orderAmount: 500, couponDiscountTitle: '', couponDiscountAmount: 10, addOnIds: [1], orderStatus: 'pending', totalTaxAmount: 20, updatedAt: DateConverter.localDateToIsoString(DateTime.now().toUtc()), detailsCount: 2, paymentStatus: 'paid', paymentMethod: 'digital_payment', deliveryCharge: 10, deliveryMan: DeliveryMan(phone: '123456789', fName: 'Mr', lName: 'John', image: Images.user, id: 1, rating: [Rating(average: '4.5')]), orderType: 'delivery');
      final response = Response(requestOptions: RequestOptions(path: ''), data: _orderModel, statusCode: 200);
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

  Future<ApiResponse> getDeliveryManData(String orderID) async {
    try {
      DeliveryManModel _deliveryMan = DeliveryManModel(id: 1, orderId: int.parse(orderID), deliverymanId: 1, latitude: '22.846664', longitude: '91.389211');
      final response = Response(requestOptions: RequestOptions(path: ''), data: _deliveryMan, statusCode: 200);
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

}
