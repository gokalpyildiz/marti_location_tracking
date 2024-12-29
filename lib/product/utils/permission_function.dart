import 'dart:async';

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:marti_location_tracking/product/components/dialog/yes_no_dialog.dart';

class PermissionFunction {
  PermissionFunction._init();
  static final PermissionFunction _instance = PermissionFunction._init();
  static PermissionFunction get instance => _instance;

  Future<bool> checkLocationPermission(BuildContext context, {bool? permissionIsRequired = true}) async {
    bool serviceEnabled;
    LocationPermission permission;
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      // await showServiceEnabledWarningDialog(context: context);
      if (context.mounted) {
        await YesNoDialog.show(
            title: 'İzin Ver',
            context: context,
            onYes: () async {
              await Geolocator.openLocationSettings();
            });
      }
    }
    permission = await Geolocator.checkPermission();
    if (permission != LocationPermission.always) {
      permission = await Geolocator.requestPermission();
      if (permission != LocationPermission.always) {
        if (permissionIsRequired!) {
          // await showServiceDeniedWarningDialog(context: context);
          if (context.mounted) {
            await YesNoDialog.show(
                //todo translate
                title: 'Background location is not enabled',
                description: 'To use background location, you must enable Alway in the Location Services settings',
                context: context,
                yesButtonText: 'Settings',
                noButtonText: 'Cancel',
                onYes: () async {
                  await Geolocator.openLocationSettings();
                });
          }
        } else {
          return false;
        }
      } else if (permission == LocationPermission.deniedForever) {
        if (permissionIsRequired!) {
          // await showServiceDeniedWarningDialog(context: context);
          if (context.mounted) {
            await YesNoDialog.show(title: 'Setting', context: context, onYes: () async {});
          }
        } else {
          return false;
        }
      }
    } else {
      return true;
    }
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.always) {
      return true;
    } else {
      return false;
    }
  }
}
