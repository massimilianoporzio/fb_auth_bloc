import 'package:fb_auth_bloc/core/presentation/pages/home_page.dart';
import 'package:fb_auth_bloc/features/auth/presentation/cubits/profile/profile_cubit.dart';
import 'package:fb_auth_bloc/features/auth/presentation/cubits/signin/signin_cubit.dart';
import 'package:fb_auth_bloc/features/auth/presentation/cubits/signup/signup_cubit.dart';
import 'package:fb_auth_bloc/features/auth/presentation/pages/profile_page.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'core/presentation/pages/splash_page.dart';
import 'core/services/service_locator.dart';
import 'features/auth/presentation/blocs/auth/auth_bloc.dart';
import 'features/auth/presentation/pages/signup_page.dart';
import 'package:flutter/material.dart';

import 'features/auth/presentation/pages/signin_page.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<AuthBloc>(
          create: (context) => sl<AuthBloc>(),
        ),
        BlocProvider(
          create: (context) => sl<SigninCubit>(),
        ),
        BlocProvider(
          create: (context) => sl<SignupCubit>(),
        ),
        BlocProvider(
          create: (context) => sl<ProfileCubit>(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Firebase Auth',
        theme: ThemeData(
          primarySwatch: Colors.blueGrey,
        ),
        home: const SplashPage(),
        routes: {
          SignupPage.routeName: (context) => const SignupPage(),
          SigninPage.routeName: (context) => const SigninPage(),
          HomePage.routeName: (context) => const HomePage(),
          ProfilePage.routeName: (context) => const ProfilePage()
        },
      ),
    );
  }
}
