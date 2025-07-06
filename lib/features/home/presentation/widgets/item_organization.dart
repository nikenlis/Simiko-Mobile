// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';

import 'package:simiko/core/theme/app_colors.dart';
import 'package:simiko/features/home/domain/entities/organization_entity.dart';

import '../../../../core/common/app_route.dart';
import '../../../../core/ui/shared_method.dart';

// ignore: must_be_immutable
class ItemOrganization extends StatelessWidget {
  OrganizationEntity entity;
  ItemOrganization({
    super.key,
    required this.entity,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, AppRoute.detailOrganzationPage,
            arguments: entity.id);
      },
      child: Padding(
        padding: const EdgeInsets.only(bottom: 16),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: ExtendedImage.network(entity.logo,
                  width: 109,
                  height: 109,
                  borderRadius: BorderRadius.circular(8),
                  shape: BoxShape.rectangle,
                  fit: BoxFit.cover,
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
                return null;
              }),
            ),
            const SizedBox(
              width: 15,
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    entity.name,
                    style: Theme.of(context)
                        .textTheme
                        .titleSmall
                        ?.copyWith(fontWeight: bold),
                    overflow: TextOverflow.ellipsis,
                    maxLines: 2,
                  ),
                  const SizedBox(
                    height: 4,
                  ),
                  Text(
                    parseHtmlToPlainText(entity.description),
                    style: Theme.of(context).textTheme.bodySmall,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  
                  const SizedBox(
                    height: 8,
                  ),
                  Text(
                    entity.category,
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          color: greyColor,
                        ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
