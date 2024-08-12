// ignore_for_file: invalid_return_type_for_catch_error

import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:i_pharaoh/core/di/di.dart';
import 'package:i_pharaoh/features/authentication/data/model/user_dto.dart';

Future<Either<User, String>> createUserWithEmailAndPassword(
  UserDto user,
  String password,
) async =>
    sl<FirebaseAuth>()
        .createUserWithEmailAndPassword(
      email: user.email,
      password: password,
    )
        .then((value) {
      value.user?.updateDisplayName(user.name);
      return Left<User, String>(value.user!);
    }).catchError((e) => Right<User, String>(e.toString()));

Future<Either<User, String>> loginInWithEmailAndPassword(
        String email, String password) async =>
    sl<FirebaseAuth>()
        .signInWithEmailAndPassword(email: email, password: password)
        .then((value) => Left<User, String>(value.user!))
        .catchError((e) => Right<User, String>(e.toString()));
