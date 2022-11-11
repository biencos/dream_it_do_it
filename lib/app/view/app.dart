import 'package:dream_it_do_it/l10n/l10n.dart';
import 'package:dream_it_do_it/show_wishes/show_wishes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:sizer/sizer.dart';
import 'package:wishes_repository/wishes_repository.dart';

class App extends StatelessWidget {
  const App({super.key, required this.wishesRepository});

  final WishesRepository wishesRepository;

  @override
  Widget build(BuildContext context) {
    return Sizer(
      builder: (context, orientation, deviceType) {
        return RepositoryProvider.value(
          value: wishesRepository,
          child: const AppView(),
        );
      },
    );
  }
}

class AppView extends StatelessWidget {
  const AppView({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        appBarTheme: const AppBarTheme(
          color: Colors.transparent,
          elevation: 0,
        ),
        colorScheme: const ColorScheme.light(
          secondary: Color(0xFF00E7F5),
        ),
      ),
      localizationsDelegates: const [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
      ],
      supportedLocales: AppLocalizations.supportedLocales,
      home: const ShowWishesPage(),
    );
  }
}
