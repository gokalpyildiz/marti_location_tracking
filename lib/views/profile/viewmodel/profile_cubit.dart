import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:marti_location_tracking/product/model/location_store_response_model.dart';
import 'package:marti_location_tracking/product/utils/cache_functions/location_store_function.dart';

part 'profile_state.dart';

class ProfileCubit extends Cubit<ProfileState> {
  ProfileCubit() : super(ProfileState()) {
    init();
  }
  final _locationCacheOperation = LocationStoreFunction.instance;
  List<LocationStoreResponseModel?> locationStoreModelList = [];
  Future<void> init() async {
    await setDatas();
    emit(state.copyWith(isLoading: false));
  }

  Future<void> setDatas() async {
    final response = await _locationCacheOperation.getAll(
      (latitude, longitude) {
        (double latitude, double longitude) async {
          emit(state.copyWith(selectedMarkerLatitude: latitude, selectedMarkerLongitude: longitude));
        };
      },
    );
    locationStoreModelList = response;
  }

  Future<void> remove(int index) async {
    emit(state.copyWith(isLoading: true));
    _locationCacheOperation.removeItem(index);
    await setDatas();
    emit(state.copyWith(isLoading: false));
  }
}
