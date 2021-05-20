import 'package:flutter/material.dart';
import 'package:restaurant_consumer/localization/language_constrants.dart';
import 'package:restaurant_consumer/provider/location_provider.dart';
import 'package:restaurant_consumer/utill/dimensions.dart';
import 'package:restaurant_consumer/view/base/custom_app_bar.dart';
import 'package:restaurant_consumer/view/base/no_data_screen.dart';
import 'package:restaurant_consumer/view/screens/address/widget/address_widget.dart';
import 'package:provider/provider.dart';

import 'add_new_address_screen.dart';

class AddressScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Provider.of<LocationProvider>(context, listen: false).initAddressList(context);

    return Scaffold(
      appBar: CustomAppBar(title: getTranslated('address', context)),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add, color: Colors.white),
        backgroundColor: Theme.of(context).primaryColor,
        onPressed: () => Navigator.of(context).push(MaterialPageRoute(builder: (_) => AddNewAddressScreen())),
      ),
      body: Consumer<LocationProvider>(
        builder: (context, locationProvider, child) {
          return locationProvider.addressList != null ? locationProvider.addressList.length > 0 ? RefreshIndicator(
            onRefresh: () async {
              await Provider.of<LocationProvider>(context, listen: false).initAddressList(context);
            },
            backgroundColor: Theme.of(context).primaryColor,
            child: ListView.builder(
              padding: EdgeInsets.all(Dimensions.PADDING_SIZE_SMALL),
              itemCount: locationProvider.addressList.length,
              itemBuilder: (context, index) => AddressWidget(
                addressModel: locationProvider.addressList[index],
                index: index,
              ),
            ),
          ) : NoDataScreen()
              : Center(child: CircularProgressIndicator(valueColor: AlwaysStoppedAnimation<Color>(Theme.of(context).primaryColor)));
        },
      ),
    );
  }
}
