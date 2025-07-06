import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:simiko/core/theme/app_colors.dart';
import 'package:simiko/features/home/domain/entities/organization_entity.dart';
import 'package:simiko/features/home/presentation/widgets/item_organization.dart';
import '../../../../core/ui/shared_method.dart';
import '../bloc/search_organization/search_bloc.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final searchController = TextEditingController();
  List<OrganizationEntity> filteredData = [];
  bool isSearching = false;

  @override
  void initState() {
    context.read<SearchBloc>().add(GetResetSearchEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: Stack(
        children: [
          Container(
            color: lightBackgroundColor,
            padding: const EdgeInsets.only(left: 16, right: 16, top: 49),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Explore Amikom \nStudent Life',
                  style: Theme.of(context)
                      .textTheme
                      .headlineLarge
                      ?.copyWith(fontWeight: bold, color: purpleColor),
                ),
                const SizedBox(height: 20),
                buildSearch(),
              ],
            ),
          ),
          BlocConsumer<SearchBloc, SearchState>(
            listener: (context, state) {
              if (state is SearchLoaded) {
                setState(() {
                  filteredData = state.data;
                  isSearching = true;
                });
              } else if (state is SearchFailed) {
                showCustomSnackbar(context, state.message);
                setState(() {
                  isSearching = false;
                });
              }
            },
            builder: (context, state) {
              return Positioned(
                top: 220,
                left: 0,
                right: 0,
                bottom: 0,
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border(
                      top: BorderSide(
                        color: greyColor, // warna garis
                        width: 0.5, // ketebalan garis
                      ),
                    ),
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(16),
                      topRight: Radius.circular(16),
                    ),
                  ),
                  child: isSearching && filteredData.isNotEmpty
                      ? ListView.builder(
                          padding: const EdgeInsets.only(top: 30, bottom: 30),
                          itemCount: filteredData.length,
                          physics: const BouncingScrollPhysics(),
                          itemBuilder: (context, index) => Container(
                            margin: const EdgeInsets.symmetric(
                              horizontal: 24,
                            ),
                            child:
                                ItemOrganization(entity: filteredData[index]),
                          ),
                        )
                      : Center(
                          child: Text(
                            isSearching ? 'No results found' : 'Search',
                            style: greyTextStyle.copyWith(
                                fontSize: 14, fontWeight: medium),
                          ),
                        ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  buildSearch() {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(
          color: purpleColor,
          width: 1,
        ),
        borderRadius: BorderRadius.circular(8),
      ),
      child: CupertinoSearchTextField(
        controller: searchController,
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 10),
        backgroundColor: purpleColor.withValues(alpha: 0.1),
        style: blackTextStyle.copyWith(fontSize: 14, fontWeight: regular),
        itemColor: blackColor,
        placeholder: 'Find student organizations...',
        placeholderStyle:
            blackTextStyle.copyWith(fontSize: 14, fontWeight: regular),
        onChanged: (value) {
          if (value.isNotEmpty) {
            Future.delayed(const Duration(milliseconds: 500), () {
              context.read<SearchBloc>().add(GetSearchEvent(query: value));
            });
          } else {
            setState(() {
              isSearching = false;
              filteredData = [];
            });
          }
        },
        onSubmitted: (String value) {
          context.read<SearchBloc>().add(GetSearchEvent(query: value));
        },
      ),
    );
  }
}


