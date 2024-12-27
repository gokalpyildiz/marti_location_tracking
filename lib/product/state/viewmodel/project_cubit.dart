import 'package:flutter/material.dart';
import 'package:marti_location_tracking/product/state/base/base_cubit.dart';
import 'package:marti_location_tracking/product/state/viewmodel/project_state.dart';

final class ProjectCubit extends BaseCubit<ProjectState> {
  ProjectCubit() : super(const ProjectState());

  /// Change theme mode
  /// [themeMode] is [ThemeMode.light] or [ThemeMode.dark]
  void changeThemeMode(ThemeMode themeMode) {
    emit(state.copyWith(themeMode: themeMode));
  }

  ThemeData get themeData => state.themeMode == ThemeMode.dark ? ThemeData.dark() : ThemeData.light();
}
