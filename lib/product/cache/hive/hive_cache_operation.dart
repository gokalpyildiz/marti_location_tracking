import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:hive/hive.dart';
import 'package:marti_location_tracking/product/cache/base/cache_operation.dart';

class HiveCacheOperation<T> extends CacheOperation<T> {
  /// Initialize hive box
  HiveCacheOperation(String boxName) {
    _box = Hive.box<T>(boxName);
  }

  late final Box<T> _box;
  @override
  Future<void> add({required String key, required T item}) async {
    await _box.put(key, item);
  }

  @override
  Future<void> insert({required T item}) async {
    await _box.add(item);
  }

  @override
  Future<void> update({required T item, required int index}) async {
    return Future.value(_box.putAt(index, item));
  }
  //gerekli olursa hazır hale getirilebilir şu anda gerekli değil.
  // @override
  // void addAll(List<T> items) {
  //   //todo gerekli olursa cache model oluşturulup cachemodele key eklenmesi gerekir
  //    _box.putAll(Map.fromIterable(items));
  // }

  @override
  Future<void> clear() async {
    await _box.clear();
  }

  @override
  Future<T?> get(String key) async {
    try {
      var data = _box.get(key);
      return data;
    } catch (e) {
      await _box.delete(key);
      return null;
    }
  }

  @override
  Future<List<T>?> getList() async {
    return _box.values.toList();
  }
  // @override
  // List<T> getAll() {
  //   return [];
  //   //return _box.getAll(_box.keys).where((element) => element != null).cast<T>().toList();
  // }

  @override
  Future<void> remove(String key) async {
    await _box.delete(key);
  }

  @override
  Future<void> removeAt(int index) async {
    await _box.deleteAt(index);
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
