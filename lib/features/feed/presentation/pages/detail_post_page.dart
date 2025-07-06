import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:simiko/core/ui/shared_method.dart';
import 'package:simiko/core/ui/text_html.dart';
import 'package:simiko/features/feed/domain/entities/detail_post_entity.dart';
import 'package:simiko/features/feed/presentation/bloc/detail_feed/detail_feed_bloc.dart';
import 'package:simiko/features/feed/presentation/widgets/detail_post_placeholder_page.dart';

import '../../../../core/theme/app_colors.dart';

class DetailPostPage extends StatefulWidget {
  final int id;
  const DetailPostPage({super.key, required this.id});

  @override
  State<DetailPostPage> createState() => _DetailPostPageState();
}

class _DetailPostPageState extends State<DetailPostPage> {
  bool isLiked = false;
  @override
  void initState() {
    super.initState();
    context.read<DetailFeedBloc>().add(GetDetailPostEvent(id: widget.id));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(''),
        ),
        body: BlocConsumer<DetailFeedBloc, DetailFeedState>(
          listener: (context, state) {
            if(state is DetailFeedFailed) {
              showCustomSnackbar(context, state.message);
            }
          },
          builder: (context, state) {
            if(state is DetailFeedLoading){
              return DetailPostPlaceholderPage();
            } else if (state is DetailPostLoaded) {
              return ListView(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              children: [
                header(context, state.data),
                content(context,  state.data.content),
              ],
            );
            }
            return Center(
              child: Text(
            'Failed to load data.',
            style: greyTextStyle.copyWith(fontSize: 14, fontWeight: regular),
          ));
          },
        ),
        floatingActionButton: GestureDetector(
          onTap: () {
            setState(() {
              isLiked = !isLiked;
            });
          },
          child: Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: isLiked
                  ? redColor.withValues(alpha: 0.2)
                  : greyColor.withValues(alpha: 0.2),
            ),
            child: Icon(
              isLiked ? Icons.favorite : Icons.favorite_border,
              color: isLiked ? redColor : greyColor,
              size: 28,
            ),
          ),
        ));
  }

  header(
    BuildContext context, DetailPostEntity data
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          height: 31,
        ),
        Text(
          data.title,
          style: Theme.of(context).textTheme.titleLarge?.copyWith(
                fontSize: 24,
                fontWeight: bold,
              ),
          maxLines: 3,
          overflow: TextOverflow.ellipsis,
        ),
        SizedBox(
          height: 18,
        ),
        Row(
          children: [
            ClipOval(
              child: ExtendedImage.network(
                  data.ukmLogoUrl!,
                  width: 28,
                  height: 28,
                  fit: BoxFit.cover,
                  cache: true, loadStateChanged: (state) {
                if (state.extendedImageLoadState == LoadState.failed) {
                  return AspectRatio(
                    aspectRatio: 16 / 9,
                    child: Material(
                      borderRadius: BorderRadius.circular(8),
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
              data.ukmAlias,
              style: Theme.of(context)
                  .textTheme
                  .headlineSmall
                  ?.copyWith(fontSize: 15, fontWeight: bold),
              overflow: TextOverflow.ellipsis,
              maxLines: 2,
            ),
            Spacer(),
            Text(
              formatTanggal(data.createdAt),
              style: TextStyle(color: greyColor, fontSize: 15),
              overflow: TextOverflow.ellipsis,
              maxLines: 2,
            ),
          ],
        ),
        SizedBox(
          height: 25,
        ),
        if (data.imageUrl!=null) ...[
          AspectRatio(
          aspectRatio: 16 / 9,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: ExtendedImage.network(
                data.imageUrl!,
                fit: BoxFit.cover,
                borderRadius: BorderRadius.circular(8),
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
        ),
                SizedBox(
          height: 20,
        ),
        ],
      ],
    );
  }

  content(BuildContext context, String data) {
    return TextHtml(data: data);
  }
}
