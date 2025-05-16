import 'package:get_it/get_it.dart';
import 'domain/liked_cats_provider.dart';

final getIt = GetIt.instance;

void setupDependencies() {
  getIt.registerLazySingleton<LikedCatsNotifier>(() => LikedCatsNotifier());
}
