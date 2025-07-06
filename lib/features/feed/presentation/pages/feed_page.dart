import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:simiko/core/theme/app_colors.dart';
import 'package:simiko/core/ui/shared_method.dart';
import 'package:simiko/features/feed/presentation/widgets/feed_placeholder_page.dart';
import 'package:simiko/features/feed/presentation/widgets/post_item.dart';

import '../../../../core/ui/text_failure.dart';
import '../../domain/entities/ukm_feed_entity.dart';
import '../bloc/ukm_feed/ukm_feed_bloc.dart';
import '../widgets/big_event_item.dart';
import '../widgets/small_event.dart';

class FeedPage extends StatefulWidget {
  const FeedPage({super.key});

  @override
  State<FeedPage> createState() => _FeedPageState();
}

class _FeedPageState extends State<FeedPage>
    with SingleTickerProviderStateMixin {
  TabController? _tabController;
  late ScrollController _postScrollController;
  int _selectedIndex = 0;
  List<String> list = [];
  List<UkmFeedEntity> listUkmFeed = [];

  @override
  void initState() {
    super.initState();
    context.read<UkmFeedBloc>().add(GetAllUkmFeedEvent());
    _postScrollController = ScrollController();
  }

  @override
  void dispose() {
    _tabController?.dispose();
    super.dispose();
    _postScrollController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      body: SafeArea(
        child: ListView(
          children: [
            Padding(
              padding: const EdgeInsets.only(
                  left: 16, right: 16, top: 30, bottom: 20),
              child: Text(
                'Stay Updated with the Latest News!',
                style: Theme.of(context)
                    .textTheme
                    .headlineLarge
                    ?.copyWith(fontWeight: bold, color: purpleColor),
              ),
            ),
            BlocConsumer<UkmFeedBloc, UkmFeedState>(
              listener: (context, state) {
                if (state is UkmFeedFailed) {
                  showCustomSnackbar(context, state.message);
                }
              },
              builder: (context, state) {
                if (state is UkmFeedLoading) {
                  return FeedPlaceholderPage();
                } else if (state is UkmFeedLoaded) {
                  listUkmFeed = state.data;
                  list = listUkmFeed.map((e) => e.name).toList();

                  if (list.isEmpty) {
                    return SizedBox(
                      height: height / 1.5,
                      child: TextFailure(message: 'No data available'),
                    );
                  }

                  if (_tabController == null ||
                      _tabController!.length != list.length) {
                    _tabController =
                        TabController(length: list.length, vsync: this)
                          ..addListener(() {
                            setState(() {
                              _selectedIndex = _tabController!.index;
                            });
                          });
                  }

                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      categories(),
                      SizedBox(
                        height: 20,
                      ),
                      buidBody(height)
                    ],
                  );
                }
                return SizedBox(
                  height: height / 1.5,
                  child: TextFailure(message: 'Failed to load data'),
                );
              },
            )
          ],
        ),
      ),
    );
  }

  //TAB SCROLL
  categories() {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: List.generate(list.length, (index) {
          return buildTab(list[index], index);
        }),
      ),
    );
  }

  buildTab(String category, int index) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: GestureDetector(
        onTap: () {
          setState(() {
            _selectedIndex = index;
            _tabController!.index = index;
            _postScrollController.jumpTo(0);
          });
        },
        child: Container(
          margin: EdgeInsets.only(
            left: index == 0 ? 16 : 4,
            right: index == list.length - 1 ? 16 : 4,
            bottom: 10,
            top: 4,
          ),
          padding: EdgeInsets.symmetric(vertical: 6, horizontal: 8),
          decoration: BoxDecoration(
            border: Border.all(color: purpleColor),
            color: _selectedIndex == index ? purpleColor : whiteColor,
            borderRadius: BorderRadius.circular(8),
          ),
          alignment: Alignment.center,
          child: Text(
            category.toUpperCase(),
            style: GoogleFonts.poppins(
              textStyle: TextStyle(
                  color: _selectedIndex == index ? whiteColor : purpleColor,
                  fontWeight: FontWeight.bold,
                  fontSize: 12),
            ),
          ),
        ),
      ),
    );
  }

  //BODY
  buidBody(double height) {
    if (listUkmFeed[_selectedIndex].events.isEmpty || listUkmFeed[_selectedIndex].posts.isEmpty) {
      return SizedBox(
        height: height / 1.5,
        child: TextFailure(message: 'No data available'),
      );
    }
    final selectedFeed = listUkmFeed[_selectedIndex];
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (selectedFeed.posts.isNotEmpty) ...[
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Text(
              "Postingan",
              style: Theme.of(context)
                  .textTheme
                  .titleMedium
                  ?.copyWith(fontSize: 18, fontWeight: bold),
            ),
          ),
          SizedBox(
            height: 16,
          ),
          SizedBox(
            height: 260,
            child: ListView.separated(
              controller: _postScrollController,
              scrollDirection: Axis.horizontal,
              itemCount: selectedFeed.posts.length,
              itemBuilder: (context, index) {
                final post = selectedFeed.posts[index];
                return Container(
                  margin: EdgeInsets.only(
                    left: index == 0 ? 16 : 4,
                    right: index == selectedFeed.posts.length - 1 ? 16 : 4,
                    bottom: 10,
                    top: 4,
                  ),
                  padding: const EdgeInsets.only(bottom: 10),
                  width: MediaQuery.of(context).size.width / 1.5,
                  decoration: BoxDecoration(
                      color: whiteColor,
                      borderRadius: BorderRadius.circular(8)),
                  child: PostItem(
                    post: post,
                    name: selectedFeed.name,
                    logoUrl: selectedFeed.logoUrl!,
                  ),
                );
              },
              separatorBuilder: (_, __) => const SizedBox(width: 12),
            ),
          ),
          SizedBox(
            height: 16,
          ),
        ],
        if (selectedFeed.posts.isNotEmpty) ...[
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Text(
              "Event",
              style: Theme.of(context)
                  .textTheme
                  .titleMedium
                  ?.copyWith(fontSize: 18, fontWeight: bold),
            ),
          ),
          SizedBox(
            height: 16,
          ),
          ListView.builder(
              shrinkWrap: true,
              physics: BouncingScrollPhysics(),
              itemCount: selectedFeed.events.length,
              itemBuilder: (context, index) {
                final event = selectedFeed.events[index];
                if (index == 0) {
                  return BigEvent(
                    event: event,
                    name: selectedFeed.name,
                    logoUrl: selectedFeed.logoUrl!,
                  );
                } else {
                  return SmallEvent(
                    event: event,
                    name: selectedFeed.name,
                    logoUrl: selectedFeed.logoUrl!,
                  );
                }
              }),
        ],
        SizedBox(
          height: 20,
        ),
      ],
    );
  }
}
