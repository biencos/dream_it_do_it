import 'package:bloc_test/bloc_test.dart';
import 'package:dream_it_do_it/add_wish/add_wish.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockingjay/mockingjay.dart';
import 'package:wishes_repository/wishes_repository.dart';

import '../../helpers/helpers.dart';

class MockAddWishBloc extends MockBloc<AddWishEvent, AddWishState>
    implements AddWishBloc {}

void main() {
  final mockWish = Wish(id: 'id_1', title: 'title_1');

  late MockNavigator navigator;
  late AddWishBloc addWishBloc;

  setUp(() {
    navigator = MockNavigator();
    when(() => navigator.push<void>(any())).thenAnswer((_) async {});

    addWishBloc = MockAddWishBloc();
    when(() => addWishBloc.state).thenReturn(
      AddWishState(title: mockWish.title),
    );
  });

  group('AddWishPage', () {
    Widget createPageMock() {
      return MockNavigatorProvider(
        navigator: navigator,
        child: BlocProvider.value(
          value: addWishBloc,
          child: const AddWishPage(),
        ),
      );
    }

    testWidgets('renders AddWishView', (tester) async {
      await tester.pumpApp(createPageMock());
      expect(find.byType(AddWishView), findsOneWidget);
    });
  });

  group('AddWishView', () {
    Widget createPageMock() {
      return MockNavigatorProvider(
        navigator: navigator,
        child: BlocProvider.value(
          value: addWishBloc,
          child: const AddWishView(),
        ),
      );
    }

    group('WishTitleField', () {
      const fieldKey = Key('addWishView_title_textFormField');

      testWidgets('is rendered', (tester) async {
        await tester.pumpApp(createPageMock());

        expect(find.byKey(fieldKey), findsOneWidget);
      });

      testWidgets('is disabled when loading', (tester) async {
        when(() => addWishBloc.state).thenReturn(
          const AddWishState(status: AddWishStatus.loading),
        );
        await tester.pumpApp(createPageMock());

        final field = tester.widget<TextFormField>(find.byKey(fieldKey));
        expect(field.enabled, false);
      });

      testWidgets(
        'adds AddWishTitleChanged to AddWishBloc '
        'when a new value is entered',
        (tester) async {
          await tester.pumpApp(createPageMock());
          await tester.enterText(
            find.byKey(fieldKey),
            'new_wish_title',
          );

          verify(
            () => addWishBloc.add(const AddWishTitleChanged('new_wish_title')),
          ).called(1);
        },
      );
    });

    group('ConfirmIconButton', () {
      const buttonKey = Key('addWishView_confirm_GestureDetector');

      testWidgets('is rendered', (tester) async {
        await tester.pumpApp(createPageMock());

        expect(
          find.descendant(
            of: find.byKey(buttonKey),
            matching: find.byIcon(Icons.send_rounded),
          ),
          findsOneWidget,
        );
      });

      testWidgets(
        'adds AddWishSubmitted to AddWishBloc when tapped',
        (tester) async {
          await tester.pumpApp(createPageMock());

          await tester.tap(find.byKey(buttonKey));

          verify(() => addWishBloc.add(const AddWishSubmitted())).called(1);
        },
      );
    });
  });
}
