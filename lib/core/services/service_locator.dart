import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fb_auth_bloc/features/auth/data/repositories/auth_repository_impl.dart';
import 'package:fb_auth_bloc/features/auth/domain/repositories/auth_repository.dart';
import 'package:fb_auth_bloc/features/auth/domain/usecases/get_user_usecase.dart';
import 'package:fb_auth_bloc/features/auth/domain/usecases/signin_usecase.dart';
import 'package:fb_auth_bloc/features/auth/domain/usecases/signout_usecase.dart';
import 'package:fb_auth_bloc/features/auth/domain/usecases/signup_usecase.dart';
import 'package:fb_auth_bloc/features/auth/presentation/cubits/signin/signin_cubit.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:get_it/get_it.dart';

import '../../features/auth/presentation/blocs/auth/auth_bloc.dart';

final sl = GetIt.instance;

Future<void> init() async {
  //blocs/cubits
  sl.registerFactory<AuthBloc>(() => AuthBloc(
      getUserUseCase: sl<GetUserUseCase>(),
      signOutUseCase: sl<SignoutUseCase>()));

  sl.registerFactory<SigninCubit>(
      () => SigninCubit(signinUseCase: sl<SigninUseCase>()));

  //*usecases
  //GET USER
  sl.registerLazySingleton<GetUserUseCase>(
      () => GetUserUseCase(authRepository: sl()));
  //SIGN IN
  sl.registerLazySingleton<SigninUseCase>(
      () => SigninUseCase(authRepository: sl()));
  //SIGN UP
  sl.registerLazySingleton<SignupUseCase>(
      () => SignupUseCase(authRepository: sl()));
  //SIGN OUT
  sl.registerLazySingleton<SignoutUseCase>(
      () => SignoutUseCase(authRepository: sl()));

  //*repositories
  sl.registerLazySingleton<AuthRepository>(
      () => AuthRepositoryImpl(firebaseFirestore: sl(), firebaseAuth: sl()));

  //datasources
  sl.registerLazySingleton<FirebaseFirestore>(() => FirebaseFirestore.instance);
  sl.registerLazySingleton<FirebaseAuth>(() => FirebaseAuth.instance);
  //externals
}
