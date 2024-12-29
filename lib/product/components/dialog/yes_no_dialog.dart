import 'package:flutter/material.dart';
import 'package:marti_location_tracking/product/components/dialog/base/dialog_base.dart';
import 'package:marti_location_tracking/product/utils/extensions/context_extension.dart';

final class YesNoDialog extends StatefulWidget {
  const YesNoDialog({
    required this.title,
    required this.onYes,
    super.key,
    this.description,
    this.yesButtonText,
    this.noButtonText,
    this.onNo,
    this.descriptionWidget,
  });

  final String title;
  final String? description;
  final Widget? descriptionWidget;
  final String? yesButtonText;
  final String? noButtonText;
  final Future<void> Function() onYes;
  final Function? onNo;

  static Future<bool?> show({
    required String title,
    required BuildContext context,
    required Future<void> Function() onYes,
    String? description,
    Widget? descriptionWidget,
    String? yesButtonText,
    String? noButtonText,
    Function? onNo,
  }) async =>
      DialogBase.show<bool>(
        context: context,
        builder: (context) => YesNoDialog(
          title: title,
          description: description,
          descriptionWidget: descriptionWidget,
          onYes: onYes,
          onNo: onNo,
          yesButtonText: yesButtonText,
          noButtonText: noButtonText,
        ),
      );

  @override
  State<YesNoDialog> createState() => _YesNoDialogState();
}

class _YesNoDialogState extends State<YesNoDialog> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;
  late ValueNotifier<bool> isLoading;
  @override
  void initState() {
    super.initState();
    isLoading = ValueNotifier<bool>(false);
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 150),
    );
    _scaleAnimation = Tween<double>(begin: 0.2, end: 1.0).animate(
      _controller,
    );
    _controller.forward();
  }

  @override
  Widget build(BuildContext context) {
    return ScaleTransition(
      scale: _scaleAnimation,
      child: AlertDialog.adaptive(
        //todo change color from theme
        backgroundColor: Colors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        elevation: 0,
        title: Text(
          widget.title,
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: widget.description != null ? 18 : 20,
            fontWeight: widget.description != null ? FontWeight.w700 : FontWeight.w500,
          ),
        ),
        content: widget.descriptionWidget ??
            (widget.description != null
                ? Text(
                    widget.description!,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 14,
                      color: context.colorScheme.onSurfaceVariant,
                    ),
                  )
                : null),
        actions: [
          ValueListenableBuilder(
            valueListenable: isLoading,
            builder: (context, value, child) {
              if (isLoading.value) {
                return CircularProgressIndicator();
              }
              return TextButton(
                onPressed: () async {
                  isLoading.value = true;
                  await widget.onYes();
                  isLoading.value = false;
                  if (context.mounted) {
                    Navigator.of(context).pop(true);
                  }
                },
                //todo translate and change color from theme
                child: Text(
                  widget.yesButtonText ?? 'Evet',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: context.colorScheme.secondary,
                  ),
                ),
              );
            },
          ),
          TextButton(
            onPressed: () {
              Navigator.of(context).pop(false);
            },
            child: Text(
              widget.noButtonText ?? 'Hayır',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: context.colorScheme.secondary,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
