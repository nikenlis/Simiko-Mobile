import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:simiko/core/theme/app_colors.dart';

class DetailProfile extends StatefulWidget {
  final String imgProfile;
  const DetailProfile({super.key, required this.imgProfile});

  @override
  State<DetailProfile> createState() => _DetailProfileState();
}

class _DetailProfileState extends State<DetailProfile> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: whiteColor,
        appBar: AppBar(
          title: const Text(''),
        ),
        body: Center(
          child: Hero(
              tag: 'detail-profile',
              child: ExtendedImage.network(
                widget.imgProfile,
                fit: BoxFit.cover,
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.width,
                cache: true,
                loadStateChanged: (state) {
                  if (state.extendedImageLoadState == LoadState.failed) {
                    return AspectRatio(
                      aspectRatio: 16 / 9,
                      child: Material(
                        borderRadius: BorderRadius.circular(16),
                        color: purpleColor.withValues(alpha: 0.2),
                        child: Icon(
                          size: 24,
                          Icons.broken_image,
                          color: purpleColor.withValues(alpha: 0.4),
                        ),
                      ),
                    );
                  }
                  return null;
                },
              )),
        ));
  }
}
