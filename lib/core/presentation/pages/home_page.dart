import 'package:fb_auth_bloc/core/routes/app_routes.dart';
import 'package:fb_auth_bloc/features/auth/presentation/blocs/auth/auth_bloc.dart';
import 'package:fb_auth_bloc/features/auth/presentation/pages/profile_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomePage extends StatefulWidget {
  static const String routeName = AppRoutes.home;
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false, //non faccio vedere l'icon leading
          //questo perché non torno indietro dalla home
          title: const Text('Home'),
          actions: [
            IconButton(
                onPressed: () {
                  //NAVIGO AL PROFILO
                  Navigator.pushNamed(context, ProfilePage.routeName);
                },
                icon: const Icon(Icons.account_circle)),
            IconButton(
                onPressed: () {
                  //CHIAMO IL BLOC E PASSO l'EVENTO SIGNOUT
                  context.read<AuthBloc>().add(SignoutRequestedEvent());
                },
                icon: const Icon(Icons.logout))
          ],
        ),
        body: Center(
            child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'assets/images/bloc_logo_full.png',
              width: MediaQuery.of(context).size.width * 0.8,
            ),
            const SizedBox(
              height: 20,
            ),
            const Text(
                'Bloc is an awesome\nstate management libray\nfor flutter!',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 24))
          ],
        )),
      ),
    );
  }
}
