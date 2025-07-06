import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';
import 'package:photo_view/photo_view_gallery.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class GalleryPhotos extends StatelessWidget {
  const GalleryPhotos({super.key, required this.images});
  final List<String> images;

  @override
  Widget build(BuildContext context) {
    final pageController = PageController();
    return Stack(
      children: [
        PhotoViewGallery.builder(
            pageController: pageController,
            scrollPhysics: const BouncingScrollPhysics(),
            loadingBuilder: (context, event) {
              return Center(
                child: SizedBox(
                  width: 20.0,
                  height: 20.0,
                  child: CircularProgressIndicator(
                    color: Theme.of(context).primaryColor,
                    value: event == null
                        ? 0
                        : event.cumulativeBytesLoaded / event.expectedTotalBytes!,
                  ),
                ),
              );
            },
            itemCount: images.length,
            builder: (context, index) {
              return PhotoViewGalleryPageOptions(
                  imageProvider:
                      ExtendedNetworkImageProvider(images[index]),
                  initialScale: PhotoViewComputedScale.contained * 0.8,
                  heroAttributes: PhotoViewHeroAttributes(tag: images[index]));
            }),
            Positioned(
              left: 0,
              right: 0,
              bottom: 30,
              child: Center(child:SmoothPageIndicator(
                      controller: pageController,
                      count: images.length,
                      effect: WormEffect(
                          dotColor: Colors.grey[300]!,
                          activeDotColor: Theme.of(context).primaryColor,
                          dotHeight: 10,
                          dotWidth: 10),
                    ))),

                    Align(
                      alignment: Alignment.topRight,
                      child: CloseButton())
      ],
    );
  }
}
