// ignore_for_file: public_member_api_docs

import 'package:wishes_api/wishes_api.dart';

abstract class WishesApi {
  /// {@macro wishes_api}
  const WishesApi();

  /// Provides a [Stream] of all wishes.
  Stream<List<Wish>> getWishes();

  /// Saves a [wish].
  Future<void> saveWish(Wish wish);

  /// Deletes the wish with the given id.
  /// If no wish with the given id exists,
  /// a [WishNotFoundException] error is thrown.
  Future<void> deleteWish(String id);
}

/// Error thrown when a [Wish] with a given id is not found.
class WishNotFoundException implements Exception {}
