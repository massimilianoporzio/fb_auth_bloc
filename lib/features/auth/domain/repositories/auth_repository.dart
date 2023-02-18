import 'package:dartz/dartz.dart';
import 'package:fb_auth_bloc/core/errors/failures.dart';
import 'package:firebase_auth/firebase_auth.dart' as fbAuth;

abstract class AuthRepository {
  Stream<fbAuth.User?> get user;
  Future<Either<Failure, Unit>> signup({
    required String name,
    required String email,
    required String password,
  });
  Future<Either<Failure, Unit>> signin({
    required String email,
    required String password,
  });
  Future<Either<Failure, Unit>> signout();
}
