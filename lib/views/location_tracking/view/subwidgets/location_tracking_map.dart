part of '../location_tracking_view.dart';

class _LocationTrackingMap extends StatefulWidget {
  const _LocationTrackingMap();

  @override
  State<_LocationTrackingMap> createState() => __LocationTrackingMapState();
}

class __LocationTrackingMapState extends State<_LocationTrackingMap> with LocationTrackingMapMixin {
  @override
  Widget build(BuildContext context) {
    return GoogleMap(
      initialCameraPosition: CameraPosition(target: _initialcameraposition, zoom: 18),
      mapType: MapType.normal,
      onMapCreated: _onMapCreated,
      markers: markers,
      myLocationEnabled: true,
      scrollGesturesEnabled: true,
      myLocationButtonEnabled: true,
      zoomGesturesEnabled: true,
      zoomControlsEnabled: true,
      polylines: {
        Polyline(
          polylineId: const PolylineId("route"),
          points: polylineCoordinatesList,
          //TODO color will be taken from the theme.
          color: Colors.green,
          width: 6,
        ),
      },
    );
  }
}
