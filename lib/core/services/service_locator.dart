import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fb_auth_bloc/features/auth/data/repositories/auth_repository_impl.dart';
import 'package:fb_auth_bloc/features/auth/data/repositories/profile_repository_impl.dart';
import 'package:fb_auth_bloc/features/auth/domain/repositories/auth_repository.dart';
import 'package:fb_auth_bloc/features/auth/domain/repositories/profile_repository.dart';
import 'package:fb_auth_bloc/features/auth/domain/usecases/get_profile_usecase.dart';
import 'package:fb_auth_bloc/features/auth/domain/usecases/get_user_usecase.dart';
import 'package:fb_auth_bloc/features/auth/domain/usecases/signin_usecase.dart';
import 'package:fb_auth_bloc/features/auth/domain/usecases/signout_usecase.dart';
import 'package:fb_auth_bloc/features/auth/domain/usecases/signup_usecase.dart';
import 'package:fb_auth_bloc/features/auth/presentation/cubits/profile/profile_cubit.dart';
import 'package:fb_auth_bloc/features/auth/presentation/cubits/signin/signin_cubit.dart';
import 'package:fb_auth_bloc/features/auth/presentation/cubits/signup/signup_cubit.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:get_it/get_it.dart';

import '../../features/auth/presentation/blocs/auth/auth_bloc.dart';

final sl = GetIt.instance;

Future<void> init() async {
  //*blocs/cubits
  //Auth bloc
  sl.registerFactory<AuthBloc>(() => AuthBloc(
      getUserUseCase: sl<GetUserUseCase>(),
      signOutUseCase: sl<SignoutUseCase>()));

  //login cubi
  sl.registerFactory<SigninCubit>(
      () => SigninCubit(signinUseCase: sl<SigninUseCase>()));
  //signup cubit
  sl.registerFactory<SignupCubit>(
      () => SignupCubit(signupUseCase: sl<SignupUseCase>()));
  //profile cubit
  sl.registerFactory<ProfileCubit>(
      () => ProfileCubit(getProfileUseCase: sl<GetProfileUseCase>()));

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

  //GET PROFILE
  sl.registerLazySingleton<GetProfileUseCase>(
      () => GetProfileUseCase(profileRepository: sl<ProfileRepository>()));

  //*repositories
  sl.registerLazySingleton<AuthRepository>(
      () => AuthRepositoryImpl(firebaseFirestore: sl(), firebaseAuth: sl()));

  sl.registerLazySingleton<ProfileRepository>(
      () => ProfileRepoImpl(firebaseFirestore: sl()));

  //*datasources
  sl.registerLazySingleton<FirebaseFirestore>(() => FirebaseFirestore.instance);
  sl.registerLazySingleton<FirebaseAuth>(() => FirebaseAuth.instance);

  //*externals
}
