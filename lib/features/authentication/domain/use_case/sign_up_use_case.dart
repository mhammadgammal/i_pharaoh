import 'package:dartz/dartz.dart';
import 'package:i_pharaoh/core/base_use_case/base_parameter.dart';
import 'package:i_pharaoh/core/base_use_case/parameter_use_case.dart';
import 'package:i_pharaoh/features/authentication/data/model/user_dto.dart';
import 'package:i_pharaoh/features/authentication/data/repository/auth_repository.dart';
import 'package:i_pharaoh/features/authentication/domain/data/user_model.dart';

class SignUpUseCase
    implements ParameterUseCase<Either<UserModel, String>, RegisterParameter> {
  final AuthRepository _authRepository;
  SignUpUseCase(this._authRepository);

  @override
  Future<Either<UserModel, String>> perform(RegisterParameter parameter) async {
    var result = await _authRepository.signUp(
      UserDto(name: parameter.name, email: parameter.email),
      parameter.password,
    );
    late UserModel user;
    late String message;
    result.fold((l) => user = UserModel(name: l.name, email: l.email),
        (r) => message = r);
    return result.isLeft() ? Left(user) : Right(message);
  }
}
