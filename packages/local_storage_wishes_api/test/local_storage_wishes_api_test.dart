import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:local_storage_wishes_api/local_storage_wishes_api.dart';
import 'package:mocktail/mocktail.dart';
import 'package:wishes_api/wishes_api.dart';

class MockSharedPreferences extends Mock implements SharedPreferences {}

void main() {
  group('LocalStorageWishesApi', () {
    late SharedPreferences plugin;

    final wishes = [
      Wish(id: 'id_1', title: 'title_1'),
      Wish(id: 'id_2', title: 'title_2', isCompleted: true),
    ];

    setUp(() {
      plugin = MockSharedPreferences();
      when(() => plugin.getString(any())).thenReturn(json.encode(wishes));
      when(() => plugin.setString(any(), any())).thenAnswer((_) async => true);
    });

    LocalStorageWishesApi createApiMock() {
      return LocalStorageWishesApi(plugin: plugin);
    }

    test('constructor works correctly', () {
      expect(
        createApiMock,
        returnsNormally,
      );
    });

    group('initializes the wishes stream', () {
      test('with existing wishes if present', () {
        expect(createApiMock().getWishes(), emits(wishes));

        verify(
          () => plugin.getString(
            LocalStorageWishesApi.wishesCollectionKey,
          ),
        ).called(1);
      });

      test('with empty list if no wishes present', () {
        when(() => plugin.getString(any())).thenReturn(null);

        expect(createApiMock().getWishes(), emits(const <Wish>[]));

        verify(
          () => plugin.getString(
            LocalStorageWishesApi.wishesCollectionKey,
          ),
        ).called(1);
      });
    });

    test('getWishes returns stream of current list of wishes', () {
      expect(
        createApiMock().getWishes(),
        emits(wishes),
      );
    });

    test('saveWish saves new wish', () {
      final newWish = Wish(id: 'id_3', title: 'title_3');
      final newWishes = [...wishes, newWish];
      final apiMock = createApiMock();

      expect(apiMock.saveWish(newWish), completes);
      expect(apiMock.getWishes(), emits(newWishes));

      verify(
        () => plugin.setString(
          LocalStorageWishesApi.wishesCollectionKey,
          json.encode(newWishes),
        ),
      ).called(1);
    });

    group('deleteWish', () {
      test('deletes existing wish', () {
        final newWishes = wishes.sublist(1);
        final apiMock = createApiMock();

        expect(apiMock.deleteWish(wishes[0].id), completes);
        expect(apiMock.getWishes(), emits(newWishes));

        verify(
          () => plugin.setString(
            LocalStorageWishesApi.wishesCollectionKey,
            json.encode(newWishes),
          ),
        ).called(1);
      });

      test(
        'throws WishNotFoundException if wish with given id is not found',
        () {
          expect(
            () => createApiMock().deleteWish('non_existing_id'),
            throwsA(isA<WishNotFoundException>()),
          );
        },
      );
    });
  });
}
