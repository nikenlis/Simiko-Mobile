import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:simiko/core/ui/shared_method.dart';
import 'package:simiko/core/ui/text_html.dart';
import 'package:simiko/features/home/domain/entities/detail_organization/achievement_entity.dart';
import 'package:staggered_grid_view_flutter/widgets/staggered_grid_view.dart';
import 'package:staggered_grid_view_flutter/widgets/staggered_tile.dart';

import '../../../../core/theme/app_colors.dart';
import '../../domain/entities/detail_organization/detail_organization_entity.dart';
import '../bloc/detail_organization/detail_organization_bloc.dart';
import '../widgets/gallery_photos.dart';
import '../widgets/item_detail__activity_organization_image.dart';
import '../widgets/placeholder_detail_organization.dart';
import '../widgets/recent_post_item.dart';

class DetailOrganizationPage extends StatefulWidget {
  final int id;
  const DetailOrganizationPage({super.key, required this.id});

  @override
  State<DetailOrganizationPage> createState() => _DetailOrganizationPageState();
}

class _DetailOrganizationPageState extends State<DetailOrganizationPage> {
  final String contohHtml = """
<p><b>UKM Musik Amikom</b> merupakan komunitas bagi mahasiswa Universitas Amikom Yogyakarta yang memiliki <i>minat dan bakat</i> di bidang musik. Komunitas ini menjadi wadah untuk mengembangkan kemampuan bermusik melalui latihan rutin dan kerja sama antaranggota.</p>
""";

  final String uhut =
      """ <p>Menjadi wadah pengembangan kreativitas dan kolaborasi di bidang musik, serta menginspirasi mahasiswa untuk berkarya di dunia seni.</p>

<p>UKM Musik Amikom memiliki komitmen untuk:</p>

<ul>
  <li>Membina mahasiswa dalam meningkatkan kemampuan bermusik melalui pelatihan rutin.</li>
  <li>Mengadakan acara seni dan budaya sebagai sarana ekspresi dan apresiasi karya musik.</li>
  <li>Membentuk lingkungan yang mendukung kolaborasi antar anggota di bidang musik.</li>
  <li>Berkontribusi aktif dalam acara kampus dan masyarakat sebagai representasi seni Amikom.</li>
</ul> """;

