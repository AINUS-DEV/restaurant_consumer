import 'package:flutter/material.dart';
import 'package:restaurant_consumer/helper/date_converter.dart';
import 'package:restaurant_consumer/helper/network_info.dart';
import 'package:restaurant_consumer/localization/language_constrants.dart';
import 'package:restaurant_consumer/provider/cart_provider.dart';
import 'package:restaurant_consumer/provider/splash_provider.dart';
import 'package:restaurant_consumer/utill/color_resources.dart';
import 'package:restaurant_consumer/utill/dimensions.dart';
import 'package:restaurant_consumer/utill/images.dart';
import 'package:restaurant_consumer/utill/styles.dart';
import 'package:restaurant_consumer/view/screens/cart/cart_screen.dart';
import 'package:restaurant_consumer/view/screens/home/home_screen.dart';
import 'package:restaurant_consumer/view/screens/menu/menu_screen.dart';
import 'package:restaurant_consumer/view/screens/order/order_screen.dart';
import 'package:restaurant_consumer/view/screens/wishlist/wishlist_screen.dart';
import 'package:provider/provider.dart';

class DashboardScreen extends StatefulWidget {
  @override
  _DashboardScreenState createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  final PageController _pageController = PageController();
  int _pageIndex = 0;
  List<Widget> _screens;
  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey();

  @override
  void initState() {
    super.initState();

    _screens = [
      HomeScreen(),
      CartScreen(),
      OrderScreen(),
      WishListScreen(),
      MenuScreen(onTap: (int pageIndex) {
        _setPage(pageIndex);
      }),
    ];

    NetworkInfo.checkConnectivity(_scaffoldKey, context);
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        if (_pageIndex != 0) {
          _setPage(0);
          return false;
        } else {
          return true;
        }
      },
      child: Scaffold(
        key: _scaffoldKey,
        bottomNavigationBar: BottomNavigationBar(
          selectedItemColor: Theme.of(context).primaryColor,
          unselectedItemColor: ColorResources.COLOR_GREY,
          showUnselectedLabels: true,
          currentIndex: _pageIndex,
          type: BottomNavigationBarType.fixed,
          items: [
            _barItem(Icons.home, getTranslated('home', context), 0),
            _barItem(Icons.shopping_cart, getTranslated('cart', context), 1),
            _barItem(Icons.shopping_bag, getTranslated('order', context), 2),
            _barItem(Icons.favorite, getTranslated('favourite', context), 3),
            _barItem(Icons.menu, getTranslated('menu', context), 4)
          ],
          onTap: (int index) {
            _setPage(index);
          },
        ),
        appBar: Provider.of<SplashProvider>(context, listen: false).isRestaurantClosed() ? AppBar(
          toolbarHeight: 40,
          backgroundColor: Theme.of(context).primaryColor,
          elevation: 1,
          title: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
            Padding(padding: EdgeInsets.symmetric(horizontal: Dimensions.PADDING_SIZE_SMALL), child: Image.asset(Images.closed, width: 25, height: 25)),
            Text(
              '${getTranslated('restaurant_is_close_now', context)} '
                  '${DateConverter.convertTimeToTime('${Provider.of<SplashProvider>(context, listen: false).configModel.restaurantOpenTime}:00')}',
              style: rubikRegular.copyWith(fontSize: 12, color: Colors.black),
            ),
          ]),
        ) : null,
        body: PageView.builder(
          controller: _pageController,
          itemCount: _screens.length,
          physics: NeverScrollableScrollPhysics(),
          itemBuilder: (context, index) {
            return _screens[index];
          },
        ),
      ),
    );
  }

  BottomNavigationBarItem _barItem(IconData icon, String label, int index) {
    return BottomNavigationBarItem(
      icon: Stack(
        clipBehavior: Clip.none,
        children: [
          Icon(icon, color: index == _pageIndex ? ColorResources.COLOR_PRIMARY : ColorResources.COLOR_GREY, size: 25),
          index == 1 ? Positioned(
            top: -7, right: -7,
            child: Container(
              padding: EdgeInsets.all(4),
              alignment: Alignment.center,
              decoration: BoxDecoration(shape: BoxShape.circle, color: Colors.red),
              child: Text(
                Provider.of<CartProvider>(context).cartList.length.toString(),
                style: rubikMedium.copyWith(color: ColorResources.COLOR_WHITE, fontSize: 8),
              ),
            ),
          ) : SizedBox(),
        ],
      ),
      label: label,
    );
  }

  void _setPage(int pageIndex) {
    setState(() {
      _pageController.jumpToPage(pageIndex);
      _pageIndex = pageIndex;
    });
  }
}
