import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:i_pharaoh/core/di/di.dart';
import 'package:i_pharaoh/core/utils/firebase/firebase_auth.dart';
import 'package:i_pharaoh/features/authentication/data/model/user_dto.dart';
import 'package:i_pharaoh/features/authentication/domain/repository/auth_repository_i.dart';

class AuthRepository implements AuthRepositoryI {
  @override
  Future<Either<UserDto, String>> login(String email, String password) async {
    var result = await loginInWithEmailAndPassword(email, password);
    late UserDto userDto;
    late String error;
    result.fold(
      (user) => userDto = UserDto(
        name: user.displayName ?? '',
        email: user.email ?? '',
      ),
      (e) => error = e,
    );
    return result.isLeft() ? Left(userDto) : Right(error);
  }

  @override
  Future logout() async => sl<FirebaseAuth>().signOut();

  @override
  Future<Either<UserDto, String>> signUp(UserDto user, String password) async {
    var result = await createUserWithEmailAndPassword(user, password);
    late UserDto userDto;
    late String error;
    result.fold(
      (user) => userDto = UserDto(
        name: user.displayName ?? '',
        email: user.email ?? '',
      ),
      (e) => error = e,
    );
    return result.isLeft() ? Left(userDto) : Right(error);
  }
}
