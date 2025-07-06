import 'package:flutter/material.dart';
import 'package:simiko/core/common/offline_page.dart';
import 'package:simiko/core/ui/detail_profile.dart';
import 'package:simiko/features/home/presentation/pages/bottom_nav_bar.dart';
import 'package:simiko/features/home/presentation/pages/detail_organization_page.dart';
import 'package:simiko/features/splash/splash_page.dart';

import '../../features/authentication/presentation/pages/sign_in_page.dart';
import '../../features/authentication/presentation/pages/sign_up_page.dart';
import '../../features/feed/presentation/pages/detail_event_page.dart';
import '../../features/feed/presentation/pages/detail_post_page.dart';

class AppRoute {
  static const splashPage = '/splash';
  static const signUpPage = '/sign-up';
  static const signInPage = '/sign-in';
  static const bottomNavBar = '/bottom-nav-bar';
  static const detailProfilePage = '/detail-profile';
  static const detailPostPage = '/detail-post';
  static const detailEventPage = '/detail-event';
  static const detailOrganzationPage = '/detail-organization';
  //static const searchDestination = '/sign-in';
  //static const searchDestination = '/sign-in';
  //static const searchDestination = '/sign-in';
  static const offlinePage = '/offline';

  static Route<dynamic>? onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case splashPage:
        return MaterialPageRoute(builder: (context) => const SplashPage());
      case signUpPage:
        return MaterialPageRoute(builder: (context) => const SignUpPage());
      case signInPage:
        return MaterialPageRoute(builder: (context) => const SignInPage());
      case bottomNavBar:
        return MaterialPageRoute(builder: (context) => const BottomNavBar());
      case detailProfilePage:
        final imageProfile = settings.arguments;
        if (imageProfile == null) {
          return _invalidArgumentPage;
        }
        return MaterialPageRoute(
            builder: (context) => DetailProfile(
                  imgProfile: imageProfile.toString(),
                ));
      case detailPostPage:
        if (settings.arguments is! int) {
          return _invalidArgumentPage;
        }
        final int idFeed = settings.arguments as int;
        return MaterialPageRoute(
          builder: (context) => DetailPostPage(id: idFeed),
        );
      case detailEventPage:
        if (settings.arguments is! int) {
          return _invalidArgumentPage;
        }
        final int idFeed = settings.arguments as int;
        return MaterialPageRoute(
          builder: (context) => DetailEventPage(id: idFeed),
        );
      case detailOrganzationPage:
        if (settings.arguments is! int) {
          return _invalidArgumentPage;
        }
        final int idUkm = settings.arguments as int;
        return MaterialPageRoute(
            builder: (context) => DetailOrganizationPage(id: idUkm));
      case offlinePage:
        return MaterialPageRoute(builder: (context) => const OfflinePage());
      default:
        return _notFoundPage;
    }
  }

  static MaterialPageRoute get _invalidArgumentPage => MaterialPageRoute(
      builder: (context) => const Scaffold(
            body: Center(
              child: Text('Invalid Argument'),
            ),
          ));

  static MaterialPageRoute get _notFoundPage => MaterialPageRoute(
      builder: (context) => const Scaffold(
            body: Center(
              child: Text('Page Not Found'),
            ),
          ));
}
