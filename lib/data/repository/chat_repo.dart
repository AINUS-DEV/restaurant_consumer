import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:restaurant_consumer/data/datasource/remote/dio/dio_client.dart';
import 'package:restaurant_consumer/data/datasource/remote/exception/api_error_handler.dart';
import 'package:restaurant_consumer/data/model/response/base/api_response.dart';
import 'package:restaurant_consumer/data/model/response/chat_model.dart';
import 'package:restaurant_consumer/helper/date_converter.dart';

class ChatRepo {
  final DioClient dioClient;
  ChatRepo({@required this.dioClient});

  Future<ApiResponse> getChatList() async {
    try {
      List<ChatModel> _chatList = [
        ChatModel(id: 1, userId: 1, reply: 'Hi', message: null, createdAt: DateConverter.localDateToIsoString(DateTime.now().toUtc())),
      ];
      final response = Response(requestOptions: RequestOptions(path: ''), data: _chatList, statusCode: 200);
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }
}
