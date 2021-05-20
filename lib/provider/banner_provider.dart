import 'package:flutter/material.dart';
import 'package:restaurant_consumer/data/model/response/banner_model.dart';
import 'package:restaurant_consumer/data/model/response/base/api_response.dart';
import 'package:restaurant_consumer/data/model/response/product_model.dart';
import 'package:restaurant_consumer/data/repository/banner_repo.dart';
import 'package:restaurant_consumer/data/repository/products.dart';
import 'package:restaurant_consumer/helper/api_checker.dart';

class BannerProvider extends ChangeNotifier {
  final BannerRepo bannerRepo;
  BannerProvider({@required this.bannerRepo});

  List<BannerModel> _bannerList;
  List<Product> _productList = [];

  List<BannerModel> get bannerList => _bannerList;
  List<Product> get productList => _productList;

  Future<void> getBannerList(BuildContext context, bool reload) async {
    if(bannerList == null || reload) {
      ApiResponse apiResponse = await bannerRepo.getBannerList();
      if (apiResponse.response != null && apiResponse.response.statusCode == 200) {
        _bannerList = [];
        apiResponse.response.data.forEach((category) {
          BannerModel bannerModel = category;
          if(bannerModel.productId != null) {
            _productList.add(Products.products.products[0]);
          }
          _bannerList.add(bannerModel);
        });
        notifyListeners();
      } else {
        ApiChecker.checkApi(context, apiResponse);
      }
    }
  }

}
