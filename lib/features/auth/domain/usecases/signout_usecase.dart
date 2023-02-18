import 'package:dartz/dartz.dart';

import 'package:fb_auth_bloc/core/domain/usecases/base_usecase.dart';
import 'package:fb_auth_bloc/core/errors/failures.dart';
import 'package:fb_auth_bloc/features/auth/domain/repositories/auth_repository.dart';

class SignoutUseCase extends BaseUseCase<Unit, NoParameters> {
  final AuthRepository authRepository;

  SignoutUseCase({
    required this.authRepository,
  });

  @override
  Future<Either<Failure, Unit>> call(NoParameters parameters) async {
    return await authRepository.signout();
  }
}
