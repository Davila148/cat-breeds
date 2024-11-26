class CatBreedDTO {
  final String id;
  final String name;
  final String description;
  final String origin;
  final int intelligence;
  final int adaptability;
  final String lifeSpan;
  final String imageUrl;

  CatBreedDTO({
    required this.id,
    required this.name,
    required this.description,
    required this.origin,
    required this.intelligence,
    required this.adaptability,
    required this.lifeSpan,
    required this.imageUrl,
  });
}
