import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:validators/validators.dart';

import '../../../../core/routes/app_routes.dart';
import '../../../../core/utils/error_dialog.dart';
import '../cubits/signup/signup_cubit.dart';

class SignupPage extends StatefulWidget {
  static const routeName = AppRoutes.signup;
  const SignupPage({super.key});

  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  AutovalidateMode _autovalidateMode = AutovalidateMode.disabled;
  final _passwordController = TextEditingController();

  @override
  void dispose() {
    _passwordController.dispose();
    super.dispose();
  }

  String? _name, _email, _password;

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
    print('name: $_name, email: $_email, password: $_password');
    context
        .read<SignupCubit>()
        .signup(name: _name!, email: _email!, password: _password!);
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context)
          .unfocus(), //se clicco fuori dagli input perdo il fuoco
      child: BlocConsumer<SignupCubit, SignupState>(
        listener: (context, state) {
          if (state.signupState == SignupStatus.error) {
            errorDialog(context, state.failure!);
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
                    reverse: true,
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
                        keyboardType: TextInputType.text,
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          filled: true,
                          labelText: 'Name',
                          prefixIcon: Icon(Icons.account_box),
                        ),
                        validator: (String? value) {
                          if (value == null || value.trim().isEmpty) {
                            return 'Name required';
                          }
                          if (value.trim().length < 2) {
                            return 'Name must be at least 2 character long';
                          }
                          return null; //name valido: provare con i ValidateValueObject
                        },
                        onSaved: (newValue) {
                          _name = newValue;
                        },
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
                        controller: _passwordController,
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
                      TextFormField(
                        obscureText: true, //password
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          filled: true,
                          labelText: 'Confirm Password',
                          prefixIcon: Icon(Icons.lock),
                        ),
                        validator: (value) {
                          if (_passwordController.text != value) {
                            return "Passwords not match";
                          }
                          return null;
                        }, //non serve onSave mi serve solo per controllare che le password matchino
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      ElevatedButton(
                        //* se lo stato è submitting NON faccio submit ma nulla
                        onPressed: state.signupState == SignupStatus.submitting
                            ? null
                            : _submit,
                        style: ElevatedButton.styleFrom(
                            textStyle: const TextStyle(
                                fontSize: 20, fontWeight: FontWeight.bold),
                            padding: const EdgeInsets.symmetric(vertical: 10)),
                        child: Text(state.signupState == SignupStatus.submitting
                            ? 'Loading...'
                            : 'Sign up'),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      TextButton(
                        //disabilito se lo stato è che sto facendo il login
                        onPressed: state.signupState == SignupStatus.submitting
                            ? null
                            : () {
                                Navigator.pop(context); //TORNO INDIETRO
                              },
                        style: TextButton.styleFrom(
                            textStyle: const TextStyle(
                                fontSize: 20,
                                decoration: TextDecoration.underline)),
                        child: const Text('Already a member? Sign In!'),
                      ),
                    ].reversed.toList(),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
