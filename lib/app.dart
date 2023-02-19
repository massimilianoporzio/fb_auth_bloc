import 'package:fb_auth_bloc/core/presentation/pages/home_page.dart';
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
        )
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Firebase Auth',
        theme: ThemeData(
          primarySwatch: Colors.deepPurple,
        ),
        home: const SplashPage(),
        routes: {
          SignupPage.routeName: (context) => const SignupPage(),
          SigninPage.routeName: (context) => const SigninPage(),
          HomePage.routeName: (context) => const HomePage()
        },
      ),
    );
  }
}
