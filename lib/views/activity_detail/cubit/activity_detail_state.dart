// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'activity_detail_cubit.dart';

class ActivityDetailState extends Equatable {
  const ActivityDetailState({
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

  ActivityDetailState copyWith({
    bool? isLoading,
    double? selectedMarkerLatitude,
    double? selectedMarkerLongitude,
  }) {
    return ActivityDetailState(
      isLoading: isLoading ?? this.isLoading,
      selectedMarkerLatitude: selectedMarkerLatitude ?? this.selectedMarkerLatitude,
      selectedMarkerLongitude: selectedMarkerLongitude ?? this.selectedMarkerLongitude,
    );
  }
}
