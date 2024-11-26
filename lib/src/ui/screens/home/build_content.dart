import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import '../../../config/app_assets.dart';
import '../../../config/app_colors.dart';
import '../../../notifiers/cat_breeds_notifier.dart';
import '../../widgets/container_image.dart';

class BuildContent extends StatelessWidget {
  final RefreshController refreshController;
  final ScrollController scrollController;
  final AppColors applicationColors;
  final BuildContext context;

  const BuildContent({
    super.key,
    required this.refreshController,
    required this.scrollController,
    required this.applicationColors,
    required this.context,
  });

  @override
  Widget build(BuildContext context) {
    final catBreedsProvider = Provider.of<CatBreedsNotifier>(context);

    final catBreeds = catBreedsProvider.catBreeds;

    return catBreedsProvider.isFirstLoading
        ? const Center(child: CircularProgressIndicator())
        : SmartRefresher(
            controller: refreshController,
            enablePullDown: true,
            onRefresh: _loadCatBreeds,
            header: WaterDropHeader(
              complete: Icon(
                Icons.check,
                color: applicationColors.primaryColor,
              ),
              waterDropColor: applicationColors.primaryColor,
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
    refreshController.refreshCompleted();
  }
}