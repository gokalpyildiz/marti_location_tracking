import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:marti_location_tracking/product/components/base_widgets/marti_scaffold.dart';
import 'package:marti_location_tracking/views/profile/viewmodel/profile_cubit.dart';

@RoutePage()
class ProfileView extends StatefulWidget {
  const ProfileView({super.key});

  @override
  State<ProfileView> createState() => _ProfileViewState();
}

class _ProfileViewState extends State<ProfileView> {
  late final ProfileCubit cubit;
  @override
  void initState() {
    super.initState();
    cubit = ProfileCubit();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => cubit,
      child: SafeArea(
        child: BlocBuilder<ProfileCubit, ProfileState>(
          builder: (context, state) {
            return MartiScaffold(
              child: Text('data'),
            );
          },
        ),
      ),
    );
  }
}
