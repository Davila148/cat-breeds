import 'package:cat_breeds/src/config/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:provider/provider.dart';

import '../../config/app_assets.dart';
import '../../notifiers/cat_breeds_notifier.dart';
import '../../helpers/search_delegate.dart';
import '../widgets/container_image.dart';

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
      body: _buildContent(context),
    );
  }

  Widget _buildContent(BuildContext context) {
    final catBreedsProvider = Provider.of<CatBreedsNotifier>(context);

    final catBreeds = catBreedsProvider.catBreeds;

    return catBreedsProvider.isFirstLoading
        ? const Center(child: CircularProgressIndicator())
        : SmartRefresher(
            controller: _refreshController,
            enablePullDown: true,
            onRefresh: _loadCatBreeds,
            header: WaterDropHeader(
              complete: Icon(
                Icons.check,
                color: AppColors().primaryColor,
              ),
              waterDropColor: AppColors().primaryColor,
            ),
            child: ListView.builder(
              controller: scrollController,
              itemCount: catBreeds.length,
              itemBuilder: (_, index) {
                final currentCatBreed = catBreeds[index];
                final isLastCatBreed = index == catBreeds.length - 1;

                return Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16.0,
                        vertical: 8.0,
                      ),
                      child: GestureDetector(
                        onTap: () => GoRouter.of(context).push(
                          '/details-screen',
                          extra: catBreeds[index],
                        ),
                        child: Card(
                          margin: EdgeInsets.zero,
                          elevation: 5.0,
                          color: applicationColors.whiteColor,
                          child: Column(
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(12.0),
                                child: Align(
                                  alignment: Alignment.centerLeft,
                                  child: Text(
                                    currentCatBreed.name,
                                    style: const TextStyle(
                                      fontSize: 20.0,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: 250.0,
                                width: double.infinity,
                                child: Hero(
                                  tag: currentCatBreed.id,
                                  child: currentCatBreed.imageUrl.isNotEmpty
                                      ? CustomImageContainer(
                                          imageUrl: currentCatBreed.imageUrl)
                                      : Image.asset(AppAssets.imageNotFound),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(12.0),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(currentCatBreed.origin),
                                    Text(
                                        'Intelligence: ${currentCatBreed.intelligence}'),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    if (catBreedsProvider.isLoadingNextPage && isLastCatBreed)
                      const Padding(
                        padding: EdgeInsets.all(16.0),
                        child: Center(
                          child: CircularProgressIndicator(),
                        ),
                      ),
                  ],
                );
              },
            ),
          );
  }

  void _loadCatBreeds() async {
    final catBreedsProvider =
        Provider.of<CatBreedsNotifier>(context, listen: false);
    await catBreedsProvider.refreshCatBreeds();
    _refreshController.refreshCompleted();
  }
}
