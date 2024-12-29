part of 'location_tracking_cubit.dart';

sealed class LocationTrackingState extends Equatable {
  const LocationTrackingState();

  @override
  List<Object> get props => [];
}

final class LocationTrackingInitial extends LocationTrackingState {}
