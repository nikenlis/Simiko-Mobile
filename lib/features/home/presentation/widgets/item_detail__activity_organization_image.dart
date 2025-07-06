import 'package:flutter/material.dart';
import 'package:extended_image/extended_image.dart';

import '../../../../core/theme/app_colors.dart';

class ItemDetailActivityOrganizationImage extends StatelessWidget {
  const ItemDetailActivityOrganizationImage({super.key, required this.urlImage, required this.index});
  final List<String> urlImage;
  final int index;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: ExtendedImage.network(
                urlImage[index],
                fit: BoxFit.cover,
                handleLoadingProgress: true,
                cache: true,
                loadStateChanged: (state) {
                  if (state.extendedImageLoadState == LoadState.failed) {
                    return AspectRatio(
                      aspectRatio: 16 / 9,
                      child: Material(
                        borderRadius: BorderRadius.circular(8),
                        color: purpleColor.withValues(alpha: 0.2),
                        child: Icon(
                          Icons.broken_image,
                          color: purpleColor.withValues(alpha: 0.4),
                        ),
                      ),
                    );
                  }
                  return null;
                },
              ),
            );
  }
}