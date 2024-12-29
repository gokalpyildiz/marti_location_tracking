import 'package:flutter/material.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:marti_location_tracking/product/components/widgets/page_waiting_widget.dart';

class MartiScaffold extends StatefulWidget {
  const MartiScaffold({
    required this.child,
    super.key,
    this.appBar,
    this.floatingActionButtonLocation,
    this.floatingActionButton,
    this.bottomNavigationBar,
    this.bottomSheet,
    this.resizeToAvoidBottomInset = false,
    this.backgroundColor,
    this.extendBodyBehindAppBar = false,
    this.isLoading = false,
  });
  final Widget child;
  final Widget? floatingActionButton;
  final Widget? bottomSheet;
  final Widget? bottomNavigationBar;
  final PreferredSizeWidget? appBar;
  final bool? resizeToAvoidBottomInset;
  final Color? backgroundColor;
  final FloatingActionButtonLocation? floatingActionButtonLocation;
  final bool extendBodyBehindAppBar;
  final bool isLoading;

  @override
  State<MartiScaffold> createState() => _MartiScaffoldState();
}

class _MartiScaffoldState extends State<MartiScaffold> {
  @override
  Widget build(BuildContext context) => LoaderOverlay(
        disableBackButton: false,
        overlayColor: Colors.grey.withValues(alpha: 0.5), //context.general.colorScheme.surfaceContainer.withOpacity(0.4),
        overlayWidgetBuilder: (value) => const PageWaitingWidget(),
        child: widget.isLoading
            ? const Scaffold(
                body: Center(
                  child: CircularProgressIndicator(),
                ),
              )
            : Scaffold(
                extendBodyBehindAppBar: widget.extendBodyBehindAppBar,
                resizeToAvoidBottomInset: widget.resizeToAvoidBottomInset,
                appBar: widget.appBar,
                backgroundColor: widget.backgroundColor,
                body: widget.child,
                bottomSheet: widget.bottomSheet,
                floatingActionButton: widget.floatingActionButton,
                floatingActionButtonLocation: widget.floatingActionButtonLocation,
                bottomNavigationBar: widget.bottomNavigationBar,
              ),
      );
}
