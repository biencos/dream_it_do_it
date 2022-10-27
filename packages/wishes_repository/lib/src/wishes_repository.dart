// ignore_for_file: public_member_api_docs

import 'package:wishes_api/wishes_api.dart';

class WishesRepository {
  /// {@macro wishes_repository}
  const WishesRepository({
    required WishesApi wishesApi,
  }) : _wishesApi = wishesApi;

  final WishesApi _wishesApi;

  /// Provides a [Stream] of all wishes.
  Stream<List<Wish>> getWishes() => _wishesApi.getWishes();

  /// Saves a [wish].
  Future<void> saveWish(Wish wish) => _wishesApi.saveWish(wish);

  /// Deletes the wish with the given id.
  /// If no wish with the given id exists,
  /// a [WishNotFoundException] error is thrown.
  Future<void> deleteWish(String id) => _wishesApi.deleteWish(id);
}
