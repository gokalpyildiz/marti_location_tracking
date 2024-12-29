part of '../location_tracking_view.dart';

mixin LocationTrackingMapMixin on State<_LocationTrackingMap> {
  late final LocationTrackingCubit cubit;

  void _onMapCreated(GoogleMapController controller) {
    cubit.mapController.complete(controller);
  }

  void startTracking() async {
    geolocator.Geolocator.getPositionStream(
      locationSettings: geolocator.LocationSettings(accuracy: geolocator.LocationAccuracy.best),
    ).listen((position) async {
      if (cubit.trackingStatus == TrackingStatusEnum.STARTED_CONTINUE) {
        cubit.polylineCoordinatesList.add(LatLng(position.latitude, position.longitude));
        cubit.currentPosition = LocationData.fromMap({'latitude': position.latitude, 'longitude': position.longitude});
        final GoogleMapController controller = await cubit.mapController.future;
        controller.animateCamera(
          CameraUpdate.newCameraPosition(
            CameraPosition(target: LatLng(position.latitude, position.longitude), zoom: 16),
          ),
        );
        //
        if (cubit.lastMarkerPosition?.longitude != null && cubit.lastMarkerPosition?.latitude != null) {
          final distance = cubit.calculateDistance(
            startLat: cubit.lastMarkerPosition!.latitude!,
            startLong: cubit.lastMarkerPosition!.longitude!,
            endLat: cubit.currentPosition!.latitude!,
            endLong: cubit.currentPosition!.longitude!,
          );
          if (distance > 90) {
            cubit.addMarker(LatLng(position.latitude, position.longitude));
            cubit.lastMarkerPosition = cubit.currentPosition;
            setState(() {});
          }
        } else {
          cubit.addMarker(LatLng(position.latitude, position.longitude));
          cubit.lastMarkerPosition = cubit.currentPosition;
          setState(() {});
        }

        setState(() {});
      }
    });
  }

  @override
  void initState() {
    super.initState();
    cubit = context.read<LocationTrackingCubit>();
    startTracking();
  }
}
