import 'package:cat_breeds/src/config/app_colors.dart';
import 'package:cat_breeds/src/ui/screens/home/build_content.dart';
import 'package:flutter/material.dart';

import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:provider/provider.dart';

import '../../../config/app_assets.dart';
import '../../../notifiers/cat_breeds_notifier.dart';
import '../../../helpers/search_delegate.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final ScrollController scrollController = ScrollController();
  final RefreshController _refreshController =
      RefreshController(initialRefresh: false);
  final applicationAssets = AppAssets();
  final applicationColors = AppColors();

  @override
  void initState() {
    super.initState();

    final catBreedsProvider =
        Provider.of<CatBreedsNotifier>(context, listen: false);

    scrollController.addListener(() {
      if (scrollController.position.pixels >=
              scrollController.position.maxScrollExtent - 500 &&
          !catBreedsProvider.isLoadingNextPage) {
        catBreedsProvider.getPaginatedCatBreeds();
      }
    });
  }

  @override
  void dispose() {
    scrollController.dispose();
    _refreshController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: applicationColors.backgroundColor,
      appBar: AppBar(
        backgroundColor: applicationColors.primaryColor,
        centerTitle: true,
        title: Text(
          applicationAssets.nameApp,
          style: TextStyle(
            color: applicationColors.whiteColor,
          ),
        ),
        actions: [
          IconButton(
            onPressed: () => showSearch(
                context: context, delegate: CatBreedSearchDelegate()),
            icon: const Icon(Icons.search_outlined),
            color: applicationColors.whiteColor,
          ),
        ],
      ),
      body: BuildContent(
        context: context,
        refreshController: _refreshController,
        scrollController: scrollController,
        applicationColors: applicationColors,
      ),
    );
  }
}
