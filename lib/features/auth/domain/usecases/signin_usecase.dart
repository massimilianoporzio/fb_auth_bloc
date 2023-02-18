import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

import 'package:fb_auth_bloc/core/domain/usecases/base_usecase.dart';
import 'package:fb_auth_bloc/core/errors/failures.dart';
import 'package:fb_auth_bloc/features/auth/domain/repositories/auth_repository.dart';

class SignInParams extends Equatable {
  final String password;
  final String email;

  const SignInParams({
    required this.password,
    required this.email,
  });

  @override
  String toString() => 'SignInParams(password: $password, email: $email)';

  @override
  List<Object> get props => [password, email];
}

class SigninUseCase extends BaseUseCase<Unit, SignInParams> {
  final AuthRepository authRepository;

  SigninUseCase({required this.authRepository});

  @override
  Future<Either<Failure, Unit>> call(parameters) async {
    return await authRepository.signin(
        email: parameters.email, password: parameters.password);
  }
}
