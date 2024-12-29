import 'dart:async';

import 'package:geocoding/geocoding.dart';

class GeographyFunction {
  GeographyFunction._init();
  static final GeographyFunction _instance = GeographyFunction._init();
  static GeographyFunction get instance => _instance;

  Future<String> getAddress({required double latitude, required double longitude}) async {
    if (latitude == 0 || longitude == 0) {
      return "Konum bilgisine ulaşılamadı";
    }
    List<Placemark> placemarks = await placemarkFromCoordinates(latitude, longitude);
    if (placemarks.isEmpty) {
      return "Adres Bilgisi Bulunamadı";
    }
    Placemark place = placemarks[0];
    var address = "${place.name} ${place.street} ${place.subLocality} ${place.locality} ${place.administrativeArea} ${place.country}";
    return address;
  }
}
