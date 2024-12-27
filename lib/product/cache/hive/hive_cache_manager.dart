import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:marti_location_tracking/product/cache/base/cache_manager.dart';
import 'package:path_provider/path_provider.dart';

/// The HiveCacheManager class is an implementation of the CacheManager class.
final class HiveCacheManager extends CacheManager {
  /// [path] is the path to the directory
  ///  where the Hive database files are stored.
  HiveCacheManager();

  @override
  Future<void> init() async {
    await setHive();
  }

  @override
  Future<void> remove() async => Hive.deleteFromDisk();

  Future<void> setHive() async {
    await setDir();
    final encryptionKey = await createEncryption();
    await setAdapters();
    await setBoxes(encryptionKey);
  }

  Future<void> setDir() async {
    try {
      // final document = await getApplicationDocumentsDirectory();
      // await Hive.initFlutter(document.path);
      const keyPath = 'hiveVersion1';
      final dbDir = await getApplicationDocumentsDirectory();
      await Hive.initFlutter('${dbDir.path}/$keyPath');
    } catch (e) {
      debugPrint('Error: $e');
    }
  }

  Future<void> setAdapters() async {}

  Future<void> setBoxes(Uint8List encryptionKey) async {
    try {} catch (e) {
      debugPrint('Error: $e');
    }
  }

  Future<Uint8List> createEncryption() async {
    const secureStorage = FlutterSecureStorage(
        aOptions: AndroidOptions(
      encryptedSharedPreferences: true,
    ));
    String? encryptionKeyString;
    try {
      encryptionKeyString = await secureStorage.read(key: 'key');
    } catch (e) {
      debugPrint('Error: $e');
    }
    if (encryptionKeyString == null) {
      final key = Hive.generateSecureKey();
      await secureStorage.write(
        key: 'key',
        value: base64UrlEncode(key),
      );
    }
    final key = await secureStorage.read(key: 'key');
    return base64Url.decode(key!);
  }
}

enum HiveBoxNames {
  userTrackingInfo('UserTrackingInfo'),
  ;

  final String value;
  const HiveBoxNames(this.value);
}

enum DatabaseKeys {
  USER_TRACKING_INFO('userTrackingInfo'),
  ;

  final String value;
  const DatabaseKeys(this.value);
}
