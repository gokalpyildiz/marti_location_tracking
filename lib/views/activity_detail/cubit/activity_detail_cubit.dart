import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:marti_location_tracking/product/constants/app_constants.dart';
import 'package:marti_location_tracking/product/model/location_store_response_model.dart';
import 'package:marti_location_tracking/product/utils/cache_functions/location_store_function.dart';

part 'activity_detail_state.dart';

class ActivityDetailCubit extends Cubit<ActivityDetailState> {
  ActivityDetailCubit({required this.activityIndex}) : super(ActivityDetailState()) {
    init();
  }
  int activityIndex;
  //todo constantsa ekle
  LatLng initialcameraposition = AppConstants.initialCameraPosition;
  LocationStoreResponseModel? activity;
  final _locationCacheOperation = LocationStoreFunction.instance;
  Future<void> init() async {
    await getActivity();
    await _setInitialCameraPosition();
    emit(state.copyWith(isLoading: false));
  }

  Future<void> getActivity() async {
    var response = await _locationCacheOperation.getAll((double latitude, double longitude) async {
      emit(state.copyWith(selectedMarkerLatitude: latitude, selectedMarkerLongitude: longitude));
    });
    activity = response[activityIndex];
  }

  void openMarker(latitude, longitude) {
    (double latitude, double longitude) async {
      emit(state.copyWith(selectedMarkerLatitude: latitude, selectedMarkerLongitude: longitude));
    };
  }

  Future<void> _setInitialCameraPosition() async {
    var currentPosition = activity?.polylines?.firstOrNull;
    if (currentPosition?.latitude != null && currentPosition?.longitude != null) {
      initialcameraposition = LatLng(currentPosition!.latitude, currentPosition.longitude);
    }
  }

  void clearSelectedMarker() {
    emit(state.copyWith(selectedMarkerLatitude: 0, selectedMarkerLongitude: 0));
  }
}
