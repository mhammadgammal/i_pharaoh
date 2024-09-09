import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:i_pharaoh/features/authentication/data/model/user_dto.dart';

abstract interface class AuthRepositoryI {
  Future<Either<UserDto, String>> login(String email, String password);

  Future<Either<UserDto, String>> signUpWithEmailAndPassword(
    UserDto user,
    String password,
  );

  Future<Either<User, String>> signInWithGoogle();

  Future logout();
}
