import 'package:flutter/material.dart';
import 'package:restaurant_consumer/data/model/response/base/api_response.dart';
import 'package:restaurant_consumer/data/model/response/coupon_model.dart';
import 'package:restaurant_consumer/data/repository/coupon_repo.dart';
import 'package:restaurant_consumer/helper/api_checker.dart';

class CouponProvider extends ChangeNotifier {
  final CouponRepo couponRepo;
  CouponProvider({@required this.couponRepo});

  List<CouponModel> _couponList;
  CouponModel _coupon;
  double _discount = 0.0;
  bool _isLoading = false;

  CouponModel get coupon => _coupon;
  double get discount => _discount;
  bool get isLoading => _isLoading;
  List<CouponModel> get couponList => _couponList;

  Future<void> getCouponList(BuildContext context) async {
    ApiResponse apiResponse = await couponRepo.getCouponList();
    if (apiResponse.response != null && apiResponse.response.statusCode == 200) {
      _couponList = [];
      apiResponse.response.data.forEach((category) => _couponList.add(category));
      notifyListeners();
    } else {
      ApiChecker.checkApi(context, apiResponse);
    }
  }

  void removeCouponData(bool notify) {
    _coupon = null;
    _isLoading = false;
    _discount = 0.0;
    if(notify) {
      notifyListeners();
    }
  }
}
