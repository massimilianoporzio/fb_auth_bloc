import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

import 'package:fb_auth_bloc/core/domain/usecases/base_usecase.dart';
import 'package:fb_auth_bloc/core/errors/failures.dart';
import 'package:fb_auth_bloc/features/auth/domain/repositories/auth_repository.dart';

class SignUpParams extends Equatable {
  final String name;
  final String email;
  final String password;

  const SignUpParams({
    required this.name,
    required this.email,
    required this.password,
  });

  @override
  String toString() =>
      'SignUpParams(name: $name, email: $email, password: $password)';

  @override
  List<Object> get props => [name, email, password];
}

class SignupUseCase extends BaseUseCase<Unit, SignUpParams> {
  final AuthRepository authRepository;
  SignupUseCase({
    required this.authRepository,
  });
  @override
  Future<Either<Failure, Unit>> call(SignUpParams parameters) async {
    return await authRepository.signup(
        name: parameters.name,
        email: parameters.email,
        password: parameters.password);
  }
}
