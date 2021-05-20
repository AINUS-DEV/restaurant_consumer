import 'dart:io';
import 'package:restaurant_consumer/helper/api_checker.dart';
import 'package:restaurant_consumer/helper/date_converter.dart';

import 'package:flutter/material.dart';
import 'package:restaurant_consumer/data/model/response/base/api_response.dart';
import 'package:restaurant_consumer/data/model/response/chat_model.dart';
import 'package:restaurant_consumer/data/repository/chat_repo.dart';

class ChatProvider extends ChangeNotifier {
  final ChatRepo chatRepo;
  ChatProvider({@required this.chatRepo});

  List<ChatModel> _chatList;
  List<bool> _showDate;
  List<DateTime> _dateList;
  File _imageFile;
  bool _isSendButtonActive = false;

  List<ChatModel> get chatList => _chatList != null ? _chatList.reversed.toList() : _chatList;
  List<bool> get showDate => _showDate != null ? _showDate.reversed.toList() : _showDate;
  File get imageFile => _imageFile;
  bool get isSendButtonActive => _isSendButtonActive;

  void getChatList(BuildContext context) async {
    _chatList = null;
    _imageFile = null;
    ApiResponse apiResponse = await chatRepo.getChatList();
    if (apiResponse.response != null && apiResponse.response.statusCode == 200) {
      _chatList = [];
      _showDate = [];
      _dateList = [];
      List<dynamic> _chats = apiResponse.response.data.reversed.toList();
      _chats.forEach((chat) {
        ChatModel chatModel = chat;
        DateTime _originalDateTime = DateConverter.isoStringToLocalDate(chatModel.createdAt);
        DateTime _convertedDate = DateTime(_originalDateTime.year, _originalDateTime.month, _originalDateTime.day);
        bool _addDate = false;
        if(!_dateList.contains(_convertedDate)) {
          _addDate = true;
          _dateList.add(_convertedDate);
        }
        _chatList.add(chatModel);
        _showDate.add(_addDate);
      });
      notifyListeners();
    } else {
      ApiChecker.checkApi(context, apiResponse);
    }
  }

  Future<void> sendMessage(String message, String token, String userID, BuildContext context) async {
    ChatModel _chatModel = ChatModel(
      userId: int.parse(userID), image: null, message: message, reply: null,
      createdAt: DateTime.now().toUtc().toIso8601String(),
    );
    DateTime _originalDateTime = DateConverter.isoStringToLocalDate(_chatModel.createdAt);
    DateTime _convertedDate = DateTime(_originalDateTime.year, _originalDateTime.month, _originalDateTime.day);
    bool _addDate = false;
    if(!_dateList.contains(_convertedDate)) {
      _addDate = true;
      _dateList.add(_convertedDate);
    }
    _chatList.add(_chatModel);
    _showDate.add(_addDate);
    _imageFile = null;
    _isSendButtonActive = false;
    notifyListeners();
  }

  void toggleSendButtonActivity() {
    _isSendButtonActive = !_isSendButtonActive;
    notifyListeners();
  }

  void setImage(File image) {
    _imageFile = image;
    notifyListeners();
  }

}
