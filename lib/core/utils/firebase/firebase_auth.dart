// ignore_for_file: invalid_return_type_for_catch_error

import 'dart:developer';

import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
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

Future<Either<User, String>> authInWithGoogle() async {
  // Trigger the authentication flow
  final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

  // Obtain the auth details from the request
  final GoogleSignInAuthentication? googleAuth =
      await googleUser?.authentication;

  // Create a new credential
  final credential = GoogleAuthProvider.credential(
    accessToken: googleAuth?.accessToken,
    idToken: googleAuth?.idToken,
  );

  late User? user;
  String error = 'Unexpected Error Occurred';
  // Once signed in, return the UserCredential
  await sl<FirebaseAuth>()
      .signInWithCredential(credential)
      .then((value) => user = value.user)
      .catchError((err) => error = err);
  return user != null ? Left(user!) : Right(error);
}
