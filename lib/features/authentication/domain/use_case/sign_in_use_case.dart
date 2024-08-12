import 'package:dartz/dartz.dart';
import 'package:i_pharaoh/core/base_use_case/base_parameter.dart';
import 'package:i_pharaoh/core/base_use_case/parameter_use_case.dart';
import 'package:i_pharaoh/features/authentication/data/repository/auth_repository.dart';
import 'package:i_pharaoh/features/authentication/domain/data/user_model.dart';

class SignInUseCase
    implements ParameterUseCase<Either<UserModel, String>, LoginParameter> {
  final AuthRepository _authRepository;
  SignInUseCase(this._authRepository);

  @override
  Future<Either<UserModel, String>> perform(LoginParameter parameter) async {
    var result = await _authRepository.login(
      parameter.email,
      parameter.password,
    );
    late UserModel user;
    late String message;
    result.fold((l) => user = UserModel(name: l.name, email: l.email),
        (r) => message = r);
    return result.isLeft() ? Left(user) : Right(message);
  }
}
