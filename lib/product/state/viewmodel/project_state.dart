import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

final class ProjectState extends Equatable {
  const ProjectState({this.themeMode = ThemeMode.light});

  final ThemeMode themeMode;
  //final bool loading;

  @override
  List<Object> get props => [themeMode];

  ProjectState copyWith({
    ThemeMode? themeMode,
  }) {
    return ProjectState(
      themeMode: themeMode ?? this.themeMode,
    );
  }
}
