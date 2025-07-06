import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class PlaceholderProfileHome extends StatelessWidget {
  const PlaceholderProfileHome({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      margin: const EdgeInsets.only(bottom: 20, top: 30),
      child: Row(
        children: [
          // Avatar placeholder
          Shimmer.fromColors(
            baseColor: Colors.grey.shade300,
            highlightColor: Colors.grey.shade100,
            child: const CircleAvatar(
              radius: 22.5,
              backgroundColor: Colors.white,
            ),
          ),
          const SizedBox(width: 8),
          // Text placeholder
          Expanded(
            child: Shimmer.fromColors(
              baseColor: Colors.grey.shade300,
              highlightColor: Colors.grey.shade100,
              child: Container(
                height: 14,
                width: 50,
                color: Colors.white,
              ),
            ),
          ),
          const SizedBox(width: 160),
          // Notification icon placeholder
          Shimmer.fromColors(
            baseColor: Colors.grey.shade300,
            highlightColor: Colors.grey.shade100,
            child: const CircleAvatar(
              radius: 12,
              backgroundColor: Colors.white,
            ),
          ),
        ],
      ),
    );
  }
}
