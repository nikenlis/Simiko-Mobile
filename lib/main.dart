import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:simiko/core/common/global_context.dart';
import 'package:simiko/core/theme/app_colors.dart';
import 'package:simiko/features/authentication/presentation/bloc/authentication_bloc.dart';
import 'package:simiko/features/feed/presentation/bloc/ukm_feed/ukm_feed_bloc.dart';
import 'package:simiko/features/home/presentation/bloc/all_organization/bloc/all_organization_bloc.dart';
import 'package:simiko/features/home/presentation/bloc/detail_organization/detail_organization_bloc.dart';
import 'package:simiko/features/profile/presentation/bloc/profile_bloc.dart';
import 'package:simiko/injection.dart';

import 'core/common/app_route.dart';
import 'features/bottom_navigation_bar/bottom_navigation_bar_cubit.dart';
import 'features/feed/presentation/bloc/detail_feed/detail_feed_bloc.dart';
import 'features/home/presentation/bloc/search_organization/search_bloc.dart';
import 'features/home/presentation/bloc/top_event/top_event_bloc.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initializeDateFormatting(); 
  await initLocator();
  runApp(MyApp());
}


class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
        providers: [
          BlocProvider(create: (_) => BottomNavigationBarCubit()),
          BlocProvider(
              create: (_) =>
                  locator<AuthenticationBloc>()..add(AuthCheckCredential())),
          BlocProvider(
              create: (_) => locator<TopEventBloc>()..add(GetAllTopEvent())),
          BlocProvider(
              create: (_) => locator<AllOrganizationBloc>()
                ..add(GetAllOrganizationEvent())),
          BlocProvider(
              create: (_) => locator<SearchBloc>()),
          BlocProvider(
              create: (_) => locator<UkmFeedBloc>()),
          BlocProvider(
              create: (_) => locator<DetailOrganizationBloc>()),
          BlocProvider(
              create: (_) => locator<DetailFeedBloc>()),
          BlocProvider(
              create: (_) => locator<ProfileBloc>()),

        ],
        child: MaterialApp(
          navigatorKey: navigatorKey,
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            textTheme: GoogleFonts.poppinsTextTheme(
              Theme.of(context).textTheme,
            ),
            scaffoldBackgroundColor: lightBackgroundColor,
            appBarTheme: AppBarTheme(
              backgroundColor: purpleColor.withValues(alpha: 0.08),
              elevation: 0,
              centerTitle: true,
              iconTheme: IconThemeData(
                color: blackColor,
              ),
              titleTextStyle: blackTextStyle.copyWith(
                fontSize: 20,
                fontWeight: semiBold,
              ),
            ),
          ),
          initialRoute: AppRoute.splashPage,
          onGenerateRoute: AppRoute.onGenerateRoute,
        ));
  }
}
