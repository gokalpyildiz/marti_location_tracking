import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:marti_location_tracking/product/assets/asset.dart';
import 'package:marti_location_tracking/product/components/base_widgets/marti_scaffold.dart';
import 'package:marti_location_tracking/product/model/location_store_response_model.dart';
import 'package:marti_location_tracking/product/navigation/app_router_handler.gr.dart';
import 'package:marti_location_tracking/product/state/container/product_state_items.dart';
import 'package:marti_location_tracking/product/utils/extensions/context_extension.dart';
import 'package:marti_location_tracking/product/utils/extensions/date_time_extension.dart';
import 'package:marti_location_tracking/views/profile/viewmodel/profile_cubit.dart';

part 'subwidgets/activity_item_card.dart';

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
    cubit = ProductStateItems.profileCubit;
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: cubit,
      child: SafeArea(
        child: BlocBuilder<ProfileCubit, ProfileState>(
          builder: (context, state) {
            final cubit = context.read<ProfileCubit>();
            final allActivities = cubit.locationStoreModelList;
            return MartiScaffold(
              appBar: AppBar(
                title: Text('Aktivities'),
                centerTitle: true,
              ),
              child: ListView.builder(
                  itemCount: allActivities.length,
                  padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 15.0),
                  shrinkWrap: true,
                  reverse: true,
                  itemBuilder: (BuildContext context, int index) {
                    final activity = allActivities[index];
                    return _ActivityItemCard(activity: activity!, index: index);
                  }),
            );
          },
        ),
      ),
    );
  }
}
