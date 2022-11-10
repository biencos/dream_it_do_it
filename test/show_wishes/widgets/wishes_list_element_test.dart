import 'package:dream_it_do_it/show_wishes/show_wishes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:wishes_repository/wishes_repository.dart';

import '../../helpers/helpers.dart';

void main() {
  group('WishesListElement', () {
    final uncompletedWish = Wish(id: 'id_1', title: 'title_1');
    final completedWish = Wish(id: 'id_1', title: 'title_1', isCompleted: true);
    final onToggleCompletedCalls = <bool>[];
    final dismissibleKey = Key(
      'wishesListElement_dismissible_${uncompletedWish.id}',
    );

    late int onDismissedCallCount;

    Widget createElementMock({Wish? wish}) {
      return WishesListElement(
        wish: wish ?? uncompletedWish,
        onToggleCompleted: onToggleCompletedCalls.add,
        onDismissed: (_) => onDismissedCallCount++,
      );
    }

    setUp(() {
      onDismissedCallCount = 0;
    });

    test('constructor works properly', () {
      expect(
        () => WishesListElement(wish: uncompletedWish),
        returnsNormally,
      );
    });

    group('dismissible', () {
      testWidgets('is rendered', (tester) async {
        await tester.pumpApp(createElementMock());

        expect(find.byType(Dismissible), findsOneWidget);
        expect(find.byKey(dismissibleKey), findsOneWidget);
      });

      testWidgets('calls onDismissed when swiped to the left', (tester) async {
        await tester.pumpApp(createElementMock());

        await tester.fling(
          find.byKey(dismissibleKey),
          const Offset(-300, 0),
          3000,
        );
        await tester.pumpAndSettle();

        expect(onDismissedCallCount, equals(1));
      });
    });

    group('checkbox', () {
      testWidgets('is rendered', (tester) async {
        await tester.pumpApp(createElementMock());

        expect(find.byType(Checkbox), findsOneWidget);
      });

      testWidgets('is checked when wish is completed', (tester) async {
        await tester.pumpApp(
          createElementMock(wish: completedWish),
        );

        final checkbox = tester.widget<Checkbox>(find.byType(Checkbox));
        expect(checkbox.value, isTrue);
      });

      testWidgets('is unchecked when wish is not completed', (tester) async {
        await tester.pumpApp(
          createElementMock(wish: uncompletedWish),
        );

        final checkbox = tester.widget<Checkbox>(find.byType(Checkbox));
        expect(checkbox.value, isFalse);
      });

      testWidgets(
        'calls onToggleCompleted with correct value when tapped',
        (tester) async {
          await tester.pumpApp(createElementMock(wish: uncompletedWish));

          await tester.tap(find.byType(Checkbox));

          expect(onToggleCompletedCalls, equals([true]));
        },
      );
    });

    group('wish title', () {
      testWidgets('is rendered', (tester) async {
        await tester.pumpApp(createElementMock());

        expect(find.text(uncompletedWish.title), findsOneWidget);
      });

      testWidgets('is struckthrough when wish is completed', (tester) async {
        await tester.pumpApp(
          createElementMock(wish: completedWish),
        );

        final titleText = tester.widget<Text>(find.text(completedWish.title));
        expect(
          titleText.style,
          isA<TextStyle>().having(
            (s) => s.decoration,
            'decoration',
            TextDecoration.lineThrough,
          ),
        );
      });
    });
  });
}
