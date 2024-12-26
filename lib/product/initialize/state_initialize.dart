import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:marti_location_tracking/product/state/container/product_state_items.dart';
import 'package:marti_location_tracking/product/state/viewmodel/project_cubit.dart';

final class StateInitialize extends StatelessWidget {
  const StateInitialize({required this.child, super.key});
  final Widget child;
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<ProjectCubit>.value(
          value: ProductStateItems.projectCubit,
        ),
      ],
      child: child,
    );
  }
}
