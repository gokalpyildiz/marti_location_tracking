import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:marti_location_tracking/product/model/location_store_response_model.dart';
import 'package:marti_location_tracking/product/state/container/product_state_items.dart';
import 'package:marti_location_tracking/product/utils/cache_functions/location_store_function.dart';

part 'profile_state.dart';

class ProfileCubit extends Cubit<ProfileState> {
  ProfileCubit() : super(ProfileState()) {
    init();
  }
  final _locationCacheOperation = LocationStoreFunction(locationStore: ProductStateItems.productCache.locationCacheOperation);
  List<LocationStoreResponseModel?> locationStoreModelList = [];
  Future<void> init() async {
    await setDatas();
    emit(state.copyWith(isLoading: false));
  }

  Future<void> setDatas() async {
    final response = await _locationCacheOperation.getAll(
      openMarker,
    );
    locationStoreModelList = response;
  }

  Future<void> refreshDatas() async {
    emit(state.copyWith(isLoading: true));
    await setDatas();
    emit(state.copyWith(isLoading: false));
  }

  void openMarker(latitude, longitude) {
    (double latitude, double longitude) async {
      emit(state.copyWith(selectedMarkerLatitude: latitude, selectedMarkerLongitude: longitude));
    };
  }

  Future<void> remove(int index) async {
    emit(state.copyWith(isLoading: true));
    _locationCacheOperation.removeItem(index);
    await setDatas();
    emit(state.copyWith(isLoading: false));
  }
}
