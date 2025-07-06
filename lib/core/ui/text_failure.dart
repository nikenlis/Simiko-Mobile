import 'package:flutter/material.dart';
import 'package:simiko/core/theme/app_colors.dart';

class TextFailure extends StatelessWidget {
  final String message;
  const TextFailure({super.key, required this.message});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        message, style: const TextStyle(color: greyColor, fontWeight: FontWeight.w600),
      ),
    );
  }
}