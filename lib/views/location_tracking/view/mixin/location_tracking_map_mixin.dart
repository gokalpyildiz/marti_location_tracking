part of '../location_tracking_view.dart';

mixin LocationTrackingMapMixin on State<_LocationTrackingMap> {
  final Completer<GoogleMapController> _mapController = Completer<GoogleMapController>();
  final _location = Location();
  double pace = 0;
  Set<Marker> markers = {};
  LatLng _initialcameraposition = LatLng(37.33500926, -122.03272188);
  final List<LatLng> _polylineCoordinatesList = [];
  LocationData? _currentPosition;
  LocationData? _lastMarkerPosition;
  bool trackingStarted = false;

  void _onMapCreated(GoogleMapController controller) {
    _mapController.complete(controller);
  }

  void startTracking() async {
    _location.changeSettings(
      accuracy: LocationAccuracy.navigation,
    );

    geoLocator.Geolocator.getPositionStream(
      locationSettings: geoLocator.LocationSettings(accuracy: geoLocator.LocationAccuracy.best),
    ).listen((position) async {
      if (trackingStarted) {
        _currentPosition = LocationData.fromMap({
          "latitude": position.latitude,
          "longitude": position.longitude,
        });
        _polylineCoordinatesList.add(LatLng(position.latitude, position.longitude));
        final GoogleMapController controller = await _mapController.future;
        controller.animateCamera(
          CameraUpdate.newCameraPosition(
            CameraPosition(target: LatLng(position.latitude, position.longitude), zoom: 20),
          ),
        );
        if (_lastMarkerPosition?.longitude != null && _lastMarkerPosition?.latitude != null) {
          final distance = _calculateDistance(
            startLat: _lastMarkerPosition!.latitude!,
            startLong: _lastMarkerPosition!.longitude!,
            endLat: _currentPosition!.latitude!,
            endLong: _currentPosition!.longitude!,
          );
          if (distance > 90) {
            _addMarker(LatLng(position.latitude, position.longitude), 'Konum');
            _lastMarkerPosition = _currentPosition;
          }
        } else {
          _addMarker(LatLng(position.latitude, position.longitude), 'Konum');
          _lastMarkerPosition = _currentPosition;
        }

        setState(() {});
      }
    });

    _currentPosition = await _location.getLocation();
    _initialcameraposition = LatLng(_currentPosition!.latitude!, _currentPosition!.longitude!);
  }

  double _calculateDistance({required double startLat, required double startLong, required double endLat, required double endLong}) {
    final distance = (geoLocator.GeolocatorPlatform.instance.distanceBetween(startLat, startLong, endLat, endLong));
    return distance;
  }

  void _addMarker(LatLng position, String address) {
    markers.add(
      Marker(
        markerId: MarkerId(position.toString()),
        position: position,
        infoWindow: InfoWindow(title: 'Konum', snippet: address),
      ),
    );
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
  }
}
