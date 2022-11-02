import 'package:dream_it_do_it/counter/counter.dart';
import 'package:dream_it_do_it/l10n/l10n.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:wishes_repository/wishes_repository.dart';

class App extends StatelessWidget {
  const App({super.key, required this.wishesRepository});

  final WishesRepository wishesRepository;

  @override
  Widget build(BuildContext context) {
    return RepositoryProvider.value(
      value: wishesRepository,
      child: const AppView(),
    );
  }
}

class AppView extends StatelessWidget {
  const AppView({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        appBarTheme: const AppBarTheme(
          color: Colors.transparent,
          elevation: 0,
        ),
        colorScheme: ColorScheme.fromSwatch(
          accentColor: const Color(0xFF13B9FF),
        ),
      ),
      localizationsDelegates: const [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
      ],
      supportedLocales: AppLocalizations.supportedLocales,
      home: const CounterPage(),
    );
  }
}
