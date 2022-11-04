import 'package:dream_it_do_it/app/app.dart';
import 'package:dream_it_do_it/show_wishes/view/view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:wishes_repository/wishes_repository.dart';

import '../../helpers/helpers.dart';

void main() {
  late WishesRepository wishesRepository;

  setUp(() {
    wishesRepository = MockWishesRepository();
    when(
      () => wishesRepository.getWishes(),
    ).thenAnswer((_) => const Stream.empty());
  });

  group('App', () {
    testWidgets('renders AppView', (tester) async {
      await tester.pumpWidget(
        App(wishesRepository: wishesRepository),
      );

      expect(find.byType(AppView), findsOneWidget);
    });
  });

  group('AppView', () {
    testWidgets('renders MaterialApp', (tester) async {
      await tester.pumpWidget(
        App(wishesRepository: wishesRepository),
      );

      expect(find.byType(MaterialApp), findsOneWidget);
    });

    testWidgets('renders ShowWishesPage', (tester) async {
      await tester.pumpWidget(
        App(wishesRepository: wishesRepository),
      );

      expect(find.byType(ShowWishesPage), findsOneWidget);
    });
  });
}
