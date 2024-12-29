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
    _animateCameraToPosition(controller, context.read<ActivityDetailCubit>());
  }

  _animateCameraToPosition(GoogleMapController? controller, ActivityDetailCubit cubit) {
    LatLngBounds boundsFromLatLngList(List<LatLng> list) {
      assert(list.isNotEmpty);
      double? x0;
      double? x1;
      double? y0;
      double? y1;
      for (LatLng latLng in list) {
        if (x0 == null) {
          x0 = x1 = latLng.latitude;
          y0 = y1 = latLng.longitude;
        } else {
          if (latLng.latitude > x1!) x1 = latLng.latitude;
          if (latLng.latitude < x0) x0 = latLng.latitude;
          if (latLng.longitude > y1!) y1 = latLng.longitude;
          if (latLng.longitude < y0!) y0 = latLng.longitude;
        }
      }
      return LatLngBounds(northeast: LatLng(x1!, y1!), southwest: LatLng(x0!, y0!));
    }

    Future.delayed(Duration(milliseconds: 10)).then((value) {
      LatLngBounds latLngBounds = boundsFromLatLngList(cubit.activity?.polylines ?? []);
      controller!.animateCamera(CameraUpdate.newLatLngBounds(latLngBounds, 100));
    });
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
