part of '../activity_detail_view.dart';

class _ActivityDetailMap extends StatefulWidget {
  const _ActivityDetailMap();
  @override
  State<_ActivityDetailMap> createState() => __ActivityDetailMapState();
}

class __ActivityDetailMapState extends State<_ActivityDetailMap> {
  final Completer<GoogleMapController> mapController = Completer<GoogleMapController>();
  void _onMapCreated(GoogleMapController controller) {
    mapController.complete(controller);
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ActivityDetailCubit, ActivityDetailState>(
      builder: (context, state) {
        final cubit = context.read<ActivityDetailCubit>();
        return Stack(
          children: [
            GoogleMap(
              initialCameraPosition: CameraPosition(
                target: cubit.initialcameraposition,
                zoom: 15,
              ),
              mapType: MapType.normal,
              onMapCreated: _onMapCreated,
              markers: cubit.activity?.markers ?? {},
              myLocationEnabled: false,
              scrollGesturesEnabled: true,
              myLocationButtonEnabled: true,
              zoomGesturesEnabled: true,
              zoomControlsEnabled: true,
              polylines: {
                Polyline(
                  polylineId: const PolylineId("route"),
                  points: cubit.activity?.polylines ?? [],
                  color: context.colorScheme.primary,
                  width: 6,
                ),
              },
            ),
          ],
        );
      },
    );
  }
}
