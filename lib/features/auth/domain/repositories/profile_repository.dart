import 'package:dartz/dartz.dart';
import 'package:fb_auth_bloc/core/errors/failures.dart';
import 'package:fb_auth_bloc/features/auth/domain/entities/user.dart';

abstract class ProfileRepository {
  Future<Either<Failure, User>> getProfile({required String uid});
}
