import 'dart:io'; //InternetAddress utility
import 'dart:async'; //For StreamController/Stream

import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';
import 'package:java_code_app/transision/route_transisition.dart';
import 'package:java_code_app/view/dashboard_page.dart';
import 'package:java_code_app/view/offline/offline_page.dart';

class ConnectionStatus {
  //This creates the single instance by calling the `_internal` constructor specified below
  static final ConnectionStatus _singleton = ConnectionStatus._internal();
  ConnectionStatus._internal();

  //This is what's used to retrieve the instance through the app
  static ConnectionStatus getInstance() => _singleton;

  //This tracks the current connection status
  static bool hasConnection = false;
  static int hasLock = 0;
  //This is how we'll allow subscribing to connection changes
  StreamController connectionChangeController = StreamController.broadcast();

  //flutter_connectivity
  static final Connectivity _connectivity = Connectivity();
  static GlobalKey<NavigatorState>? _navigatorKey;
  //Hook into flutter_connectivity's Stream to listen for changes
  //And check the connection status out of the gate
  void initialize(GlobalKey<NavigatorState> navigatorKey) {
    _connectivity.onConnectivityChanged.listen(_connectionChange);
    _navigatorKey = navigatorKey;
    print(_navigatorKey);
    checkConnection();
  }

  Stream get connectionChange => connectionChangeController.stream;

  //A clean up method to close our StreamController
  //   Because this is meant to exist through the entire application life cycle this isn't
  //   really an issue
  void dispose() {
    connectionChangeController.close();
  }

  //flutter_connectivity's listener
  void _connectionChange(ConnectivityResult result) {
    checkConnection();
  }

  //The test to actually see if there is a connection
  Future<bool> checkConnection() async {
    bool previousConnection = hasConnection;

    try {
      final result = await InternetAddress.lookup('google.com');
      final connection = await _connectivity.checkConnectivity();

      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        hasConnection = true;
      }else {
        hasConnection = false;
      }
    } on SocketException catch(_) {
      hasConnection = false;
    }

    print(hasLock);


    if(!hasConnection && _navigatorKey?.currentState != null && hasLock <= 0){
      hasLock++;
      _navigatorKey!.currentState!.pushNamedAndRemoveUntil( '/dashboard', (_) => false);
      _navigatorKey!.currentState!.pushReplacement(routeTransition(const OfflinePage()));
    } else if(hasConnection && _navigatorKey?.currentState != null && hasLock >= 1){
      hasLock--;
      _navigatorKey!.currentState!.pushNamedAndRemoveUntil( '/dashboard', (_) => false);
      _navigatorKey!.currentState!.pushReplacement(routeTransition(const DashboardPage()));
    }

    //The connection status changed send out an update to all listeners
    if (previousConnection != hasConnection) {
      connectionChangeController.add(hasConnection);
    }

    return hasConnection;
  }
}