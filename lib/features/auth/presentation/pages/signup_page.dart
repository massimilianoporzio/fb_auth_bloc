import 'package:fb_auth_bloc/core/routes/app_routes.dart';
import 'package:flutter/material.dart';

class SignupPage extends StatefulWidget {
  static const routeName = AppRoutes.signup;
  const SignupPage({super.key});

  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(child: Text('Signup')),
    );
  }
}
