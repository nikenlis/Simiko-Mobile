import 'dart:io';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:simiko/core/common/app_route.dart';
import 'package:simiko/core/ui/circle_loading.dart';
import 'package:simiko/core/ui/shared_method.dart';
import 'package:simiko/features/authentication/presentation/bloc/authentication_bloc.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../bottom_navigation_bar/bottom_navigation_bar_cubit.dart';
import '../widgets/filled_button_items.dart';
import '../widgets/form_items.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  onTapRegister() {
    Navigator.pushNamedAndRemoveUntil(
        context, AppRoute.signInPage, (route) => false);
  }

  final TextEditingController emailController = TextEditingController();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController nimController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  String? emailError;
  String? nameError;
  String? nimError;
  String? phoneError;
  String? passwordError;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  bool validateForm() {
    return _formKey.currentState!.validate();
  }

  File? selectedImage;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocConsumer<AuthenticationBloc, AuthenticationState>(
        listener: (context, state) {
          if (state is AuthenticationLoading) {
            showLoadingDialog(context);
          } else if (state is AuthenticationFailed) {
            showCustomSnackbar(context, state.message);
          } else if (state is AuthenticationSignUpLoaded) {
            context.read<BottomNavigationBarCubit>().change(0);
            Navigator.pushNamedAndRemoveUntil(
                context, AppRoute.bottomNavBar, (route) => false);
          }
        },
        builder: (context, state) {
          return ListView(
            padding:
                const EdgeInsets.only(top: 85, bottom: 24, left: 24, right: 24),
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
                ),
              ),
              SizedBox(
                height: 30,
              ),
              Text(
                "Create your account",
                style: blackTextStyle.copyWith(fontSize: 20, fontWeight: bold),
              ),
              SizedBox(
                height: 16,
              ),

              ///Set-Profile
              Text(
                "Profile Picture",
                style:
                    blackTextStyle.copyWith(fontSize: 16, fontWeight: semiBold),
              ),
              SizedBox(
                height: 16,
              ),

              GestureDetector(
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    Container(
                      width: 120,
                      height: 120,
                      decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: lightBackgroundColor,
                          image: selectedImage == null
                              ? null
                              : DecorationImage(
                                  fit: BoxFit.cover,
                                  image: FileImage(File(selectedImage!.path)),
                                )),
                      child: selectedImage != null
                          ? null
                          : Center(
                              child: Image.asset(
                                "images/image_profile.png",
                                width: 120,
                                height: 120,
                              ),
                            ),
                    ),
                    Positioned(
                      bottom: 8,
                      right: 120,
                      child: Container(
                        decoration: BoxDecoration(
                          color: purpleColor,
                          shape: BoxShape.circle,
                        ),
                        padding: EdgeInsets.all(8),
                        child: Icon(
                          Icons.camera_alt,
                          color: whiteColor,
                          size: 20,
                        ),
                      ),
                    ),
                  ],
                ),
                onTap: () async {
                  final image = await getImage();
                  setState(() {
                    selectedImage = image;
                  });
                },
              ),

              ///Form
              Form(
                key: _formKey,
                child: Column(
                  children: [
                    SizedBox(
                      height: 16,
                    ),
                    FormItems(
                      title: 'Email',
                      controller: emailController,
                      errorText: emailError,
                      obsecureText: false,
                      isShowTitle: true,
                      isShowHint: true,
                      hintTitle: "jolie@gmail.com",
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
                        if (!email.contains('@')) return 'Format email tidak valid';
                        return null;
                      },
                    ),
                    SizedBox(
                      height: 16,
                    ),
                    FormItems(
                        title: 'Name',
                        controller: nameController,
                        errorText: nameError,
                        obsecureText: false,
                        isShowTitle: true,
                        isShowHint: true,
                        hintTitle: "Jolie Mario",
                        iconVisibility: false,
                        readOnly: false,
                        textInputFormatter: [],
                        textInputAction: TextInputAction.next,
                        textInputType: TextInputType.name,
                        onFieldSubmitted: (value) {
                          setState(() {
                            if (value.trim().isEmpty) {
                              nameError = 'Nama wajib diisi';
                            } else {
                              nameError = null;
                            }
                          });
                        },
                        validator: (value) {
                          if (value == null || value.trim().isEmpty) {
                            return 'Nama wajib diisi';
                          }
                          return null;
                        }),
                    SizedBox(
                      height: 16,
                    ),
                    FormItems(
                      title: 'NIM',
                      controller: nimController,
                      errorText: nimError,
                      obsecureText: false,
                      isShowTitle: true,
                      isShowHint: true,
                      hintTitle: "XX.XX.XXXX",
                      iconVisibility: false,
                      readOnly: false,
                      textInputFormatter: [
                        FilteringTextInputFormatter.allow(RegExp(r'[0-9.]')),
                        LengthLimitingTextInputFormatter(10),
                        FilteringTextInputFormatter.deny(
                            RegExp(r'[^\x00-\x7F]+')),
                      ],
                      textInputAction: TextInputAction.next,
                      textInputType: TextInputType.number,
                      onFieldSubmitted: (value) {
                        setState(() {
                          if (value.trim().isEmpty) {
                            nimError = 'NIM wajib diisi';
                          } else if (value.length != 10) {
                            nimError = 'NIM harus 10 karakter';
                          } else {
                            nimError = null;
                          }
                        });
                      },
                      validator: (value) {
                        if (value == null || value.trim().isEmpty) {
                          return 'NIM wajib diisi';
                        }
                        if (value.length != 10) {
                          return 'NIM harus 10 karakter';
                        }
                        return null;
                      },
                    ),
                    SizedBox(
                      height: 16,
                    ),
                    FormItems(
                      title: 'Phone Number',
                      controller: phoneController,
                      errorText: phoneError,
                      obsecureText: false,
                      isShowTitle: true,
                      isShowHint: true,
                      hintTitle: "6282136067349",
                      iconVisibility: false,
                      readOnly: false,
                      textInputFormatter: [],
                      textInputAction: TextInputAction.done,
                      textInputType: TextInputType.phone,
                      onFieldSubmitted: (value) {
                        setState(() {
                          final phone = value.trim();
                          if (phone.isEmpty) {
                            phoneError = 'Nomor HP wajib diisi';
                          } else {
                            phoneError = null;
                          }
                        });
                      },
                      validator: (value) {
                        if (value == null || value.trim().isEmpty) {
                          return 'Nomor HP wajib diisi';
                        }
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
                      isShowTitle: true,
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
                  ],
                ),
              ),
              SizedBox(
                height: 16,
              ),
              FilledButtonItems(
                title: 'Register',
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    if (selectedImage == null) {
                      showCustomSnackbar(context, "Foto profil wajib diunggah");
                      return;
                    }

                    context.read<AuthenticationBloc>().add(SignUpAuthEvent(
                        email: emailController.text,
                        password: passwordController.text,
                        name: nameController.text,
                        phone: phoneController.text,
                        file: selectedImage!));
                  }
                },
              ),
              SizedBox(
                height: 16,
              ),
              Center(
                child: RichText(
                  text: TextSpan(
                    text: "Already have an account? ",
                    style: purpleTextStyle.copyWith(
                        fontSize: 16, fontWeight: regular, color: blackColor),
                    children: [
                      TextSpan(
                          text: 'Login',
                          style: purpleTextStyle.copyWith(
                              fontSize: 16, fontWeight: semiBold),
                          recognizer: TapGestureRecognizer()
                            ..onTap = onTapRegister),
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 30,
              ),
            ],
          );
        },
      ),
    );
  }
}
