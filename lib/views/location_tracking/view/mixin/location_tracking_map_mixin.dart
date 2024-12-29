part of '../location_tracking_view.dart';

mixin LocationTrackingMapMixin on State<_LocationTrackingMap> {
  final Completer<GoogleMapController> _mapController = Completer<GoogleMapController>();

  late final LocationTrackingCubit cubit;

  void _onMapCreated(GoogleMapController controller) {
    _mapController.complete(controller);
  }

  void startTracking() async {
    geolocator.Geolocator.getPositionStream(
      locationSettings: geolocator.LocationSettings(accuracy: geolocator.LocationAccuracy.best),
    ).listen((position) async {
      if (cubit.trackingStarted) {
        cubit.polylineCoordinatesList.add(LatLng(position.latitude, position.longitude));
        final GoogleMapController controller = await _mapController.future;
        controller.animateCamera(
          CameraUpdate.newCameraPosition(
            CameraPosition(target: LatLng(position.latitude, position.longitude), zoom: 16),
          ),
        );
        if (cubit.lastMarkerPosition?.longitude != null && cubit.lastMarkerPosition?.latitude != null) {
          final distance = cubit.calculateDistance(
            startLat: cubit.lastMarkerPosition!.latitude!,
            startLong: cubit.lastMarkerPosition!.longitude!,
            endLat: cubit.currentPosition!.latitude!,
            endLong: cubit.currentPosition!.longitude!,
          );
          if (distance > 90) {
            cubit.addMarker(LatLng(position.latitude, position.longitude), 'Konum');
            cubit.lastMarkerPosition = cubit.currentPosition;
            setState(() {});
          }
        } else {
          cubit.addMarker(LatLng(position.latitude, position.longitude), 'Konum');
          setState(() {});
          cubit.lastMarkerPosition = cubit.currentPosition;
        }

        setState(() {});
      }
    });
  }

  @override
  void initState() {
    super.initState();
    cubit = context.read<LocationTrackingCubit>();
    if (cubit.trackingStarted) {
      startTracking();
    }
  }
}
