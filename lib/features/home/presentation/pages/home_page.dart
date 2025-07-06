import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shimmer/shimmer.dart';
import 'package:simiko/core/common/app_route.dart';
import 'package:simiko/core/theme/app_colors.dart';
import 'package:simiko/features/home/presentation/bloc/all_organization/bloc/all_organization_bloc.dart';
import 'package:simiko/features/home/presentation/bloc/top_event/top_event_bloc.dart';
import 'package:simiko/features/home/presentation/widgets/placeholder_organization_item.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../../../../core/ui/text_failure.dart';
import '../../../profile/presentation/bloc/profile_bloc.dart';
import '../widgets/item_organization.dart';
import '../widgets/item_top_event.dart';
import '../widgets/placeholder_profile_home.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late final PageController _topEventController;
  int _pageIndex = 0;

  refresh() {
    context.read<TopEventBloc>().add(GetAllTopEvent());
    context.read<AllOrganizationBloc>().add(GetAllOrganizationEvent());
    context.read<ProfileBloc>().add(GetProfileEvent());
  }

  @override
  void initState() {
    super.initState();
    context.read<TopEventBloc>().add(GetAllTopEvent());
    context.read<AllOrganizationBloc>().add(GetAllOrganizationEvent());
    context.read<ProfileBloc>().add(GetProfileEvent());
    _topEventController = PageController(viewportFraction: 0.8, initialPage: 0);
  }



  @override
  void dispose() {
    _topEventController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator.adaptive(
      onRefresh: () async => refresh(),
      child: SafeArea(
        child: ListView(
          physics: const AlwaysScrollableScrollPhysics(), // ini penting
          shrinkWrap: true, // opsional jika konten pendek
          children: [
            header(),
            event(),
            organization(),
          ],
        ),
      ),
    );
  }

  header() {
    return BlocBuilder<ProfileBloc, ProfileState>(
      builder: (context, state) {
        if (state is ProfileLoading) {
          return PlaceholderProfileHome();
        } else if (state is ProfileFailed) {
          return Center(
            child: TextFailure(message: state.message),
          );
        } else if (state is ProfileLoaded) {
          return Container(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            margin: const EdgeInsets.only(bottom: 20, top: 30),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                GestureDetector(
                  onTap: () {
                    Navigator.pushNamed(context, AppRoute.detailProfilePage,
                        arguments: state.data.photoUrl);
                  },
                  child: Hero(
                      tag: 'detail-profile',
                      child: ClipOval(
                        child: ExtendedImage.network(
                          state.data.photoUrl,
                          fit: BoxFit.cover,
                          width: 45,
                          height: 45,
                          cache: true,
                          loadStateChanged: (state) {
                            if (state.extendedImageLoadState ==
                                LoadState.failed) {
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
                        ),
                      )),
                ),
                const SizedBox(
                  width: 8,
                ),
                Text(
                  state.data.name,
                  style: Theme.of(context).textTheme.titleSmall,
                ),
                const Spacer(),
                Material(
                  color: Colors.transparent,
                  child: InkWell(
                    borderRadius: BorderRadius.circular(32),
                    onTap: () {},
                    child: const Badge(
                      smallSize: 8,
                      backgroundColor: Colors.red,
                      alignment: Alignment(0.6, -0.6),
                      child: Icon(Icons.notifications_none, size: 28),
                    ),
                  ),
                )
              ],
            ),
          );
        }
        return const SizedBox(
          height: 10,
        );
      },
    );
  }

  //EVENT
  event() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Text(
            "Today’s Update",
            style: Theme.of(context)
                .textTheme
                .titleMedium
                ?.copyWith(fontSize: 18, fontWeight: bold),
          ),
        ),
        SizedBox(
          height: 16,
        ),
        BlocBuilder<TopEventBloc, TopEventState>(
          builder: (context, state) {
            if (state is TopEventLoading) {
              return Padding(
                padding: const EdgeInsets.only(left: 16, right: 16, bottom: 16),
                child: Shimmer.fromColors(
                  baseColor: Colors.black26,
                  highlightColor: Colors.black54,
                  child: AspectRatio(
                    aspectRatio: 16 / 9,
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(4),
                        color: Colors.black38,
                      ),
                    ),
                  ),
                ),
              );
            } else if (state is TopEventFailed) {
              return Padding(
                padding: const EdgeInsets.only(left: 16, right: 16, bottom: 16),
                child: TextFailure(message: state.message),
              );
            }
            if (state is TopEventLoaded) {
              return AspectRatio(
                aspectRatio: 16 / 9,
                child: PageView.builder(
                    itemCount: 10000,
                    controller: _topEventController,
                    physics: const BouncingScrollPhysics(),
                    onPageChanged: (value) {
                      setState(() {
                        _pageIndex = value % state.data.length;
                      });
                    },
                    itemBuilder: (context, index) {
                      final i = index % state.data.length;
                      return ItemTopEvent(
                        isActive: _pageIndex == i,
                        entity: state.data[i],
                      );
                    }),
              );
            }
            return const SizedBox(
              height: 120,
            );
          },
        ),
        BlocBuilder<TopEventBloc, TopEventState>(
          builder: (context, state) {
            if (state is TopEventLoaded) {
              return Center(
                child: SmoothPageIndicator(
                  controller: _topEventController,
                  count: state.data.length,
                  effect: ScrollingDotsEffect(
                    maxVisibleDots: 5,
                    spacing: 8,
                    radius: 8,
                    dotHeight: 7,
                    dotWidth: 7,
                    activeDotColor: Colors.purple,
                    dotColor: Colors.purple.shade100,
                  ),
                ),
              );
            }
            return const SizedBox();
          },
        ),
        const SizedBox(
          height: 20,
        ),
      ],
    );
  }

  //ORGANIZATION
  organization() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Organization",
            style: Theme.of(context)
                .textTheme
                .titleMedium
                ?.copyWith(fontSize: 18, fontWeight: bold),
          ),
          SizedBox(
            height: 16,
          ),
          BlocBuilder<AllOrganizationBloc, AllOrganizationState>(
            builder: (context, state) {
              if (state is AllOrganizationLoading) {
                return ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: 4,
                    itemBuilder: (context, index) {
                      return PlaceholderOrganizationItem();
                    });
              } else if (state is AllOrganizationFailed) {
                return Padding(
                  padding:
                      const EdgeInsets.only(left: 16, right: 16, bottom: 16),
                  child: TextFailure(message: state.message),
                );
              } else if (state is AllOrganizationLoaded) {
                return ListView.builder(
                  itemCount: 4,
                  shrinkWrap: true,
                  physics: const BouncingScrollPhysics(),
                  itemBuilder: (context, index) {
                    return ItemOrganization(entity: state.data[index]);
                  },
                );
              }
              return const SizedBox(
                height: 120,
              );
            },
          )
        ],
      ),
    );
  }
}
