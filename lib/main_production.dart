import 'package:dream_it_do_it/bootstrap.dart';
import 'package:flutter/widgets.dart';
import 'package:local_storage_wishes_api/local_storage_wishes_api.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final wishesApi = LocalStorageWishesApi(
    plugin: await SharedPreferences.getInstance(),
  );

  bootstrap(wishesApi: wishesApi);
}
