

import 'dart:async';

class PushNotification{
//This creates the single instance by calling the `_internal` constructor specified below
  static final PushNotification _singleton = PushNotification._internal();

  PushNotification._internal();

  //This is what's used to retrieve the instance through the app
  static PushNotification getInstance() => _singleton;

  //This tracks the current connection status
  static bool hasConnection = false;
  static int hasLock = 0;

  //This is how we'll allow subscribing to connection changes
  StreamController connectionChangeController = StreamController.broadcast();

  //firebase_fcm

  //Hook into flutter_connectivity's Stream to listen for changes
  //And check the connection status out of the gate
  void initialize() {

  }

  Stream get connectionChange => connectionChangeController.stream;

  //A clean up method to close our StreamController
  //   Because this is meant to exist through the entire application life cycle this isn't
  //   really an issue
  void dispose() {
    connectionChangeController.close();
  }
}