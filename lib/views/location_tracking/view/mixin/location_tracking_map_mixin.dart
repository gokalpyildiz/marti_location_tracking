part of '../location_tracking_view.dart';

mixin LocationTrackingMapMixin on State<_LocationTrackingMap> {
  final Completer<GoogleMapController> _mapController = Completer<GoogleMapController>();
  final _location = Location();
  double pace = 0;
  Set<Marker> markers = {};
  LatLng _initialcameraposition = LatLng(37.33500926, -122.03272188);
  LocationData? currentLocation;
  Map<PolylineId, Polyline> polylines = {};
  List<LatLng> polylineCoordinatesList = [];
  LocationData? _currentPosition;

  void _onMapCreated(GoogleMapController controller) {
    _mapController.complete(controller);
  }

  getCurrentLocation() async {
    _location.changeSettings(
      accuracy: LocationAccuracy.navigation,
    );

    geoLocator.Geolocator.getPositionStream(
      locationSettings: geoLocator.LocationSettings(accuracy: geoLocator.LocationAccuracy.bestForNavigation),
    ).listen((position) {
      _currentPosition = LocationData.fromMap({
        "latitude": position.latitude,
        "longitude": position.longitude,
      });
      polylineCoordinatesList.add(LatLng(position.latitude, position.longitude));
    });

    _currentPosition = await _location.getLocation();
    _initialcameraposition = LatLng(_currentPosition!.latitude!, _currentPosition!.longitude!);
  }

  @override
  void initState() {
    getCurrentLocation();
    super.initState();
  }
}
