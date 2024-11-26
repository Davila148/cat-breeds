import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../config/app_assets.dart';
import '../../config/app_colors.dart';
import '../../models/cat_breed_dto.dart';
import '../widgets/container_image.dart';
import '../widgets/info_item.dart';

class DetailsScreen extends StatelessWidget {
  final CatBreedDTO catBreed;

  const DetailsScreen({
    required this.catBreed,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Theme.of(context).platform == TargetPlatform.iOS
        ? CupertinoTheme(
            data: CupertinoThemeData(
              primaryColor: AppColors()
                  .whiteColor, // Cambia el color de los íconos automáticamente
            ),
            child: CupertinoPageScaffold(
              backgroundColor: AppColors().backgroundColor,
              navigationBar: CupertinoNavigationBar(
                middle: Text(
                  catBreed.name,
                  style: TextStyle(
                    color: AppColors().whiteColor,
                  ),
                ),
                backgroundColor: AppColors().primaryColor,
              ),
              child: _buildContent(context),
            ),
          )
        : Scaffold(
            backgroundColor: AppColors().backgroundColor,
            appBar: AppBar(
              backgroundColor: AppColors().primaryColor,
              centerTitle: true,
              iconTheme: IconThemeData(
                color: AppColors().whiteColor, // Cambia el color del ícono aquí
              ),
              title: Text(
                catBreed.name,
                style: TextStyle(
                  color: AppColors().whiteColor,
                ),
              ),
            ),
            body: _buildContent(context),
          );
  }

  Column _buildContent(BuildContext context) {
    return Column(
      children: [
        ConstrainedBox(
          constraints: const BoxConstraints(
            maxHeight: 500.0,
            minHeight: 300.0,
            minWidth: double.infinity,
          ),
          child: Hero(
            tag: catBreed.id,
            child: catBreed.imageUrl.isNotEmpty
                ? CustomImageContainer(imageUrl: catBreed.imageUrl)
                : Image.asset(AppAssets.imageNotFound),
          ),
        ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.only(top: 12.0, right: 8.0, bottom: 12.0),
            child: Scrollbar(
              // trackVisibility: true,
              thumbVisibility: true,
              radius: const Radius.circular(20.0),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 14.0),
                child: SingleChildScrollView(
                  physics: Theme.of(context).platform == TargetPlatform.iOS
                      ? const BouncingScrollPhysics()
                      : const ClampingScrollPhysics(),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      InfoItem(
                        boldText: 'Description',
                        normalText: catBreed.description,
                      ),
                      const SizedBox(height: 14.0),
                      InfoItem(
                        boldText: 'Country of Origin',
                        normalText: catBreed.origin,
                      ),
                      const SizedBox(height: 14.0),
                      InfoItem(
                        boldText: 'Intelligence',
                        normalText: '${catBreed.intelligence}',
                      ),
                      const SizedBox(height: 14.0),
                      InfoItem(
                        boldText: 'Adaptability',
                        normalText: '${catBreed.adaptability}',
                      ),
                      const SizedBox(height: 14.0),
                      InfoItem(
                        boldText: 'Life Span',
                        normalText: '${catBreed.lifeSpan}  Years',
                      ),
                      const SizedBox(height: 14.0),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
