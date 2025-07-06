import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:simiko/core/ui/shared_method.dart';

import '../../../../core/common/app_route.dart';
import '../../../../core/theme/app_colors.dart';
import '../../domain/entities/feed_item_entity.dart';


class BigEvent extends StatelessWidget {
  final FeedItemEntity event;
  final String name;
  final String logoUrl;
  const BigEvent(
      {super.key,
      required this.event,
      required this.name,
      required this.logoUrl});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, AppRoute.detailEventPage, arguments: event.id);
      },
      child: Container(
        margin: const EdgeInsets.only(left: 16, right: 16, bottom: 20),
        padding: const EdgeInsets.only(bottom: 16),
        decoration: BoxDecoration(
            color: whiteColor, borderRadius: BorderRadius.circular(8)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AspectRatio(
              aspectRatio: 16 / 9,
              child: ClipRRect(
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(8), topRight: Radius.circular(8)),
                child: ExtendedImage.network(event.imageUrl!,
                    fit: BoxFit.cover, cache: true, loadStateChanged: (state) {
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
                    event.title!,
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
                        child: ExtendedImage.network(logoUrl,
                            width: 21,
                            height: 21,
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
                                  size: 13,
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
                        formatTimeAgo(event.createdAt),
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
      ),
    );
  }
}
