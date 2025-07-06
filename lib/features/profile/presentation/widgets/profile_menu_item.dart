import 'package:flutter/material.dart';

import '../../../../core/theme/app_colors.dart';

class ProfileMenuItem extends StatelessWidget {
  final IconData icon;
  final String title;
  final VoidCallback? onTap;
  final bool isShow;
  const ProfileMenuItem(
      {super.key, required this.icon, required this.title, this.onTap, this.isShow = true});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.only(bottom: 10, left: 24, right: 24),
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 10),
        decoration: BoxDecoration(
            color: whiteColor,
            border: Border.all(color: greyColor.withOpacity(0.2)),
            borderRadius: BorderRadius.circular(40)),
        child: Row(
          children: [
           Icon(icon, size: 24, color: purpleColor,),
            const SizedBox(
              width: 18,
            ),
            Expanded(
              child: Text(
                title,
                style: greyTextStyle.copyWith(fontWeight: medium),
              ),
            ),
            isShow ?
            Icon(
              Icons.keyboard_arrow_right_outlined,
              color: greyColor,
            ) : SizedBox()
          ],
        ),
      ),
    );
  }
}
