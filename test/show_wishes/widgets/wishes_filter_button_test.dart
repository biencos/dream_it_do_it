import 'package:bloc_test/bloc_test.dart';
import 'package:custom_sliding_segmented_control/custom_sliding_segmented_control.dart';
import 'package:dream_it_do_it/show_wishes/show_wishes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../helpers/helpers.dart';

class MockShowWishesBloc extends MockBloc<ShowWishesEvent, ShowWishesState>
    implements ShowWishesBloc {}

void main() {
  group('WishesFilterButton', () {
    late ShowWishesBloc showWishesBloc;

    setUp(() {
      showWishesBloc = MockShowWishesBloc();
      when(() => showWishesBloc.state).thenReturn(
        const ShowWishesState(
          status: ShowWishesStatus.success,
          // ignore: avoid_redundant_argument_values
          wishes: [],
        ),
      );
    });

    Widget createButtonMock() {
      return BlocProvider.value(
        value: showWishesBloc,
        child: const WishesFilterButton(),
      );
    }

    test('constructor works properly', () {
      expect(
        () => const WishesFilterButton(),
        returnsNormally,
      );
    });

    testWidgets('renders To Do toggle', (tester) async {
      await tester.pumpApp(createButtonMock());

      expect(
        find.text(l10n.showWishesAppBarToDoToggleTitle),
        findsOneWidget,
      );
    });

    testWidgets('renders Done toggle', (tester) async {
      await tester.pumpApp(createButtonMock());

      expect(
        find.text(l10n.showWishesAppBarDoneToggleTitle),
        findsOneWidget,
      );
    });

    testWidgets('has initial value set to active filter', (tester) async {
      when(() => showWishesBloc.state).thenReturn(
        const ShowWishesState(
          // ignore: avoid_redundant_argument_values
          filter: WishesViewFilter.activeOnly,
        ),
      );

      await tester.pumpApp(createButtonMock());

      final wishesFilterButton =
          tester.widget<CustomSlidingSegmentedControl<WishesViewFilter>>(
        find.byType(CustomSlidingSegmentedControl<WishesViewFilter>),
      );
      expect(
        wishesFilterButton.initialValue,
        equals(WishesViewFilter.activeOnly),
      );
    });

    testWidgets(
      'adds WishesFilterChanged to ShowWishesBloc when new filter is pressed',
      (tester) async {
        when(() => showWishesBloc.state).thenReturn(
          const ShowWishesState(
            // ignore: avoid_redundant_argument_values
            filter: WishesViewFilter.activeOnly,
          ),
        );

        await tester.pumpApp(createButtonMock());

        await tester.tap(find.text(l10n.showWishesAppBarDoneToggleTitle));
        await tester.pumpAndSettle();

        verify(
          () => showWishesBloc.add(
            const WishesFilterChanged(WishesViewFilter.completedOnly),
          ),
        ).called(1);
      },
    );
  });
}
