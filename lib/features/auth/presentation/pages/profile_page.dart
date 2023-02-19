import 'package:cached_network_image/cached_network_image.dart';
import 'package:fb_auth_bloc/core/routes/app_routes.dart';
import 'package:fb_auth_bloc/core/utils/error_dialog.dart';
import 'package:fb_auth_bloc/features/auth/presentation/blocs/auth/auth_bloc.dart';
import 'package:fb_auth_bloc/features/auth/presentation/cubits/profile/profile_cubit.dart';
import 'package:fb_auth_bloc/features/auth/presentation/widgets/error_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProfilePage extends StatefulWidget {
  static const routeName = AppRoutes.profile;
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  void initState() {
    super.initState();
    _getProfile();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile'),
      ),
      body: BlocConsumer<ProfileCubit, ProfileState>(
        listener: (context, state) {
          if (state.profileStatus == ProfileStatus.error) {
            errorDialog(context, state.failure!);
          }
        },
        builder: (context, state) {
          if (state.profileStatus == ProfileStatus.initial) {
            return Container();
          } else if (state.profileStatus == ProfileStatus.loading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (state.profileStatus == ProfileStatus.error) {
            return Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Image.asset(
                    'assets/images/error.png',
                    width: 75,
                    height: 75,
                    fit: BoxFit.cover,
                  ),
                  const SizedBox(width: 20.0),
                  const Text(
                    'Ooops!\nTry again',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 20.0,
                      color: Colors.red,
                    ),
                  ),
                ],
              ),
            );
          }
          return Card(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                FadeInImage.assetNetwork(
                  placeholder: 'assets/images/loading.gif',
                  image: state.user.profileImageUrl,
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
                const SizedBox(height: 10.0),
                Padding(
                  padding: const EdgeInsets.only(left: 15.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '-id: ${state.user.id}',
                        style: const TextStyle(fontSize: 18.0),
                      ),
                      const SizedBox(height: 10.0),
                      Text(
                        '- name: ${state.user.name}',
                        style: const TextStyle(fontSize: 18.0),
                      ),
                      const SizedBox(height: 10.0),
                      Text(
                        '- email: ${state.user.email}',
                        style: const TextStyle(fontSize: 18.0),
                      ),
                      const SizedBox(height: 10.0),
                      Text(
                        '- point: ${state.user.point}',
                        style: const TextStyle(fontSize: 18.0),
                      ),
                      const SizedBox(height: 10.0),
                      Text(
                        '- rank: ${state.user.rank}',
                        style: const TextStyle(fontSize: 18.0),
                      ),
                    ],
                  ),
                )
              ],
            ),
          );
        },
      ),
    );
  }

  void _getProfile() async {
    //recupero uid dall'utente corrente
    final String uid = context.read<AuthBloc>().state.user!.uid;
    print('uid: $uid');
    //chiamo il cubit per avere il profile
    context.read<ProfileCubit>().getProfile(uid: uid);
  }
}
