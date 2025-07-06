import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class DetailPostPlaceholderPage extends StatelessWidget {
  const DetailPostPlaceholderPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      children: [
        const SizedBox(height: 31),
        _shimmerText(width: 250, height: 24), // Judul
        const SizedBox(height: 18),
        Row(
          children: [
            _shimmerBox(width: 28, height: 28, shape: BoxShape.circle), // Logo
            const SizedBox(width: 10),
            _shimmerText(width: 80, height: 16), // UKM
            const Spacer(),
            _shimmerText(width: 100, height: 16), // Tanggal
          ],
        ),
        const SizedBox(height: 25),
        AspectRatio(
          aspectRatio: 16 / 9,
          child: _shimmerBox(width: double.infinity, height: double.infinity),
        ),
        const SizedBox(height: 20),
        _shimmerText(width: double.infinity, height: 16),
        const SizedBox(height: 12),
        _shimmerText(width: double.infinity, height: 16),
        const SizedBox(height: 12),
        _shimmerText(width: 200, height: 16),
        const SizedBox(height: 24),
      ],
    );
  }

  Widget _shimmerBox({
    required double width,
    required double height,
    double borderRadius = 8,
    BoxShape shape = BoxShape.rectangle,
  }) {
    return Shimmer.fromColors(
      baseColor: Colors.grey.shade300,
      highlightColor: Colors.grey.shade100,
      child: Container(
        width: width,
        height: height,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: shape == BoxShape.circle
              ? null
              : BorderRadius.circular(borderRadius),
          shape: shape,
        ),
      ),
    );
  }

  Widget _shimmerText({required double width, required double height}) {
    return _shimmerBox(width: width, height: height, borderRadius: 4);
  }
}
