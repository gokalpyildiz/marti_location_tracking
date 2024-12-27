part of '../location_tracking_view.dart';

class _LocationTrackingMap extends StatefulWidget {
  const _LocationTrackingMap();

  @override
  State<_LocationTrackingMap> createState() => __LocationTrackingMapState();
}

class __LocationTrackingMapState extends State<_LocationTrackingMap> with LocationTrackingMapMixin {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        GoogleMap(
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
              points: _polylineCoordinatesList,
              //TODO color will be taken from the theme.
              color: Colors.green,
              width: 6,
            ),
          },
        ),
        TextButton(
            onPressed: () {
              if (trackingStarted) {
                trackingStarted = false;
              } else {
                trackingStarted = true;
                startTracking();
              }
            },
            child: Text('Start Tracking')),
        Positioned(
          bottom: 10,
          child: TextButton(
              onPressed: () {
                trackingStarted = false;
                _polylineCoordinatesList.clear();
                setState(() {});
              },
              child: Text('Reset')),
        ),
      ],
    );
  }
}