  @override
  void initState() {
    super.initState();
    context
        .read<DetailOrganizationBloc>()
        .add(GetDetailOrganizationEvent(id: widget.id));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(''),
      ),
      body: BlocConsumer<DetailOrganizationBloc, DetailOrganizationState>(
        listener: (context, state) {
          if (state is DetailOrganizationFailed) {
            showCustomSnackbar(context, state.message);
          }
        },
        builder: (context, state) {
          if (state is DetailOrganizationLoading) {
            return OrganizationDetailPlaceholder();
          } else if (state is DetailOrganizationLoaded) {
            DetailOrganizationEntity data = state.data;
            return ListView(
              padding: const EdgeInsets.only(top: 35, left: 16, right: 16),
              children: [
                //HEADER
                header(context, data),

                //TENTANG
                tentang(context, data),

                //VISI DAN MISI
                visiMisi(context, data),

                //PRESTASI KAMI
                prestasi(context, data),

                //KEGIATAN
                galleryActivity(context, data),

                //RECENTPOST
                recentPost(context, data),
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

  header(BuildContext context, DetailOrganizationEntity data) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AspectRatio(
          aspectRatio: 16 / 9,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: ExtendedImage.network(
                data.backgroundPhotoUrl!,
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
          height: 37,
        ),
        Row(
          children: [
            ClipOval(
              child: ExtendedImage.network(
                  data.profileImageUrl,
                  width: 60,
                  height: 60,
                  fit: BoxFit.cover,
                  cache: true, loadStateChanged: (state) {
                if (state.extendedImageLoadState == LoadState.failed) {
                  return AspectRatio(
                    aspectRatio: 16 / 9,
                    child: Material(
                      color: purpleColor.withValues(alpha: 0.2),
                      child: Icon(
                        size: 20,
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
              width: 15,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  data.alias,
                  style: Theme.of(context)
                      .textTheme
                      .headlineSmall
                      ?.copyWith(fontSize: 15, fontWeight: bold),
                  overflow: TextOverflow.ellipsis,
                  maxLines: 2,
                ),
                SizedBox(
                  height: 7,
                ),
                Text(
                  data.name,
                  style: Theme.of(context)
                      .textTheme
                      .headlineMedium
                      ?.copyWith(fontSize: 13, fontWeight: regular),
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1,
                ),
              ],
            ),
          ],
        ),
        SizedBox(
          height: 30,
        ),
      ],
    );
  }

  tentang(BuildContext context, DetailOrganizationEntity data) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "About Us",
          style: Theme.of(context)
              .textTheme
              .titleMedium
              ?.copyWith(fontSize: 20, fontWeight: bold),
        ),
        SizedBox(
          height: 5,
        ),
        TextHtml(data: data.description,),
        SizedBox(
          height: 20,
        ),
      ],
    );
  }

  visiMisi(BuildContext context, DetailOrganizationEntity data) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Vision and Mission",
          style: Theme.of(context)
              .textTheme
              .titleMedium
              ?.copyWith(fontSize: 20, fontWeight: bold),
        ),
        SizedBox(
          height: 5,
        ),
        TextHtml(data: data.visionMission),
        SizedBox(
          height: 20,
        ),
      ],
    );
  }

  prestasi(BuildContext context, DetailOrganizationEntity data) {
    List<AchievementEntity> listAchievement = data.achievements;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Our Achievements",
          style: Theme.of(context)
              .textTheme
              .titleMedium
              ?.copyWith(fontSize: 20, fontWeight: bold),
        ),
        SizedBox(
          height: 22,
        ),
        GridView.builder(
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          itemCount: listAchievement.length,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            mainAxisSpacing: 16,
            crossAxisSpacing: 16,
            childAspectRatio: 0.75,
          ),
          itemBuilder: (context, index) {
            return GestureDetector(
              onTap: () {
                showDialog(
                    context: context,
                    builder: (context) =>
                        MoreDiaglog(data: listAchievement[index]));
              },
              child: Container(
                decoration: BoxDecoration(
                    color: whiteColor, borderRadius: BorderRadius.circular(8)),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    AspectRatio(
                      aspectRatio: 1,
                      child: ClipRRect(
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(8),
                            topRight: Radius.circular(8)),
                        child: ExtendedImage.network(
                            listAchievement[index].imageUrl,
                            width: MediaQuery.of(context).size.width / 2,
                            fit: BoxFit.cover,
                            cache: true, loadStateChanged: (state) {
                          if (state.extendedImageLoadState ==
                              LoadState.failed) {
                            return AspectRatio(
                              aspectRatio: 3 / 4,
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
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 10),
                      child: Text(
                        listAchievement[index].title,
                        style: Theme.of(context)
                            .textTheme
                            .bodyLarge
                            ?.copyWith(fontWeight: bold, fontSize: 11),
                        overflow: TextOverflow.ellipsis,
                        maxLines: 2,
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
        SizedBox(height: 28,)
      ],
    );
  }

  galleryActivity(BuildContext context, DetailOrganizationEntity data) {
    List patternGallery = [
      const StaggeredTile.count(3, 3),
      const StaggeredTile.count(2, 1.5),
      const StaggeredTile.count(2, 1.5),
    ];
    if (data.achievements.isEmpty) {
      
    }
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
                Text(
          "Activity Gallery",
          style: Theme.of(context)
              .textTheme
              .titleMedium
              ?.copyWith(fontSize: 20, fontWeight: bold),
        ),
                  SizedBox(
          height: 22,
        ),
        if (data.achievements.isNotEmpty) ...[
        StaggeredGridView.countBuilder(
            crossAxisCount: 5,
            shrinkWrap: true,
            itemCount: 3,
            crossAxisSpacing: 16,
            mainAxisSpacing: 16,
            physics: const NeverScrollableScrollPhysics(),
            staggeredTileBuilder: (index) {
              return patternGallery[index % patternGallery.length];
            },
            itemBuilder: (conetxt, index) {
              if (index == 2) {
                return GestureDetector(
                  onTap: () {
                    showDialog(
                        context: context,
                        builder: (conetxt) =>
                            GalleryPhotos(images: data.activityGallery));
                  },
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: Stack(
                      fit: StackFit.expand,
                      children: [
                        ItemDetailActivityOrganizationImage(urlImage: data.activityGallery, index: index,),
                        Container(
                          color: Colors.black.withValues(alpha: 0.3),
                          alignment: Alignment.center,
                          child: Text(
                            '+ More',
                            style: whiteTextStyle.copyWith(fontWeight: FontWeight.bold,
                                fontSize: 20),
                          ),
                        )
                      ],
                    ),
                  ),
                );
              }
              return ItemDetailActivityOrganizationImage(urlImage: data.activityGallery, index: index,);
            }),
        ],
        
            SizedBox(
              height: 20,
            ),
      ],
    );
  }

  recentPost(BuildContext context, DetailOrganizationEntity data) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Recent posts",
          style: Theme.of(context)
              .textTheme
              .titleMedium
              ?.copyWith(fontSize: 20, fontWeight: bold),
        ),
        SizedBox(
          height: 22,
        ),
        ListView.builder(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            itemCount: data.recentPosts.length,
            itemBuilder: (context, index) {
              return RecentPostItem(data: data.recentPosts[index], name: data.alias, logoUrl: data.profileImageUrl,);
            }),
        SizedBox(
          height: 20,
        ),
      ],
    );
  }
}

class MoreDiaglog extends StatelessWidget {
  final AchievementEntity data;
  const MoreDiaglog({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
  backgroundColor: Colors.transparent,
  insetPadding: EdgeInsets.zero,
  alignment: Alignment.bottomCenter,
  content: Container(
    padding: const EdgeInsets.all(30),
    height: 500,
    width: MediaQuery.of(context).size.width,
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(8),
      color: lightBackgroundColor,
    ),
    child: SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AspectRatio(
            aspectRatio: 1,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: ExtendedImage.network(
                data.imageUrl,
                fit: BoxFit.cover,
                cache: true,
                loadStateChanged: (state) {
                          if (state.extendedImageLoadState ==
                              LoadState.failed) {
                            return AspectRatio(
                              aspectRatio: 3 / 4,
                              child: Material(
                                borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(8),
                                    topRight: Radius.circular(8)),
                                color: purpleColor.withValues(alpha: 0.2),
                                child: Icon(
                                  size: 53,
                                  Icons.broken_image,
                                  color: purpleColor.withValues(alpha: 0.4),
                                ),
                              ),
                            );
                          }
                          return null;
                        }
              ),
            ),
          ),
          const SizedBox(height: 10),
          Text(
            data.title,
            style: Theme.of(context)
                .textTheme
                .bodyLarge
                ?.copyWith(fontWeight: FontWeight.bold, fontSize: 16),
          ),
          const SizedBox(height: 10),
          TextHtml(
            data: data.description,
            fontSizeP: 14,
            fontWeightP: FontWeight.w500,
          ),
        ],
      ),
    ),
  ),
);
  }
}
