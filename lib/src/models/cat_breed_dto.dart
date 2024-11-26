import 'package:freezed_annotation/freezed_annotation.dart';

part 'cat_breed_dto.freezed.dart';

@freezed
class CatBreedDTO with _$CatBreedDTO {
  const factory CatBreedDTO({
    required String id,
    required String name,
    required String description,
    required String origin,
    required int intelligence,
    required int adaptability,
    required String lifeSpan,
    required String imageUrl,
  }) = _CatBreedDTO;
}
