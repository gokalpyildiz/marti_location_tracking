import 'dart:async';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:marti_location_tracking/product/components/base_widgets/marti_scaffold.dart';
import 'package:marti_location_tracking/product/components/dialog/show_address_dialog.dart';
import 'package:marti_location_tracking/product/utils/extensions/context_extension.dart';
import 'package:marti_location_tracking/views/activity_detail/cubit/activity_detail_cubit.dart';
part 'subwidgets/activity_detail_map.dart';

@RoutePage()
class ActivityDetailView extends StatefulWidget {
  const ActivityDetailView({super.key, required this.activityIndex});
  final int activityIndex;

  @override
  State<ActivityDetailView> createState() => _ActivityDetailViewState();
}

class _ActivityDetailViewState extends State<ActivityDetailView> with WidgetsBindingObserver {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ActivityDetailCubit(activityIndex: widget.activityIndex),
      child: SafeArea(
        child: BlocConsumer<ActivityDetailCubit, ActivityDetailState>(
          listener: (context, state) async {
            final cubit = context.read<ActivityDetailCubit>();
            if (state.selectedMarkerLatitude != null &&
                state.selectedMarkerLongitude != null &&
                state.selectedMarkerLatitude != 0 &&
                state.selectedMarkerLongitude != 0) {
              //It works when you click on the marker
              await ShowAddressDialog.show(latitude: state.selectedMarkerLatitude!, longitude: state.selectedMarkerLongitude!, context: context);
              cubit.clearSelectedMarker();
            }
          },
          builder: (context, state) {
            return MartiScaffold(
              child: state.isLoading
                  ? Center(
                      child: CircularProgressIndicator.adaptive(),
                    )
                  : Center(child: _ActivityDetailMap()),
            );
          },
        ),
      ),
    );
  }
}
