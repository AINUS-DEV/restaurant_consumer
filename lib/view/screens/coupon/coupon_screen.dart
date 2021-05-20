import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:restaurant_consumer/helper/date_converter.dart';
import 'package:restaurant_consumer/localization/language_constrants.dart';
import 'package:restaurant_consumer/provider/coupon_provider.dart';
import 'package:restaurant_consumer/provider/splash_provider.dart';
import 'package:restaurant_consumer/utill/color_resources.dart';
import 'package:restaurant_consumer/utill/dimensions.dart';
import 'package:restaurant_consumer/utill/images.dart';
import 'package:restaurant_consumer/utill/styles.dart';
import 'package:restaurant_consumer/view/base/custom_app_bar.dart';
import 'package:restaurant_consumer/view/base/no_data_screen.dart';
import 'package:provider/provider.dart';

class CouponScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Provider.of<CouponProvider>(context, listen: false).getCouponList(context);

    return Scaffold(
      appBar: CustomAppBar(title: getTranslated('coupon', context)),
      body: Consumer<CouponProvider>(
        builder: (context, coupon, child) {
          return coupon.couponList != null ? coupon.couponList.length > 0 ? RefreshIndicator(
            onRefresh: () async {
              await Provider.of<CouponProvider>(context, listen: false).getCouponList(context);
            },
            backgroundColor: Theme.of(context).primaryColor,
            child: ListView.builder(
              itemCount: coupon.couponList.length,
              padding: EdgeInsets.all(Dimensions.PADDING_SIZE_LARGE),
              itemBuilder: (context, index) {
                return InkWell(
                  onTap: () {
                    Clipboard.setData(ClipboardData(text: coupon.couponList[index].code));
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(getTranslated('coupon_code_copied', context)), backgroundColor: Colors.green));
                  },
                  child: Padding(
                    padding: EdgeInsets.only(bottom: Dimensions.PADDING_SIZE_LARGE),
                    child: Stack(children: [

                      Image.asset(Images.coupon_bg, height: 100, width: MediaQuery.of(context).size.width, color: Theme.of(context).primaryColor),

                      Container(
                        height: 100,
                        alignment: Alignment.center,
                        child: Row(children: [

                          SizedBox(width: 50),
                          Image.asset(Images.percentage, height: 50, width: 50),

                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: Dimensions.PADDING_SIZE_LARGE, vertical: Dimensions.PADDING_SIZE_SMALL),
                            child: Image.asset(Images.line, height: 100, width: 5),
                          ),

                          Expanded(
                            child: Column(crossAxisAlignment: CrossAxisAlignment.start, mainAxisAlignment: MainAxisAlignment.center, children: [
                              SelectableText(
                                coupon.couponList[index].code,
                                style: rubikRegular.copyWith(color: ColorResources.COLOR_WHITE),
                              ),
                              SizedBox(height: Dimensions.PADDING_SIZE_EXTRA_SMALL),
                              Text(
                                '${coupon.couponList[index].discount}${coupon.couponList[index].discountType == 'percent' ? '%'
                                    : Provider.of<SplashProvider>(context, listen: false).configModel.currencySymbol} off',
                                style: rubikMedium.copyWith(color: ColorResources.COLOR_WHITE, fontSize: Dimensions.FONT_SIZE_EXTRA_LARGE),
                              ),
                              SizedBox(height: Dimensions.PADDING_SIZE_EXTRA_SMALL),
                              Text(
                                '${getTranslated('valid_until', context)} ${DateConverter.isoStringToLocalDateOnly(coupon.couponList[index].expireDate)}',
                                style: rubikRegular.copyWith(color: ColorResources.COLOR_WHITE, fontSize: Dimensions.FONT_SIZE_SMALL),
                              ),
                            ]),
                          ),

                        ]),
                      ),

                    ]),
                  ),
                );
              },
            ),
          ) : NoDataScreen() : Center(child: CircularProgressIndicator(valueColor: AlwaysStoppedAnimation<Color>(Theme.of(context).primaryColor)));
        },
      ),
    );
  }
}
