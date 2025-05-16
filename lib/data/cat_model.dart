class Cat {
  final String imageUrl;
  final String breedName;
  final String breedDescription;

  Cat({
    required this.imageUrl,
    required this.breedName,
    required this.breedDescription,
  });

  factory Cat.fromJson(Map<String, dynamic> json) {
    final breeds = json['breeds'] as List<dynamic>? ?? [];

    return Cat(
      imageUrl: json['url'] ?? '',
      breedName: breeds.isNotEmpty ? breeds[0]['name'] ?? 'Unknown' : 'Unknown',
      breedDescription: breeds.isNotEmpty ? breeds[0]['description'] ?? '' : '',
    );
  }
}

class LikedCat {
  final Cat cat;
  final DateTime likedAt;

  LikedCat({
    required this.cat,
    required this.likedAt,
  });

  String get imageUrl => cat.imageUrl;
  String get breedName => cat.breedName;
  String get breedDescription => cat.breedDescription;
}
