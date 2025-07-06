import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';


import '../../../../core/common/app_route.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/ui/shared_method.dart';
import '../../domain/entities/feed_item_entity.dart';

class SmallEvent extends StatelessWidget {
  final FeedItemEntity event;
  final String name;
  final String logoUrl;
  const SmallEvent({super.key, required this.event, required this.name, required this.logoUrl});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, AppRoute.detailEventPage, arguments: event.id);
      },
      child: Container(
        margin: const EdgeInsets.only(left: 16, right: 16, bottom: 20),
        decoration: BoxDecoration(
            color: whiteColor, borderRadius: BorderRadius.circular(8)),
        child: Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(8), bottomLeft: Radius.circular(8)),
              child: ExtendedImage.network(
                      event.imageUrl ?? '',
                      width: 109,
                      height: 109,
                      fit: BoxFit.cover,
                      cache: true, loadStateChanged: (state) {
                    if (state.extendedImageLoadState == LoadState.failed) {
                      return AspectRatio(
                        aspectRatio: 16 / 9,
                        child: Material(
                          borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(8), bottomLeft: Radius.circular(8)),
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
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                children: [
                  SizedBox(height: 16,),
                  Text(event.title!, style: Theme.of(context).textTheme.bodyMedium?.copyWith(fontWeight: bold), overflow: TextOverflow.ellipsis, maxLines: 2,),
                      SizedBox(height: 8,),
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
                                  size: 10,
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
                        width: 10,
                      ),
                      Text(
                        name,
                        style: TextStyle(color: greyColor, fontSize: 12),
                    overflow: TextOverflow.ellipsis,
                    maxLines: 2,
                      ),
                      SizedBox(
                        width: 4,
                      ),
                      Icon(Icons.history, size: 18, color: greyColor,),
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
                  ),
                  SizedBox(
                    height: 16,
                  ),
                  
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}