import 'package:bloc_test/bloc_test.dart';
import 'package:dream_it_do_it/show_wishes/show_wishes.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockingjay/mockingjay.dart';
import 'package:wishes_repository/wishes_repository.dart';

import '../../helpers/helpers.dart';

class MockWishesRepository extends Mock implements WishesRepository {}

class MockShowWishesBloc extends MockBloc<ShowWishesEvent, ShowWishesState>
    implements ShowWishesBloc {}

void main() {
  final mockWishes = [
    Wish(id: 'id_1', title: 'title_1'),
    Wish(id: 'id_2', title: 'title_2'),
  ];

  late WishesRepository wishesRepository;

  group('ShowWishesPage', () {
    setUp(() {
      wishesRepository = MockWishesRepository();
      when(wishesRepository.getWishes).thenAnswer((_) => const Stream.empty());
    });

    testWidgets('renders ShowWishesView', (tester) async {
      await tester.pumpApp(
        const ShowWishesPage(),
        wishesRepository: wishesRepository,
      );

      expect(find.byType(ShowWishesView), findsOneWidget);
    });

    testWidgets(
      'subscribes to wishes from repository on initialization',
      (tester) async {
        await tester.pumpApp(
          const ShowWishesPage(),
          wishesRepository: wishesRepository,
        );

        verify(() => wishesRepository.getWishes()).called(1);
      },
    );
  });

  group('ShowWishesView', () {
    late MockNavigator navigator;
    late ShowWishesBloc showWishesBloc;

    setUp(() {
      navigator = MockNavigator();
      when(() => navigator.push<void>(any())).thenAnswer((_) async {});

      showWishesBloc = MockShowWishesBloc();
      when(() => showWishesBloc.state).thenReturn(
        ShowWishesState(
          status: ShowWishesStatus.success,
          wishes: mockWishes,
        ),
      );

      wishesRepository = MockWishesRepository();
      when(wishesRepository.getWishes).thenAnswer((_) => const Stream.empty());
    });

    Widget createViewMock() {
      return MockNavigatorProvider(
        navigator: navigator,
        child: BlocProvider.value(
          value: showWishesBloc,
          child: const ShowWishesView(),
        ),
      );
    }

    testWidgets(
      'renders AppBar with title text',
      (tester) async {
        await tester.pumpApp(
          createViewMock(),
          wishesRepository: wishesRepository,
        );

        expect(find.byType(AppBar), findsOneWidget);

        expect(
          find.descendant(
            of: find.byType(AppBar),
            matching: find.text(l10n.showWishesAppBarTitle),
          ),
          findsOneWidget,
        );
      },
    );

    group('when wishes is empty', () {
      setUp(() {
        when(
          () => showWishesBloc.state,
        ).thenReturn(const ShowWishesState());
      });

      testWidgets(
        'renders nothing '
        'when status is initial or error',
        (tester) async {
          await tester.pumpApp(
            createViewMock(),
            wishesRepository: wishesRepository,
          );

          expect(find.byType(ListView), findsNothing);
          expect(find.byType(CupertinoActivityIndicator), findsNothing);
        },
      );

      testWidgets(
        'renders loading indicator '
        'when status is loading',
        (tester) async {
          when(() => showWishesBloc.state).thenReturn(
            const ShowWishesState(status: ShowWishesStatus.loading),
          );

          await tester.pumpApp(
            createViewMock(),
            wishesRepository: wishesRepository,
          );

          expect(find.byType(CupertinoActivityIndicator), findsOneWidget);
        },
      );

      testWidgets(
        'renders wishes empty text '
        'when status is success',
        (tester) async {
          when(() => showWishesBloc.state).thenReturn(
            const ShowWishesState(
              status: ShowWishesStatus.success,
            ),
          );

          await tester.pumpApp(
            createViewMock(),
            wishesRepository: wishesRepository,
          );

          expect(find.text(l10n.showWishesNoWishesText), findsOneWidget);
        },
      );
    });

    group('when wishes is not empty', () {
      setUp(() {
        when(() => showWishesBloc.state).thenReturn(
          ShowWishesState(
            status: ShowWishesStatus.success,
            wishes: mockWishes,
          ),
        );
      });

      testWidgets('renders ListView with WishesListElements', (tester) async {
        await tester.pumpApp(
          createViewMock(),
          wishesRepository: wishesRepository,
        );

        expect(find.byType(ListView), findsOneWidget);
        expect(
          find.byType(WishesListElement),
          findsNWidgets(mockWishes.length),
        );
      });
    });

    testWidgets(
      'renders FloatingActionButton with add rounded icon',
      (tester) async {
        await tester.pumpApp(
          createViewMock(),
          wishesRepository: wishesRepository,
        );

        expect(find.byType(FloatingActionButton), findsOneWidget);

        expect(
          find.descendant(
            of: find.byType(FloatingActionButton),
            matching: find.byIcon(Icons.add_rounded),
          ),
          findsOneWidget,
        );
      },
    );
  });
}
