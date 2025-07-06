import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:simiko/core/common/app_route.dart';
import 'package:simiko/core/theme/app_colors.dart';
import 'package:simiko/features/authentication/presentation/bloc/authentication_bloc.dart';

class SplashPage extends StatelessWidget {
  const SplashPage({super.key});

  void navigateAfterDelay(BuildContext context) {}

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      navigateAfterDelay(context);
    });
    return Scaffold(
      body: BlocConsumer<AuthenticationBloc, AuthenticationState>(
        listener: (context, state) {
          Future.delayed(const Duration(seconds: 2), () {
            if (state is AuthenticationCheckCredentialLoaded) {
               Navigator.pushNamedAndRemoveUntil(
                  context, AppRoute.bottomNavBar, (route) => false);
            } else if (state is AuthenticationFailed){
              Navigator.pushNamedAndRemoveUntil(
                  context, AppRoute.signInPage, (route) => false);
            }
          });
        },
        builder: (context, state) {
          return Center(
              child: RichText(
            text: TextSpan(
              children: [
                TextSpan(
                  children: [
                    TextSpan(
                        text: 'Si',
                        style: Theme.of(context)
                            .textTheme
                            .titleMedium
                            ?.copyWith(
                                fontSize: 32,
                                fontWeight: bold,
                                color: purpleColor.withValues(alpha: 0.8))),
                    TextSpan(
                        text: 'mako',
                        style: Theme.of(context)
                            .textTheme
                            .titleMedium
                            ?.copyWith(
                                fontSize: 32,
                                fontWeight: bold,
                                color: purpleColor)),
                  ],
                ),
              ],
            ),
          ));
        },
      ),
    );
  }
}
