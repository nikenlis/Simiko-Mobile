import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:simiko/core/theme/app_colors.dart';

import '../../../bottom_navigation_bar/bottom_navigation_bar_cubit.dart';

class BottomNavBar extends StatelessWidget {
  const BottomNavBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: context.watch<BottomNavigationBarCubit>().page,
      bottomNavigationBar: Material(
        color: whiteColor,
        elevation: 10,
        child: BlocBuilder<BottomNavigationBarCubit, int>(
            builder: (context, state) {
          return Container(
            height: 60,
            padding: const EdgeInsets.symmetric(horizontal: 14),
            child: NavigationBarTheme(
              data: NavigationBarThemeData(
                overlayColor: WidgetStateProperty.all(Colors.transparent),
              ),
              child: NavigationBar(
                selectedIndex: state,
                onDestinationSelected: (value) {
                  context.read<BottomNavigationBarCubit>().change(value);
                
                },
                backgroundColor: whiteColor,
                indicatorColor: Colors.transparent,
                surfaceTintColor: Theme.of(context).scaffoldBackgroundColor,
                labelBehavior: NavigationDestinationLabelBehavior.alwaysHide,
                destinations: context
                    .read<BottomNavigationBarCubit>()
                    .menuBottomNavigationBarCubit
                    .map((e) {
                  return NavigationDestination(
                    icon: ImageIcon(
                      AssetImage(e[1]),
                      size: 24,
                      color: purpleColor,
                    ),
                    label: e[0],
                    tooltip: e[0],
                    selectedIcon: Container(
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: purpleColor.withValues(alpha: 0.2),
                        shape: BoxShape.circle,
                      ),
                      child: ImageIcon(
                        AssetImage(e[1]),
                        size: 24,
                        color: purpleColor,
                      ),
                    ),
                  );
                }).toList(),
              ),
            ),
          );
        }),
      ),
    );
  }
}
