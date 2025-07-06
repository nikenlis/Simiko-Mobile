import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class OrganizationDetailPlaceholder extends StatelessWidget {
  const OrganizationDetailPlaceholder({super.key});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return ListView(
      padding: const EdgeInsets.only(top: 35, left: 16, right: 16),
      children: [
        // Gambar utama
        Shimmer.fromColors(
          baseColor: Colors.grey.shade300,
          highlightColor: Colors.grey.shade100,
          child: Container(
            width: double.infinity,
            height: screenWidth * 9 / 16,
            decoration: BoxDecoration(
              color: Colors.grey,
              borderRadius: BorderRadius.circular(8),
            ),
          ),
        ),
        const SizedBox(height: 37),

        // Profil UKM
        Row(
          children: [
            ShimmerBox(
              width: 60,
              height: 60,
              shape: BoxShape.circle,
            ),
            const SizedBox(width: 15),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ShimmerBox(width: screenWidth * 0.4, height: 15),
                  const SizedBox(height: 7),
                  ShimmerBox(width: screenWidth * 0.6, height: 13),
                ],
              ),
            ),
          ],
        ),

        const SizedBox(height: 30),

        // Title section "Tentang"
        ShimmerBox(width: screenWidth * 0.3, height: 20),
        const SizedBox(height: 8),
        ShimmerBox(width: double.infinity, height: 80),

        const SizedBox(height: 25),

        // Title section "Visi dan Misi"
        ShimmerBox(width: screenWidth * 0.4, height: 20),
        const SizedBox(height: 8),
        ShimmerBox(width: double.infinity, height: 80),
      ],
    );
  }
}

class ShimmerBox extends StatelessWidget {
  final double width;
  final double height;
  final BoxShape shape;

  const ShimmerBox({
    super.key,
    required this.width,
    required this.height,
    this.shape = BoxShape.rectangle,
  });

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.grey.shade300,
      highlightColor: Colors.grey.shade100,
      child: Container(
        width: width,
        height: height,
        decoration: BoxDecoration(
          color: Colors.grey,
          shape: shape,
          borderRadius:
              shape == BoxShape.circle ? null : BorderRadius.circular(8),
        ),
      ),
    );
  }
}
