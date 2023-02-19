import 'package:fb_auth_bloc/core/routes/app_routes.dart';
import 'package:fb_auth_bloc/core/utils/error_dialog.dart';
import 'package:fb_auth_bloc/features/auth/presentation/cubits/signin/signin_cubit.dart';
import 'package:fb_auth_bloc/features/auth/presentation/pages/signup_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:validators/validators.dart';

class SigninPage extends StatefulWidget {
  static const routeName = AppRoutes.signin;
  const SigninPage({super.key});

  @override
  State<SigninPage> createState() => _SigninPageState();
}

class _SigninPageState extends State<SigninPage> {
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  AutovalidateMode _autovalidateMode = AutovalidateMode.disabled;
  String? _email, _password;

  void _submit() {
    setState(() {
      _autovalidateMode =
          AutovalidateMode.always; //valido dopo il primo carattere in avanti
    });
    final form = _formKey.currentState;
    if (form == null || !form.validate()) {
      return; //non fa nulla
    }
    form.save();
    print('email: $_email, password: $_password');
    context.read<SigninCubit>().signin(email: _email!, password: _password!);
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false, //NON NAVIGO INDIETRO CON BACK o SWIPE
      child: GestureDetector(
        onTap: () => FocusScope.of(context)
            .unfocus(), //se clicco fuori dagli input perdo il fuoco
        child: BlocConsumer<SigninCubit, SigninState>(
          listener: (context, state) {
            if (state.signinStatus == SigninStatus.error) {
              errorDialog(context, state.failure);
            }
          },
          builder: (context, state) {
            return Scaffold(
              backgroundColor: Colors.white,
              body: Center(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 30),
                  child: Form(
                    key: _formKey,
                    autovalidateMode: _autovalidateMode,
                    child: ListView(
                      shrinkWrap: true,
                      children: [
                        Image.asset(
                          'assets/images/flutter_logo.png',
                          width: 250,
                          height: 250,
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        TextFormField(
                          keyboardType: TextInputType.emailAddress,
                          autocorrect: false,
                          decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                            filled: true,
                            labelText: 'Email',
                            prefixIcon: Icon(Icons.email),
                          ),
                          validator: (String? value) {
                            if (value == null || value.trim().isEmpty) {
                              return 'Email required';
                            }
                            if (!isEmail(value.trim())) {
                              return 'Enter a valid email address';
                            }
                            return null; //email valida: provare con i ValidateValueObject
                          },
                          onSaved: (newValue) {
                            _email = newValue;
                          },
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        TextFormField(
                          obscureText: true, //password
                          decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                            filled: true,
                            labelText: 'Password',
                            prefixIcon: Icon(Icons.lock),
                          ),
                          validator: (value) {
                            if (value == null || value.trim().isEmpty) {
                              return 'Password required';
                            }
                            if (value.trim().length < 6) {
                              //firebase le vuole almeno di 6
                              return 'password must be at least 6 characters long';
                            }
                            return null;
                          },
                          onSaved: (newValue) {
                            _password = newValue;
                          },
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        ElevatedButton(
                          //* se lo stato è submitting NON faccio submit ma nulla
                          onPressed:
                              state.signinStatus == SigninStatus.submitting
                                  ? null
                                  : _submit,
                          style: ElevatedButton.styleFrom(
                              textStyle: const TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.bold),
                              padding:
                                  const EdgeInsets.symmetric(vertical: 10)),
                          child: Text(
                              state.signinStatus == SigninStatus.submitting
                                  ? 'Loading...'
                                  : 'Sign in'),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        TextButton(
                          //disabilito se lo stato è che sto facendo il login
                          onPressed:
                              state.signinStatus == SigninStatus.submitting
                                  ? null
                                  : () {
                                      Navigator.pushNamed(
                                          context, SignupPage.routeName);
                                    },
                          style: TextButton.styleFrom(
                              textStyle: const TextStyle(
                                  fontSize: 20,
                                  decoration: TextDecoration.underline)),
                          child: const Text('Not a member? Sign Up!'),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
