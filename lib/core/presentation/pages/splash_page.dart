import 'package:fb_auth_bloc/core/presentation/pages/home_page.dart';
import 'package:fb_auth_bloc/core/routes/app_routes.dart';
import 'package:fb_auth_bloc/features/auth/presentation/pages/signin_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../features/auth/presentation/blocs/auth/auth_bloc.dart';

class SplashPage extends StatelessWidget {
  static const String routeName = AppRoutes.splash;

  const SplashPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthBloc, AuthState>(
      listener: (context, state) {
        print('listener: $state');
        if (state.authStatus == AuthStatus.unauthenticated) {
          //VADO ALLA LOGIN
          Navigator.pushNamed(context, SigninPage.routeName);
        } else if (state.authStatus == AuthStatus.authenticated) {
          //VADO ALLA HOME
          Navigator.pushNamed(context, HomePage.routeName);
        }
      },
      builder: (context, state) {
        print('builder: $state');
        return const Scaffold(
          body: Center(
            child: CircularProgressIndicator(),
          ),
        );
      },
    );
  }
}
