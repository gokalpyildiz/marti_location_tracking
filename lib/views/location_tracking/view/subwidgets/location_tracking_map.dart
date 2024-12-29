part of '../location_tracking_view.dart';

class _LocationTrackingMap extends StatefulWidget {
  const _LocationTrackingMap();

  @override
  State<_LocationTrackingMap> createState() => __LocationTrackingMapState();
}

class __LocationTrackingMapState extends State<_LocationTrackingMap> with LocationTrackingMapMixin {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LocationTrackingCubit, LocationTrackingState>(
      builder: (context, state) {
        final cubit = context.read<LocationTrackingCubit>();
        var initialcameraposition = cubit.initialcameraposition;
        return Stack(
          children: [
            GoogleMap(
              initialCameraPosition: CameraPosition(target: initialcameraposition, zoom: 18),
              mapType: MapType.normal,
              onMapCreated: _onMapCreated,
              markers: cubit.markers,
              myLocationEnabled: true,
              scrollGesturesEnabled: true,
              myLocationButtonEnabled: true,
              zoomGesturesEnabled: true,
              zoomControlsEnabled: true,
              polylines: {
                if (cubit.trackingStarted)
                  Polyline(
                    polylineId: const PolylineId("route"),
                    points: cubit.polylineCoordinatesList,
                    //TODO color will be taken from the theme.
                    color: Colors.green,
                    width: 6,
                  ),
              },
            ),
            TextButton(
                onPressed: () {
                  if (cubit.trackingStarted) {
                    cubit.trackingStarted = false;
                  } else {
                    cubit.trackingStarted = true;
                    startTracking();
                  }
                },
                child: Text('Start Tracking')),
            Positioned(
              bottom: 10,
              child: TextButton(
                  onPressed: () {
                    cubit.reset();
                    setState(() {});
                  },
                  child: Text('Reset')),
            ),
          ],
        );
      },
    );
  }
}
