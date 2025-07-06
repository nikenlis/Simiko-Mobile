import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:simiko/features/feed/presentation/bloc/detail_feed/detail_feed_bloc.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/ui/shared_method.dart';
import '../../../../core/ui/text_html.dart';
import '../../../authentication/presentation/widgets/filled_button_items.dart';
import '../../domain/entities/detail_event_entity.dart';
import '../widgets/detail_post_placeholder_page.dart';

class DetailEventPage extends StatefulWidget {
  final int id;
  const DetailEventPage({super.key, required this.id});

  @override
  State<DetailEventPage> createState() => _DetailEventPageState();
}

class _DetailEventPageState extends State<DetailEventPage> {

  @override
  void initState() {
    super.initState();
    context.read<DetailFeedBloc>().add(GetDetailEvent(id: widget.id));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(''),
      ),
      body: BlocConsumer<DetailFeedBloc, DetailFeedState>(
        listener: (context, state) {
          if (state is DetailFeedFailed) {
            showCustomSnackbar(context, state.message);
          }
        },
        builder: (context, state) {
          if (state is DetailFeedLoading) {
            return DetailPostPlaceholderPage();
          } else if (state is DetailEventLoaded) {
            return ListView(
              children: [
                header(context, state.data),
                content(context, state.data),
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
    );
  }

  header(BuildContext context, DetailEventEntity data) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        SizedBox(
          height: 31,
        ),
        Row(
          children: [
            ClipOval(
              child: ExtendedImage.network(
                  data.ukmLogoUrl,
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
              formatTanggalFromString(data.createdAt),
              style: TextStyle(color: greyColor, fontSize: 15),
              overflow: TextOverflow.ellipsis,
              maxLines: 2,
            ),
          ],
        ),
        SizedBox(
          height: 20,
        ),
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
          height: 12,
        ),
        TextHtml(
            data:
                data.content!),
        SizedBox(
          height: 25,
        ),
      ]),
    );
  }

  content(BuildContext context, DetailEventEntity data) {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Padding(
        padding: const EdgeInsets.only(left: 16, right: 16, bottom: 16),
        child: Text(
          "Save the date",
          style: Theme.of(context)
              .textTheme
              .titleMedium
              ?.copyWith(fontSize: 20, fontWeight: bold),
        ),
      ),
      _buildInfoRow('Tanggal', formatTanggalFromString(data.eventDate)),
      _buildInfoRow('Tempat', data.location),
      _buildInfoRow('Acara', data.eventType),
      _buildInfoRow('Harga', data.amount),
      SizedBox(
        height: 20,
      ),
      Padding(
        padding: const EdgeInsets.only(left: 16, right: 16, bottom: 16),
        child: FilledButtonItems(
                  title: 'Pay now',
                  onPressed: () {
                    _launcherUrl(context, data.link!);
                  },
                ),
      ),
      SizedBox(
        height: 50,
      ),
    ]);
  }

  
  Future<void> _launcherUrl(BuildContext context, String link) async {
    !await launchUrl(Uri.parse(link),
        mode: LaunchMode.externalApplication);
  }

  Widget _buildInfoRow(String label, String? value) {
    final isHarga =
        label.toLowerCase() == 'harga' || label.toLowerCase() == 'price';

    return Padding(
      padding: const EdgeInsets.only(bottom: 6.0, left: 16, right: 10),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 90,
            child: Text(
              "$label:",
              style: const TextStyle(
                fontWeight: FontWeight.w500,
                fontSize: 14,
              ),
            ),
          ),
          Expanded(
            child: Text(
              isHarga && value != null ? "Rp $value" : (value ?? '-'),
              style: Theme.of(context).textTheme.titleSmall?.copyWith(
                    fontWeight: semiBold,
                    fontSize: 15,
                  ),
            ),
          ),
        ],
      ),
    );
  }
}
