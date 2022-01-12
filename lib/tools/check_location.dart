

class Geolocation{
  //This creates the single instance by calling the `_internal` constructor specified below
  static final Geolocation _singleton = Geolocation._internal();
  Geolocation._internal();

  //This is what's used to retrieve the instance through the app
  static Geolocation getInstance() => _singleton;

}