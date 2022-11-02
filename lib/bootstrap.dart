import 'dart:async';
import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:dream_it_do_it/app/view/app.dart';
import 'package:flutter/widgets.dart';
import 'package:wishes_api/wishes_api.dart';
import 'package:wishes_repository/wishes_repository.dart';

class AppBlocObserver extends BlocObserver {
  @override
  void onChange(BlocBase<dynamic> bloc, Change<dynamic> change) {
    super.onChange(bloc, change);
    log('onChange(${bloc.runtimeType}, $change)');
  }

  @override
  void onError(BlocBase<dynamic> bloc, Object error, StackTrace stackTrace) {
    log('onError(${bloc.runtimeType}, $error, $stackTrace)');
    super.onError(bloc, error, stackTrace);
  }
}

void bootstrap({required WishesApi wishesApi}) {
  FlutterError.onError = (details) {
    log(details.exceptionAsString(), stackTrace: details.stack);
  };

  Bloc.observer = AppBlocObserver();

  final wishesRepository = WishesRepository(wishesApi: wishesApi);

  runZonedGuarded(
    () => runApp(App(wishesRepository: wishesRepository)),
    (error, stackTrace) => log(error.toString(), stackTrace: stackTrace),
  );
}
