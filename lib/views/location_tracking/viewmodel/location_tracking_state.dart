part of 'location_tracking_cubit.dart';

class LocationTrackingState extends Equatable {
  const LocationTrackingState({
    this.isLoading = true,
    this.selectedMarkerLatitude,
    this.selectedMarkerLongitude,
  });
  final bool isLoading;
  final double? selectedMarkerLatitude;
  final double? selectedMarkerLongitude;

  @override
  List<Object?> get props => [
        isLoading,
        selectedMarkerLatitude,
        selectedMarkerLongitude,
      ];

  LocationTrackingState copyWith({
    bool? isLoading,
    double? selectedMarkerLatitude,
    double? selectedMarkerLongitude,
  }) {
    return LocationTrackingState(
      isLoading: isLoading ?? this.isLoading,
      selectedMarkerLatitude: selectedMarkerLatitude ?? this.selectedMarkerLatitude,
      selectedMarkerLongitude: selectedMarkerLongitude ?? this.selectedMarkerLongitude,
    );
  }
}
