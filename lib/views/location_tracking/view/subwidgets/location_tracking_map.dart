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
                if (cubit.trackingStatus == TrackingStatusEnum.STARTED_CONTINUE || cubit.trackingStatus == TrackingStatusEnum.STARTED_PAUSED)
                  Polyline(
                    polylineId: const PolylineId("route"),
                    points: cubit.polylineCoordinatesList,
                    color: context.colorScheme.primary,
                    width: 6,
                  ),
              },
            ),
            TextButton(
                onPressed: () {
                  switch (cubit.trackingStatus) {
                    case TrackingStatusEnum.STARTED_CONTINUE:
                      cubit.trackingStatus = TrackingStatusEnum.STARTED_PAUSED;
                    case TrackingStatusEnum.STARTED_PAUSED:
                      cubit.trackingStatus = TrackingStatusEnum.STARTED_CONTINUE;
                    case TrackingStatusEnum.STOPED:
                    case TrackingStatusEnum.BACKGROUND:
                      cubit.trackingStatus = TrackingStatusEnum.STARTED_CONTINUE;
                      break;
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
