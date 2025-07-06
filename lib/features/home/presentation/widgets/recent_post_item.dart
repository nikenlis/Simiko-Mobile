import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';

import '../../../../core/common/app_route.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/ui/shared_method.dart';
import '../../domain/entities/detail_organization/recent_post_entity.dart';

class RecentPostItem extends StatelessWidget {
  final RecentPostEntity data;
  final String name;
  final String logoUrl;
  const RecentPostItem({
    super.key,
    required this.data,
    required this.name,
    required this.logoUrl,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        if (data.type == "event") {
          Navigator.pushNamed(context, AppRoute.detailEventPage, arguments: data.id);
        } else {
          Navigator.pushNamed(context, AppRoute.detailPostPage, arguments: data.id);
        }
      },
      child: Container(
        margin: const EdgeInsets.only( bottom: 20),
        decoration: BoxDecoration(
          color: whiteColor,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Row(
          children: [
            Stack(
              children: [
                ClipRRect(
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(8),
                    bottomLeft: Radius.circular(8),
                  ),
                  child: ExtendedImage.network(
                    data.imageUrl,
                    width: 109,
                    height: 109,
                    fit: BoxFit.cover,
                    cache: true,
                    loadStateChanged: (state) {
                      if (state.extendedImageLoadState == LoadState.failed) {
                        return AspectRatio(
                          aspectRatio: 1,
                          child: Material(
                            borderRadius: const BorderRadius.only(
                              topLeft: Radius.circular(8),
                              bottomLeft: Radius.circular(8),
                            ),
                            color: purpleColor.withAlpha(50),
                            child: Icon(
                              size: 32,
                              Icons.broken_image,
                              color: purpleColor.withAlpha(100),
                            ),
                          ),
                        );
                      }
                      return null;
                    },
                  ),
                ),
      
                // 🎯 Tambahkan Badge untuk EVENT
                if (data.type == "event")
                  Positioned(
                    top: 8,
                    left: 8,
                    child: Container(
                      padding:
                          const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                      decoration: BoxDecoration(
                        color: purpleColor,
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: const Text(
                        "EVENT",
                        style: TextStyle(
                          fontSize: 10,
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
              ],
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                children: [
                  SizedBox(height: 16,),
                  Text(data.title, style: Theme.of(context).textTheme.bodyMedium?.copyWith(fontWeight: bold), overflow: TextOverflow.ellipsis, maxLines: 2,),
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
                        formatTanggalFromString(data.createdAt),
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
