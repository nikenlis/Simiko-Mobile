import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:simiko/core/ui/circle_loading.dart';
import 'package:simiko/features/authentication/presentation/bloc/authentication_bloc.dart';
import 'package:simiko/features/authentication/presentation/widgets/form_items.dart';

import '../../../../core/common/app_route.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/ui/shared_method.dart';
import '../../../bottom_navigation_bar/bottom_navigation_bar_cubit.dart';
import '../widgets/filled_button_items.dart';

class SignInPage extends StatefulWidget {
  const SignInPage({super.key});

  @override
  State<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage>
    with SingleTickerProviderStateMixin {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  String? emailError;
  String? passwordError;

  final _formKey = GlobalKey<FormState>();

  bool validateForm() {
    return _formKey.currentState!.validate();
  }

  onTapRegister() {
    Navigator.pushNamedAndRemoveUntil(
        context, AppRoute.signUpPage, (route) => false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Builder(builder: (context) {
        return BlocConsumer<AuthenticationBloc, AuthenticationState>(
          listener: (context, state) async {
            if (state is AuthenticationLoading) {
              showLoadingDialog(context);
            } else if (state is AuthenticationFailed) {
              showCustomSnackbar(context, state.message);
            } else if (state is AuthenticationSignInLoaded) {
               context.read<BottomNavigationBarCubit>().change(0);
              Navigator.pushNamedAndRemoveUntil(
                  context, AppRoute.bottomNavBar, (route) => false);
            }
          },
          builder: (context, state) {
            return ListView(
              padding: EdgeInsets.only(
                  top: MediaQuery.of(context).size.height * 0.2,
                  bottom: 24,
                  left: 24,
                  right: 24),
              children: [
                Center(
                  child: RichText(
                    text: TextSpan(
                      children: [
                        TextSpan(
                            text: 'Si',
                            style: Theme.of(context)
                                .textTheme
                                .titleMedium
                                ?.copyWith(
                                    fontSize: 42,
                                    fontWeight: bold,
                                    color: purpleColor.withValues(alpha: 0.8))),
                        TextSpan(
                            text: 'mako',
                            style: Theme.of(context)
                                .textTheme
                                .titleMedium
                                ?.copyWith(
                                    fontSize: 42,
                                    fontWeight: bold,
                                    color: purpleColor)),
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: 16,
                ),
                Text(
                  "Login to your account",
                  style:
                      blackTextStyle.copyWith(fontSize: 20, fontWeight: bold),
                ),
                SizedBox(
                  height: 16,
                ),
                Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      FormItems(
                        title: 'Email',
                        controller: emailController,
                        errorText: emailError,
                        obsecureText: false,
                        isShowTitle: false,
                        isShowHint: true,
                        hintTitle: "Email",
                        iconVisibility: false,
                        readOnly: false,
                        textInputFormatter: [],
                        textInputAction: TextInputAction.next,
                        textInputType: TextInputType.emailAddress,
                        onFieldSubmitted: (value) {
                          setState(() {
                            final trimmedValue = value.trim();
                            if (trimmedValue.isEmpty) {
                              emailError = 'Email wajib diisi';
                            } else if (!trimmedValue.contains('@')) {
                              emailError = 'Format email tidak valid';
                            } else {
                              emailError = null;
                            }
                          });
                        },
                        validator: (value) {
                          final email = value?.trim() ?? '';
                          if (email.isEmpty) return 'Email wajib diisi';
                          if (!email.contains('@'))
                            return 'Format email tidak valid';
                          return null;
                        },
                      ),
                      SizedBox(
                        height: 16,
                      ),
                      FormItems(
                        title: 'Password',
                        controller: passwordController,
                        errorText: passwordError,
                        obsecureText: true,
                        isShowTitle: false,
                        isShowHint: true,
                        hintTitle: "Password",
                        iconVisibility: true,
                        readOnly: false,
                        textInputFormatter: [],
                        textInputType: TextInputType.text,
                        textInputAction: TextInputAction.done,
                        onFieldSubmitted: (value) {
                          setState(() {
                            if (value.isEmpty) {
                              passwordError = 'Password wajib diisi';
                            } else if (value.length < 6) {
                              passwordError = 'Password minimal 6 karakter';
                            } else {
                              passwordError = null;
                            }
                          });
                        },
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Password wajib diisi';
                          }
                          if (value.length < 6) {
                            return 'Password minimal 6 karakter';
                          }
                          return null;
                        },
                      ),
                      SizedBox(
                        height: 16,
                      ),
                    ],
                  ),
                ),
                FilledButtonItems(
                  title: 'Login',
                  onPressed: () {
                    if (validateForm()) {
                      context.read<BottomNavigationBarCubit>().resetToHome();
                      context.read<AuthenticationBloc>().add(SignInAuthEvent(
                            email: emailController.text.trim(),
                            password: passwordController.text.trim(),
                          ));
                    }
                  },
                ),
                SizedBox(
                  height: 16,
                ),
                Center(
                  child: RichText(
                    text: TextSpan(
                      text: "Don't have account? ",
                      style: purpleTextStyle.copyWith(
                          fontSize: 16, fontWeight: regular, color: blackColor),
                      children: [
                        TextSpan(
                            text: 'Register Now',
                            style: purpleTextStyle.copyWith(
                                fontSize: 16, fontWeight: semiBold),
                            recognizer: TapGestureRecognizer()
                              ..onTap = onTapRegister),
                      ],
                    ),
                  ),
                ),
              ],
            );
          },
        );
      }),
    );
  }
}
