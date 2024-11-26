import 'package:cat_breeds/src/ui/widgets/info_item.dart';
import 'package:flutter/material.dart';

import '../../../config/app_assets.dart';
import '../../../models/cat_breed_dto.dart';
import '../../widgets/container_image.dart';

class BuildContent extends StatelessWidget {
  final CatBreedDTO catBreed;
  const BuildContent({super.key, required this.catBreed});

  @override
  Widget build(BuildContext context) {
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