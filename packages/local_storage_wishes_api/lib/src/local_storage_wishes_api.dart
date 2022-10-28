// ignore_for_file: public_member_api_docs

import 'dart:async';
import 'dart:convert';

import 'package:meta/meta.dart';
import 'package:rxdart/subjects.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wishes_api/wishes_api.dart';

class LocalStorageWishesApi extends WishesApi {
  /// {@macro local_storage_wishes_api}
  LocalStorageWishesApi({
    required SharedPreferences plugin,
  }) : _plugin = plugin {
    _init();
  }

  final SharedPreferences _plugin;
  final _wishStreamController = BehaviorSubject<List<Wish>>.seeded(const []);

  @visibleForTesting
  static const wishesCollectionKey = '_wishes_collection_key_';

  String? _getValue(String key) => _plugin.getString(key);
  Future<void> _setValue(String key, String value) =>
      _plugin.setString(key, value);

  void _init() {
    final wishesJsonString = _getValue(wishesCollectionKey);
    if (wishesJsonString != null) {
      final wishes = List<Map<dynamic, dynamic>>.from(
        json.decode(wishesJsonString) as List,
      )
          .map((jsonMap) => Wish.fromJson(Map<String, dynamic>.from(jsonMap)))
          .toList();
      _wishStreamController.add(wishes);
    } else {
      _wishStreamController.add(const []);
    }
  }

  @override
  Stream<List<Wish>> getWishes() => _wishStreamController.asBroadcastStream();

  @override
  Future<void> saveWish(Wish wish) {
    final wishes = [..._wishStreamController.value];
    final wishIndex = wishes.indexWhere((w) => w.id == wish.id);
    if (wishIndex >= 0) {
      wishes[wishIndex] = wish;
    } else {
      wishes.add(wish);
    }

    _wishStreamController.add(wishes);
    return _setValue(wishesCollectionKey, json.encode(wishes));
  }

  @override
  Future<void> deleteWish(String id) async {
    final wishes = [..._wishStreamController.value];
    final wishIndex = wishes.indexWhere((w) => w.id == id);
    if (wishIndex == -1) {
      throw WishNotFoundException();
    } else {
      wishes.removeAt(wishIndex);
      _wishStreamController.add(wishes);
      return _setValue(wishesCollectionKey, json.encode(wishes));
    }
  }
}
