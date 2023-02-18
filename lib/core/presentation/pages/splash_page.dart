import 'package:fb_auth_bloc/core/routes/app_routes.dart';
import 'package:flutter/material.dart';

class SplashPage extends StatelessWidget {
  static const String routeName = AppRoutes.splash;

  const SplashPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}
