import 'package:cat_breeds/src/ui/screens/details/build_content.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../config/app_colors.dart';
import '../../../models/cat_breed_dto.dart';

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
              primaryColor: AppColors().whiteColor,
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
              child: BuildContent(catBreed: catBreed),
            ),
          )
        : Scaffold(
            backgroundColor: AppColors().backgroundColor,
            appBar: AppBar(
              backgroundColor: AppColors().primaryColor,
              centerTitle: true,
              iconTheme: IconThemeData(
                color: AppColors().whiteColor,
              ),
              title: Text(
                catBreed.name,
                style: TextStyle(
                  color: AppColors().whiteColor,
                ),
              ),
            ),
            body: BuildContent(catBreed: catBreed),
          );
  }
}
