import 'package:flutter/material.dart';
import 'package:connectivity_plus/connectivity_plus.dart';

class ConnectivityProvider extends ChangeNotifier {
  bool isOnline = false;

  ConnectivityProvider() {
    _init();
  }

  void _init() {
    Connectivity().checkConnectivity().then((result) {
      isOnline = result != ConnectivityResult.none;
      print('Connectivity changed: $isOnline');
      notifyListeners();
    });
    Connectivity().onConnectivityChanged.listen((result) {
      isOnline = result != ConnectivityResult.none;
      print('Connectivity changed: $isOnline');
      notifyListeners();
    });
  }
} 