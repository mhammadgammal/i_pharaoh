
import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:i_pharaoh/core/base_use_case/no_parameter_use_case.dart';
import 'package:i_pharaoh/features/authentication/data/repository/auth_repository.dart';

class SignInWithGoogleUseCase
    implements NoParameterUseCase<Either<User, String>> {
  final AuthRepository _authRepository;
  SignInWithGoogleUseCase(this._authRepository);

  @override
  Future<Either<User, String>> perform() async {
    var result = await _authRepository.signInWithGoogle();
    late User user;
    late String error;
    result.fold((usr) => user = usr, (w) => error = w);

    return result.isLeft() ? Left(user) : Right(error);
  }
}
