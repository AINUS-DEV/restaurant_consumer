
import 'package:flutter/material.dart';
import 'package:restaurant_consumer/data/model/response/order_details_model.dart';
import 'package:restaurant_consumer/data/model/response/order_model.dart';
import 'package:restaurant_consumer/localization/language_constrants.dart';
import 'package:restaurant_consumer/provider/product_provider.dart';
import 'package:restaurant_consumer/utill/color_resources.dart';
import 'package:restaurant_consumer/utill/dimensions.dart';
import 'package:restaurant_consumer/utill/styles.dart';
import 'package:restaurant_consumer/view/base/custom_app_bar.dart';
import 'package:restaurant_consumer/view/screens/rare_review/widget/deliver_man_review_widget.dart';
import 'package:restaurant_consumer/view/screens/rare_review/widget/product_review_widget.dart';
import 'package:provider/provider.dart';

class RateReviewScreen extends StatefulWidget {
  final List<OrderDetailsModel> orderDetailsList;
  final DeliveryMan deliveryMan;
  RateReviewScreen({@required this.orderDetailsList, @required this.deliveryMan});

  @override
  _RateReviewScreenState createState() => _RateReviewScreenState();
}

class _RateReviewScreenState extends State<RateReviewScreen> with TickerProviderStateMixin {
  TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: widget.deliveryMan == null ? 1 : 2, initialIndex: 0, vsync: this);
    Provider.of<ProductProvider>(context, listen: false).initRatingData(widget.orderDetailsList);
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: getTranslated('rate_review', context)),

      body: Column(children: [

        Container(
          color: Theme.of(context).accentColor,
          child: TabBar(
            controller: _tabController,
            labelColor: Theme.of(context).textTheme.bodyText1.color,
            indicatorColor: ColorResources.COLOR_PRIMARY,
            indicatorWeight: 3,
            unselectedLabelStyle: rubikRegular.copyWith(color: ColorResources.COLOR_HINT, fontSize: Dimensions.FONT_SIZE_SMALL),
            labelStyle: rubikMedium.copyWith(fontSize: Dimensions.FONT_SIZE_SMALL),
            tabs: widget.deliveryMan != null ? [
              Tab(text: getTranslated(widget.orderDetailsList.length > 1 ? 'items' : 'item', context)),
              Tab(text: getTranslated('delivery_man', context)),
            ] : [
              Tab(text: getTranslated(widget.orderDetailsList.length > 1 ? 'items' : 'item', context)),
            ],
          ),
        ),

        Expanded(child: TabBarView(
          controller: _tabController,
          children: widget.deliveryMan != null ? [
            ProductReviewWidget(orderDetailsList: widget.orderDetailsList),
            DeliveryManReviewWidget(deliveryMan: widget.deliveryMan, orderID: widget.orderDetailsList[0].orderId.toString()),
          ] : [
            ProductReviewWidget(orderDetailsList: widget.orderDetailsList),
          ],
        )),

      ]),
    );
  }
}
