import 'package:dio/dio.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get_it/get_it.dart';
import 'package:i_pharaoh/core/helpers/api/api_client.dart';
import 'package:i_pharaoh/core/utils/localization/app_localization.dart';
import 'package:i_pharaoh/features/authentication/data/repository/auth_repository.dart';
import 'package:i_pharaoh/features/authentication/domain/use_case/sign_in_use_case.dart';
import 'package:i_pharaoh/features/authentication/domain/use_case/sign_in_with_google_use_case.dart';
import 'package:i_pharaoh/features/authentication/domain/use_case/sign_up_use_case.dart';
import 'package:i_pharaoh/features/authentication/domain/use_case/sign_up_with_google_use_case.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../helpers/cache/cache_helper.dart';

final sl = GetIt.instance;

Future<void> init() async {
  // region firebase auth
  sl.registerLazySingleton<FirebaseAuth>(() => FirebaseAuth.instance);
  // #endregion

  // #region api
  sl.registerLazySingleton<Dio>(() => Dio());
  sl.registerLazySingleton<ApiClient>(() => ApiClient(sl.get()));
  // #endregion

  // #region localization
  sl.registerLazySingleton<AppLanguage>(() => AppLanguage());
  // #region authentication
  sl.registerLazySingleton<AuthRepository>(() => AuthRepository());
  sl.registerLazySingleton<SignInUseCase>(() => SignInUseCase(sl.get()));
  sl.registerLazySingleton<SignInWithGoogleUseCase>(
      () => SignInWithGoogleUseCase(sl.get()));
  sl.registerLazySingleton<SignUpWithGoogleUseCase>(
      () => SignUpWithGoogleUseCase(sl.get()));
  sl.registerLazySingleton<SignUpUseCase>(() => SignUpUseCase(sl.get()));
  // #endregion

  // #region cache
  final SharedPreferences sharedPreferences =
      await SharedPreferences.getInstance();
  sl.registerLazySingleton<SharedPreferences>(() => sharedPreferences);
  sl.registerLazySingleton<CacheHelper>(() => CacheHelper(
        sl.get(),
      ));
  // #endregion
}
