// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'location_tracking_cubit.dart';

class LocationTrackingState extends Equatable {
  const LocationTrackingState({
    this.isLoading = true,
    this.selectedMarkerLatitude,
    this.selectedMarkerLongitude,
    this.showPausedButtons = false,
  });
  final bool isLoading;
  final double? selectedMarkerLatitude;
  final double? selectedMarkerLongitude;
  final bool showPausedButtons;

  @override
  List<Object?> get props => [
        isLoading,
        selectedMarkerLatitude,
        selectedMarkerLongitude,
        showPausedButtons,
      ];

  LocationTrackingState copyWith({
    bool? isLoading,
    double? selectedMarkerLatitude,
    double? selectedMarkerLongitude,
    bool? showPausedButtons,
  }) {
    return LocationTrackingState(
      isLoading: isLoading ?? this.isLoading,
      selectedMarkerLatitude: selectedMarkerLatitude ?? this.selectedMarkerLatitude,
      selectedMarkerLongitude: selectedMarkerLongitude ?? this.selectedMarkerLongitude,
      showPausedButtons: showPausedButtons ?? this.showPausedButtons,
    );
  }
}
