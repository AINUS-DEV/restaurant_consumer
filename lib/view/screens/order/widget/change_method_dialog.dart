import 'package:flutter/material.dart';
import 'package:restaurant_consumer/localization/language_constrants.dart';
import 'package:restaurant_consumer/provider/order_provider.dart';
import 'package:restaurant_consumer/utill/dimensions.dart';
import 'package:restaurant_consumer/utill/images.dart';
import 'package:restaurant_consumer/utill/styles.dart';
import 'package:restaurant_consumer/view/base/custom_button.dart';
import 'package:provider/provider.dart';

class ChangeMethodDialog extends StatelessWidget {
  final String orderID;
  final Function callback;
  ChangeMethodDialog({@required this.orderID, @required this.callback});

  @override
  Widget build(BuildContext context) {
    return Consumer<OrderProvider>(
      builder: (context, order, child) {
        return Dialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          child: Padding(
            padding: EdgeInsets.all(Dimensions.PADDING_SIZE_LARGE),
            child: Column(mainAxisSize: MainAxisSize.min, children: [

              Image.asset(Images.wallet, color: Theme.of(context).primaryColor, width: 100, height: 100),
              SizedBox(height: Dimensions.PADDING_SIZE_LARGE),

              Text(
                getTranslated('do_you_want_to_switch', context), textAlign: TextAlign.justify,
                style: rubikMedium.copyWith(fontSize: Dimensions.FONT_SIZE_LARGE),
              ),
              SizedBox(height: Dimensions.PADDING_SIZE_LARGE),

              Row(children: [
                Expanded(
                  child: TextButton(
                    style: TextButton.styleFrom(
                      padding: EdgeInsets.all(15),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10), side: BorderSide(width: 2, color: Theme.of(context).primaryColor)),
                    ),
                     child: Text(getTranslated('no', context)),
                    onPressed: () => Navigator.pop(context),
                  ),
                ),
                SizedBox(width: Dimensions.PADDING_SIZE_SMALL),
                Expanded(child: !order.isLoading ? CustomButton(btnTxt: getTranslated('yes', context), onTap: () async {
                  await order.updatePaymentMethod(orderID, callback);
                  Navigator.pop(context);
                }) : Center(child: CircularProgressIndicator(valueColor: AlwaysStoppedAnimation<Color>(Theme.of(context).primaryColor)))),
              ]),

            ]),
          ),
        );
      },
    );
  }
}
