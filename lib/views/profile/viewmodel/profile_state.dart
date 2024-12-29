// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'profile_cubit.dart';

class ProfileState extends Equatable {
  const ProfileState({this.isLoading = true, this.selectedMarkerLatitude, this.selectedMarkerLongitude});
  final bool isLoading;
  final double? selectedMarkerLatitude;
  final double? selectedMarkerLongitude;

  @override
  List<Object?> get props => [
        isLoading,
        selectedMarkerLatitude,
        selectedMarkerLongitude,
      ];

  ProfileState copyWith({
    bool? isLoading,
    double? selectedMarkerLatitude,
    double? selectedMarkerLongitude,
  }) {
    return ProfileState(
      isLoading: isLoading ?? this.isLoading,
      selectedMarkerLatitude: selectedMarkerLatitude ?? this.selectedMarkerLatitude,
      selectedMarkerLongitude: selectedMarkerLongitude ?? this.selectedMarkerLongitude,
    );
  }
}
