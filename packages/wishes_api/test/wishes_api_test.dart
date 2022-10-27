import 'package:test/test.dart';
import 'package:wishes_api/wishes_api.dart';

class TestWishesApi extends WishesApi {
  TestWishesApi() : super();

  @override
  dynamic noSuchMethod(Invocation invocation) {
    return super.noSuchMethod(invocation);
  }
}

void main() {
  test('WishesApi works correctly', () {
    expect(TestWishesApi.new, returnsNormally);
  });
}
