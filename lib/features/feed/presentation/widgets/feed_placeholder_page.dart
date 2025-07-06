import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class FeedPlaceholderPage extends StatelessWidget {
  const FeedPlaceholderPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
      children: [
        _buildTabBarPlaceholder(),
        const SizedBox(height: 24),
        ShimmerText(width: 50, height: 20), // "Postingan"
        const SizedBox(height: 12),
        _buildPostListPlaceholder(),
        const SizedBox(height: 24),
        ShimmerText(width: 80, height: 20), // "Event"
        const SizedBox(height: 12),
        _buildEventPlaceholder(),
        const SizedBox(height: 50),
      ],
    );
  }

  Widget _buildTabBarPlaceholder() {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: List.generate(5, (index) {
          return Container(
            margin: const EdgeInsets.only(right: 8),
            child: ShimmerBox(width: 70, height: 32, borderRadius: 8),
          );
        }),
      ),
    );
  }

  Widget _buildPostListPlaceholder() {
    return SizedBox(
      height: 260,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: 3,
        separatorBuilder: (_, __) => const SizedBox(width: 12),
        itemBuilder: (context, index) {
          return Container(
            width: MediaQuery.of(context).size.width / 1.5,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AspectRatio(
                  aspectRatio: 16 / 9,
                  child: ShimmerBox(width: double.infinity, height: double.infinity, borderRadius: 8),
                ),
                const SizedBox(height: 8),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: const [
                      ShimmerText(width: 140, height: 14),
                      SizedBox(height: 8),
                      Row(
                        children: [
                          ShimmerBox(width: 18, height: 18, borderRadius: 9),
                          SizedBox(width: 6),
                          ShimmerText(width: 50, height: 10),
                          SizedBox(width: 12),
                          ShimmerBox(width: 12, height: 12, borderRadius: 6),
                          SizedBox(width: 6),
                          ShimmerText(width: 40, height: 10),
                        ],
                      )
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildEventPlaceholder() {
    return Column(
      children: List.generate(2, (index) {
        if (index == 0) {
          // BigEvent style
          return Container(
            margin: const EdgeInsets.only(bottom: 20),
            padding: const EdgeInsets.only(bottom: 16),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Column(
              children: [
                AspectRatio(
                  aspectRatio: 16 / 9,
                  child: ShimmerBox(width: double.infinity, height: double.infinity, borderRadius: 8),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: const [
                      ShimmerText(width: 180, height: 14),
                      SizedBox(height: 8),
                      Row(
                        children: [
                          ShimmerBox(width: 21, height: 21, borderRadius: 10),
                          SizedBox(width: 4),
                          ShimmerText(width: 60, height: 10),
                          SizedBox(width: 10),
                          ShimmerBox(width: 14, height: 14, borderRadius: 7),
                          SizedBox(width: 4),
                          ShimmerText(width: 40, height: 10),
                        ],
                      )
                    ],
                  ),
                )
              ],
            ),
          );
        } else {
          // SmallEvent style
          return Container(
            margin: const EdgeInsets.only(bottom: 20),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Row(
              children: [
                ShimmerBox(width: 109, height: 109, borderRadius: 8),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: const [
                      ShimmerText(width: 160, height: 14),
                      SizedBox(height: 8),
                      Row(
                        children: [
                          ShimmerBox(width: 18, height: 18, borderRadius: 9),
                          SizedBox(width: 4),
                          ShimmerText(width: 60, height: 10),
                          SizedBox(width: 8),
                          ShimmerBox(width: 14, height: 14, borderRadius: 7),
                          SizedBox(width: 4),
                          ShimmerText(width: 40, height: 10),
                        ],
                      ),
                      SizedBox(height: 16),
                    ],
                  ),
                )
              ],
            ),
          );
        }
      }),
    );
  }
}

class ShimmerBox extends StatelessWidget {
  final double width;
  final double height;
  final double borderRadius;

  const ShimmerBox({
    super.key,
    required this.width,
    required this.height,
    this.borderRadius = 8,
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
          color: Colors.white,
          borderRadius: BorderRadius.circular(borderRadius),
        ),
      ),
    );
  }
}

class ShimmerText extends StatelessWidget {
  final double width;
  final double height;

  const ShimmerText({super.key, required this.width, required this.height});

  @override
  Widget build(BuildContext context) {
    return ShimmerBox(width: width, height: height, borderRadius: 4);
  }
}
