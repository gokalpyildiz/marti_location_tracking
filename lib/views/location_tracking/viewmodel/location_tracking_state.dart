part of 'location_tracking_cubit.dart';

class LocationTrackingState extends Equatable {
  const LocationTrackingState({
    this.isLoading = true,
  });
  final bool isLoading;

  @override
  List<Object> get props => [
        isLoading,
      ];

  LocationTrackingState copyWith({
    bool? isLoading,
  }) {
    return LocationTrackingState(
      isLoading: isLoading ?? this.isLoading,
    );
  }
}
