import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:marti_location_tracking/product/utils/cache_functions/location_store_function.dart';
import 'package:marti_location_tracking/views/location_tracking/viewmodel/location_tracking_cubit.dart';

import '../database/location_cache_mock.dart';

void main() {
  late final LocationTrackingCubit homeViewCubit;
  late final LocationsCacheMock locationsCacheMock;
  setUp(() {
    locationsCacheMock = LocationsCacheMock();
    homeViewCubit = LocationTrackingCubit(
        locationCacheOperation: LocationStoreFunction(
      locationStore: locationsCacheMock,
    ));
  });

  group('Location Tracking Cubit Test', () {
    test('inital state is loading', () {
      expect(homeViewCubit.state.isLoading, false);
    });
  });
  blocTest<LocationTrackingCubit, LocationTrackingState>(
    'init state is loading',
    build: () => homeViewCubit,
    act: (bloc) async => bloc.init(),
    expect: () => [
      isA<LocationTrackingState>().having((state) => state.isLoading, '', true),
    ],
  );

  blocTest<LocationTrackingCubit, LocationTrackingState>(
    'refresh page is loading',
    build: () => homeViewCubit,
    act: (bloc) async => await bloc.resetDatas(),
    expect: () => [
      isA<LocationTrackingState>().having((state) => state.isLoading, 'Is Loading True', true),
      isA<LocationTrackingState>().having((state) => state.isLoading, 'Is Loading False', false),
    ],
  );
}
