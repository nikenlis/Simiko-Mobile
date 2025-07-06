import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:simiko/features/feed/domain/entities/feed_item_entity.dart';

import '../../../../core/common/app_route.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/ui/shared_method.dart';

class PostItem extends StatelessWidget {
  final FeedItemEntity post;
  final String name;
  final String logoUrl;
  const PostItem({super.key, required this.post, required this.name, required this.logoUrl});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, AppRoute.detailPostPage, arguments: post.id);
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AspectRatio(
            aspectRatio: 16 / 9,
            child: ClipRRect(
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(8), topRight: Radius.circular(8)),
              child: ExtendedImage.network(post.imageUrl ?? '',
                  width: MediaQuery.of(context).size.width / 2,
                  fit: BoxFit.cover,
                  cache: true, loadStateChanged: (state) {
                if (state.extendedImageLoadState == LoadState.failed) {
                  return AspectRatio(
                    aspectRatio: 16 / 9,
                    child: Material(
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(8),
                          topRight: Radius.circular(8)),
                      color: purpleColor.withValues(alpha: 0.2),
                      child: Icon(
                        size: 32,
                        Icons.broken_image,
                        color: purpleColor.withValues(alpha: 0.4),
                      ),
                    ),
                  );
                }
                return null;
              }),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 8),
                Text(
                  post.title!,
                  style: Theme.of(context)
                      .textTheme
                      .bodyLarge
                      ?.copyWith(fontWeight: bold),
                  overflow: TextOverflow.ellipsis,
                  maxLines: 2,
                ),
                const SizedBox(
                  height: 8,
                ),
                Row(
                  children: [
                    ClipOval(
                      child: ExtendedImage.network(
                          logoUrl,
                          width: 18,
                          height: 18,
                          fit: BoxFit.cover,
                          cache: true, loadStateChanged: (state) {
                        if (state.extendedImageLoadState == LoadState.failed) {
                          return AspectRatio(
                            aspectRatio: 16 / 9,
                            child: Material(
                              borderRadius: BorderRadius.circular(16),
                              color: purpleColor.withValues(alpha: 0.2),
                              child: Icon(
                                size: 11,
                                Icons.broken_image,
                                color: purpleColor.withValues(alpha: 0.4),
                              ),
                            ),
                          );
                        }
                        return null;
                      }),
                    ),
                    SizedBox(
                      width: 4,
                    ),
                    Text(
                      name,
                      style: TextStyle(color: greyColor, fontSize: 12),
                      overflow: TextOverflow.ellipsis,
                      maxLines: 2,
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Icon(
                      Icons.history,
                      size: 18,
                      color: greyColor,
                    ),
                    SizedBox(
                      width: 4,
                    ),
                    Text(
                      formatTimeAgo(post.createdAt),
                      style: TextStyle(color: greyColor, fontSize: 12),
                      overflow: TextOverflow.ellipsis,
                      maxLines: 2,
                    ),
                  ],
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
