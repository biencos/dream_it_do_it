import 'package:dream_it_do_it/l10n/l10n.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:sizer/sizer.dart';
import 'package:wishes_repository/wishes_repository.dart';

class MockWishesRepository extends Mock implements WishesRepository {}

extension PumpApp on WidgetTester {
  Future<void> pumpApp(
    Widget widget, {
    WishesRepository? wishesRepository,
  }) {
    return pumpWidget(
      Sizer(
        builder: (context, orientation, deviceType) {
          return RepositoryProvider.value(
            value: wishesRepository ?? MockWishesRepository(),
            child: MaterialApp(
              localizationsDelegates: const [
                AppLocalizations.delegate,
                GlobalMaterialLocalizations.delegate,
              ],
              supportedLocales: AppLocalizations.supportedLocales,
              home: widget,
            ),
          );
        },
      ),
    );
  }
}
