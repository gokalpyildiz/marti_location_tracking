import 'package:flutter/material.dart';
import 'package:marti_location_tracking/product/components/dialog/base/dialog_base.dart';

/// Show a dialog for success
final class InfoDialog extends StatelessWidget {
  /// Constructor for dialog
  const InfoDialog({required this.title, required this.onTapOk, super.key});

  /// Title for the dialog
  final String title;
  final Future<void> Function()? onTapOk;

  /// Show the dialog for success
  /// This will always return [true]
  static Future<bool> show({
    required String title,
    required BuildContext context,
    required Future<void> Function()? onTapOk,
  }) async {
    await DialogBase.show<bool>(
      context: context,
      builder: (context) => InfoDialog(title: title, onTapOk: onTapOk),
    );
    return true;
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog.adaptive(
      title: Text(title),
      actions: [
        IconButton(
          onPressed: () {
            onTapOk?.call();
            Navigator.of(context).pop(true);
          },
          icon: const Icon(Icons.check),
        ),
      ],
    );
  }
}
