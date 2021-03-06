import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:restaurant_consumer/data/model/response/address_model.dart';
import 'package:restaurant_consumer/data/model/response/base/api_response.dart';
import 'package:restaurant_consumer/data/model/response/response_model.dart';
import 'package:restaurant_consumer/data/repository/location_repo.dart';
import 'package:restaurant_consumer/helper/api_checker.dart';
import 'package:restaurant_consumer/utill/app_constants.dart';
import 'package:geocoder/geocoder.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LocationProvider with ChangeNotifier {
  final SharedPreferences sharedPreferences;
  final LocationRepo locationRepo;

  LocationProvider({@required this.sharedPreferences, this.locationRepo});

  Position _position = Position();
  bool _loading = false;
  bool get loading => _loading;

  Position get position => _position;
  Address _address = Address();

  Address get address => _address;
  List<Marker> _markers = <Marker>[];

  List<Marker> get markers => _markers;

  // for get current location
  void getCurrentLocation({GoogleMapController mapController}) async {
    _loading = true;
    notifyListeners();
    try {
      Position newLocalData = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
      if (mapController != null) {
        mapController.animateCamera(CameraUpdate.newCameraPosition(
            CameraPosition(target: LatLng(newLocalData.latitude, newLocalData.longitude), zoom: 17)));
        _position = Position(latitude: newLocalData.latitude, longitude: newLocalData.longitude);

        final currentCoordinates = new Coordinates(newLocalData.latitude, newLocalData.longitude);
        var currentAddresses = await Geocoder.local.findAddressesFromCoordinates(currentCoordinates);
        _address = currentAddresses.first;
      }
    } on PlatformException catch (e) {
      if (e.code == 'PERMISSION_DENIED') {
        debugPrint("Permission Denied");
      }
    }
    _loading = false;
    notifyListeners();
  }

  // update Position
  void updatePosition(CameraPosition position) async {
    _position = Position(latitude: position.target.latitude, longitude: position.target.longitude);
  }

  // End Address Position
  void dragableAddress() async {
    try {
      _loading = true;
      notifyListeners();
      var currentAddresses = await Geocoder.local.findAddressesFromCoordinates(Coordinates(_position.latitude, _position.longitude));
      _address = currentAddresses.first;
      _loading = false;
      notifyListeners();
    }catch(e) {
      _loading = false;
      notifyListeners();
    }
  }

  // delete usser address
  void deleteUserAddressByID(int id, int index, Function callback) async {
    _addressList.removeAt(index);
    callback(true, 'Deleted address successfully');
    notifyListeners();
  }

  bool _isAvaibleLocation = false;

  bool get isAvaibleLocation => _isAvaibleLocation;

  // user address
  List<AddressModel> _addressList;

  List<AddressModel> get addressList => _addressList;

  Future<ResponseModel> initAddressList(BuildContext context) async {
    ResponseModel _responseModel;
    ApiResponse apiResponse = await locationRepo.getAllAddress();
    if (apiResponse.response != null && apiResponse.response.statusCode == 200) {
      _addressList = [];
      apiResponse.response.data.forEach((address) => _addressList.add(address));
      _responseModel = ResponseModel(true, 'successful');
    } else {
      ApiChecker.checkApi(context, apiResponse);
    }
    notifyListeners();
    return _responseModel;
  }

  bool _isLoading = false;

  bool get isLoading => _isLoading;
  String _errorMessage = '';
  String get errorMessage => _errorMessage;
  String _addressStatusMessage = '';
  String get addressStatusMessage => _addressStatusMessage;
  updateAddressStatusMessae({String message}){
    _addressStatusMessage = message;
  }
  updateErrorMessage({String message}){
    _errorMessage = message;
  }

  Future<ResponseModel> addAddress(AddressModel addressModel) async {
    if (_addressList == null) {
      _addressList = [];
    }
    _addressList.add(addressModel);
    String message = 'Successful';
    ResponseModel responseModel = ResponseModel(true, message);
    _addressStatusMessage = message;
    notifyListeners();
    return responseModel;
  }

  // for save user address Section
  Future<void> saveUserAddress({Address address}) async {
    String userAddress = jsonEncode(address);
    try {
      await sharedPreferences.setString(AppConstants.USER_ADDRESS, userAddress);
    } catch (e) {
      throw e;
    }
  }

  String getUserAddress() {
    return sharedPreferences.getString(AppConstants.USER_ADDRESS) ?? "";
  }

  // for Label Us
  List<String> _getAllAddressType = [];

  List<String> get getAllAddressType => _getAllAddressType;
  int _selectAddressIndex = 0;

  int get selectAddressIndex => _selectAddressIndex;

  updateAddressIndex(int index) {
    _selectAddressIndex = index;
    notifyListeners();
  }

  initializeAllAddressType({BuildContext context}) {
    if (_getAllAddressType.length == 0) {
      _getAllAddressType = [];
      _getAllAddressType = locationRepo.getAllAddressType(context: context);
    }
  }

}
