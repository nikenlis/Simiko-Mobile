import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:simiko/core/theme/app_colors.dart';
import 'package:simiko/features/home/domain/entities/top_event_entity.dart';

import '../../../../core/ui/circle_loading.dart';

class ItemTopEvent extends StatelessWidget {
  final bool isActive;
  final TopEventEntity entity;
  const ItemTopEvent({
    super.key,
    required this.isActive, required this.entity,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        
      },
      child: FractionallySizedBox(
        widthFactor: 1.08,
        child: AnimatedScale(
          duration: const Duration(milliseconds: 400),
          scale: isActive ? 1 : 0.8,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: Stack(
              children: [
                ExtendedImage.network(
                    entity.imageUrl,
                    width: double.infinity,
                    borderRadius: BorderRadius.circular(8),
                    shape: BoxShape.rectangle,
                    handleLoadingProgress: true,
                    cache: true, loadStateChanged: (state) {
                  if (state.extendedImageLoadState == LoadState.failed) {
                    return AspectRatio(
                      aspectRatio: 16 / 9,
                      child: Material(
                        borderRadius: BorderRadius.circular(8),
                        color: purpleColor.withValues(alpha: 0.2),
                        child: Icon(
                          size: 32,
                          Icons.broken_image,
                          color: purpleColor.withValues(alpha: 0.4),
                        ),
                      ),
                    );
                  }
                  if (state.extendedImageLoadState == LoadState.loading) {
                    return AspectRatio(
                      aspectRatio: 16 / 9,
                      child: Material(
                        borderRadius: BorderRadius.circular(8),
                        color: purpleColor,
                        child: const CircleLoading(),
                      ),
                    );
                  }
                  return null;
                }),
                Positioned(
                    top: 12,
                    right: 12,
                    child: Container(
                      padding:
                          const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
                      decoration: BoxDecoration(
                          color: purpleColor,
                          borderRadius: BorderRadius.circular(8)),
                      child: Text(
                        entity.ukm,
                        style: whiteTextStyle.copyWith(
                            fontWeight: bold, fontSize: 10),
                      ),
                    ))
              ],
            ),
          ),
        ),
      ),
    );
  }
}
