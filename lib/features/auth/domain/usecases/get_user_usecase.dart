import 'package:dartz/dartz.dart';

import 'package:fb_auth_bloc/core/domain/usecases/base_usecase.dart';
import 'package:fb_auth_bloc/core/errors/failures.dart';
import 'package:fb_auth_bloc/features/auth/domain/repositories/auth_repository.dart';
import 'package:firebase_auth/firebase_auth.dart' as fbAuth;

import '../../../../core/domain/usecases/stream_usecase.dart';

class GetUserUseCase extends StreamUseCase<fbAuth.User, NoParameters> {
  final AuthRepository authRepository;
  GetUserUseCase({
    required this.authRepository,
  });

  @override
  Stream<fbAuth.User?> call(NoParameters parameters) {
    return authRepository.user;
  }
}
