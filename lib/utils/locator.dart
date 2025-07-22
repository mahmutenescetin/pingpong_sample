import 'package:get_it/get_it.dart';
import 'package:pingpong_sample/common/repositories/app_repository.dart';
import 'package:pingpong_sample/services/local/shared_preference_service.dart';

final locator = GetIt.asNewInstance();

void setupDependencyInjection() {
  locator.registerLazySingleton<SharedPreferenceService>(
    () => SharedPreferenceService(),
  );

  locator.registerLazySingleton<AppRepository>(() => AppRepository());
}

void disposeDependencyInjection() {
  locator.reset();
}
