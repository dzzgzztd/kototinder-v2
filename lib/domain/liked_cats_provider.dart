import 'package:flutter/foundation.dart';
import '../data/cat_model.dart';

class LikedCatsNotifier extends ChangeNotifier {
  final List<LikedCat> _likedCats = [];

  List<LikedCat> get likedCats => List.unmodifiable(_likedCats);

  void likeCat(Cat cat) {
    if (!_likedCats.any((c) => c.imageUrl == cat.imageUrl)) {
      _likedCats.add(LikedCat(cat: cat, likedAt: DateTime.now()));
      notifyListeners();
    }
  }

  void removeCat(String imageUrl) {
    _likedCats.removeWhere((c) => c.imageUrl == imageUrl);
    notifyListeners();
  }

  void clear() {
    _likedCats.clear();
    notifyListeners();
  }

  List<LikedCat> filterByBreed(String breed) {
    return _likedCats.where((cat) => cat.breedName == breed).toList();
  }

  List<String> getBreeds() {
    return _likedCats.map((cat) => cat.breedName).toSet().toList();
  }
}
