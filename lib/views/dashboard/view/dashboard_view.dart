import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:marti_location_tracking/product/navigation/app_router_handler.gr.dart';
import 'package:marti_location_tracking/product/state/container/product_state_items.dart';
import 'package:marti_location_tracking/product/utils/extensions/context_extension.dart';
import 'package:marti_location_tracking/views/dashboard/viewmodel/dashboard_cubit.dart';

@RoutePage()
class DashBoardView extends StatefulWidget {
  const DashBoardView({super.key});
  @override
  State<DashBoardView> createState() => _DashBoardViewState();
}

class _DashBoardViewState extends State<DashBoardView> {
  final GlobalKey<AutoTabsRouterState> _bottomBarKey = GlobalKey<AutoTabsRouterState>();

  @override
  Widget build(BuildContext context) {
    final activeColor = context.colorScheme.secondary;
    final locationCubit = ProductStateItems.locationTrackingCubit;
    return BlocProvider.value(
      value: ProductStateItems.dashboardCubit,
      child: BlocBuilder<DashboardCubit, DashboardState>(
        builder: (context, state) => AutoTabsScaffold(
          routes: [
            const LocationTrackingRoute(),
            const ProfileRoute(),
          ],
          lazyLoad: true,
          transitionBuilder: (context, child, animation) {
            return FadeTransition(
              opacity: animation,
              child: child,
            );
          },
          floatingActionButton: FloatingActionButton(
            onPressed: () async {
              final tabsRouter = _bottomBarKey.currentContext?.tabsRouter;
              //if not on location page go to location page
              if (tabsRouter?.activeIndex != 0) {
                tabsRouter?.setActiveIndex(0);
                return;
              }
              locationCubit.showPausedButtons();
            },
            child: Icon(Icons.play_arrow, color: context.colorScheme.primary),
          ),
          floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
          bottomNavigationBuilder: (context, tabsRouter) {
            return BottomNavigationBar(
              key: _bottomBarKey,
              currentIndex: tabsRouter.activeIndex,
              selectedItemColor: activeColor,
              selectedFontSize: 13,
              unselectedFontSize: 11,
              elevation: 0,
              type: BottomNavigationBarType.fixed,
              onTap: (index) {
                if (index == 1) {
                  ProductStateItems.profileCubit.refreshDatas();
                }
                tabsRouter.setActiveIndex(index);
              },
              backgroundColor: context.colorScheme.primary,
              items: [
                BottomNavigationBarItem(
                  icon: Icon(
                    Icons.location_on,
                    size: 40,
                    color: context.colorScheme.onPrimaryContainer,
                  ),
                  activeIcon: Icon(Icons.location_on, color: context.colorScheme.primaryContainer, size: 40),
                  label: '',
                ),
                BottomNavigationBarItem(
                  icon: Icon(
                    Icons.person_2,
                    size: 40,
                    color: context.colorScheme.onPrimaryContainer,
                  ),
                  activeIcon: Icon(Icons.person_2, color: context.colorScheme.primaryContainer, size: 40),
                  label: '',
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
