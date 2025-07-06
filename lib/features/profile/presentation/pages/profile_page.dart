import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:simiko/features/authentication/presentation/bloc/authentication_bloc.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../../core/common/app_route.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/ui/circle_loading.dart';
import '../../../../core/ui/shared_method.dart';
import '../bloc/profile_bloc.dart';
import '../widgets/profile_menu_item.dart';
import '../widgets/profile_page_placeholder.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  void initState() {
    super.initState();
    context.read<ProfileBloc>().add(GetProfileEvent());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(''),
        centerTitle: true,
      ),

      body: BlocConsumer<ProfileBloc, ProfileState>(
        listener: (context, state) {
          if (state is ProfileFailed) {
            showCustomSnackbar(context, state.message);
          }
        },
        builder: (context, state) {
          if (state is ProfileLoading) {
            return const ProfilePagePlaceholder();
          } else if (state is ProfileLoaded) {
            final user = state.data;

            return Column(
              children: [
                SizedBox(height: 75,),
                // Gambar profil
                GestureDetector(
                  onTap: () {
                    Navigator.pushNamed(
                      context,
                      AppRoute.detailProfilePage,
                      arguments: user.photoUrl,
                    );
                  },
                  child: Hero(
                    tag: 'detail-profile',
                    child: CircleAvatar(
                      radius: 60,
                      backgroundColor: Colors.grey[300],
                      backgroundImage:
                          ExtendedNetworkImageProvider(user.photoUrl),
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                // Nama
                Text(
                  user.name,
                  style:
                      blackTextStyle.copyWith(fontSize: 18, fontWeight: medium),
                ),
                const SizedBox(height: 32),
                // Email dan phone
                ProfileMenuItem(
                  icon: Icons.email_outlined,
                  title: user.email,
                  isShow: false,
                ),
                ProfileMenuItem(
                  icon: Icons.phone_outlined,
                  title: user.phone,
                  isShow: false,
                ),
                ProfileMenuItem(
                  icon: Icons.help_outline,
                  title: 'Help Center',
                  onTap: () => _launcherUrl(context, 'https://wa.link/7mcrno'),
                ),
                BlocListener<AuthenticationBloc, AuthenticationState>(
                  listener: (context, state) {
                    if (state is AuthenticationLoading) {
                      showLoadingDialog(context);
                    } else if (state is AuthenticationFailed) {
                      showCustomSnackbar(context, state.message);
                    } else if (state is AuthenticationLogoutLoaded) {
                      Navigator.pushNamedAndRemoveUntil(
                          context, AppRoute.signInPage, (route) => false);
                    }
                  },
                  child: ProfileMenuItem(
                    icon: Icons.logout,
                    title: 'Log Out',
                    onTap: () {
                      context.read<AuthenticationBloc>().add(AuthLogoutEvent());
                    },
                  ),
                ),
              ],
            );
          }

          return Center(
            child: Text(
              'Failed to load data.',
              style: greyTextStyle.copyWith(fontSize: 14, fontWeight: regular),
            ),
          );
        },
      ),
    );
  }

  Future<void> _launcherUrl(BuildContext context, String link) async {
    !await launchUrl(Uri.parse(link), mode: LaunchMode.externalApplication);
  }
}
