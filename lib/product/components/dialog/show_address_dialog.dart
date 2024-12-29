import 'package:flutter/material.dart';
import 'package:marti_location_tracking/product/components/dialog/base/dialog_base.dart';
import 'package:marti_location_tracking/product/utils/geography_functions/geography_function.dart';

/// Show a dialog for success
final class ShowAddressDialog extends StatefulWidget {
  /// Constructor for dialog
  const ShowAddressDialog({required this.latitude, required this.longitude, super.key});

  /// Title for the dialog
  final double latitude;
  final double longitude;

  /// Show the dialog for success
  /// This will always return [true]
  static Future<bool> show({
    required double latitude,
    required double longitude,
    required BuildContext context,
  }) async {
    await DialogBase.show<bool>(
      context: context,
      builder: (context) => ShowAddressDialog(latitude: latitude, longitude: longitude),
    );
    return true;
  }

  @override
  State<ShowAddressDialog> createState() => _ShowAddressDialogState();
}

class _ShowAddressDialogState extends State<ShowAddressDialog> {
  bool isLoading = true;
  GeographyFunction geographyFunction = GeographyFunction.instance;
  late String address;
  @override
  void initState() {
    super.initState();
    getAddress();
  }

  Future<void> getAddress() async {
    address = await geographyFunction.getAddress(latitude: widget.latitude, longitude: widget.longitude);
    isLoading = false;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog.adaptive(
      title: isLoading ? Center(child: CircularProgressIndicator.adaptive()) : Text(address),
      actions: [
        IconButton(
          onPressed: () {
            Navigator.of(context).pop(true);
          },
          icon: const Icon(Icons.check),
        ),
      ],
    );
  }
}
