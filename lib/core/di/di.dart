import 'package:firebase_auth/firebase_auth.dart';
import 'package:get_it/get_it.dart';
import 'package:i_pharaoh/core/utils/localization/app_localization.dart';
import 'package:i_pharaoh/features/authentication/data/repository/auth_repository.dart';
import 'package:i_pharaoh/features/authentication/domain/use_case/sign_in_use_case.dart';
import 'package:i_pharaoh/features/authentication/domain/use_case/sign_up_use_case.dart';

final sl = GetIt.instance;

Future<void> init() async {
  // region firebase auth
  sl.registerLazySingleton<FirebaseAuth>(() => FirebaseAuth.instance);

  // #region localization
  sl.registerLazySingleton<AppLanguage>(() => AppLanguage());
  // #region authentication
  sl.registerLazySingleton<AuthRepository>(() => AuthRepository());
  sl.registerLazySingleton<SignInUseCase>(() => SignInUseCase(sl.get()));
  sl.registerLazySingleton<SignUpUseCase>(() => SignUpUseCase(sl.get()));
  // #endregion

  
}
