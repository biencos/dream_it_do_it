import 'package:mocktail/mocktail.dart';
import 'package:test/test.dart';
import 'package:wishes_api/wishes_api.dart';
import 'package:wishes_repository/wishes_repository.dart';

class MockWishesApi extends Mock implements WishesApi {}

class FakeWish extends Fake implements Wish {}

void main() {
  group('WishesRepository', () {
    late WishesApi api;

    setUpAll(() {
      registerFallbackValue(FakeWish());
    });

    final wishes = [
      Wish(id: 'id_1', title: 'title_1'),
      Wish(id: 'id_2', title: 'title_2', isCompleted: true),
    ];

    setUp(() {
      api = MockWishesApi();
      when(() => api.getWishes()).thenAnswer((_) => Stream.value(wishes));
      when(() => api.saveWish(any())).thenAnswer((_) async {});
      when(() => api.deleteWish(any())).thenAnswer((_) async {});
    });

    WishesRepository createRepoMock() => WishesRepository(wishesApi: api);

    test('constructor works correctly', () {
      expect(
        createRepoMock,
        returnsNormally,
      );
    });

    group('getWishes', () {
      test('makes correct api request', () {
        expect(
          createRepoMock().getWishes(),
          isNot(throwsA(anything)),
        );

        verify(() => api.getWishes()).called(1);
      });

      test('returns stream of current list of wishes', () {
        expect(
          createRepoMock().getWishes(),
          emits(wishes),
        );
      });
    });

    test('saveWish makes correct api request', () {
      final newWish = Wish(id: 'id_3', title: 'title_3');

      expect(
        createRepoMock().saveWish(newWish),
        completes,
      );

      verify(() => api.saveWish(newWish)).called(1);
    });

    test('deleteWish makes correct api request', () {
      expect(
        createRepoMock().deleteWish(wishes[0].id),
        completes,
      );

      verify(() => api.deleteWish(wishes[0].id)).called(1);
    });
  });
}
