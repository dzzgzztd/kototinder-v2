import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'cat_card.dart';
import '../data/cat_api.dart';
import 'cat_action_buttons.dart';
import '../data/cat_model.dart';
import '../domain/liked_cats_provider.dart';
import 'liked_cats_screen.dart';

// Основной экран приложения
class CatHomeScreen extends StatefulWidget {
  const CatHomeScreen({super.key});

  @override
  CatHomeScreenState createState() => CatHomeScreenState();
}

class CatHomeScreenState extends State<CatHomeScreen> {
  int _likeCount = 0;
  String _imageUrl = '';
  String _breedName = '';
  String _breedDescription = '';
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _fetchCat();
  }

  Future<void> _fetchCat() async {
    if (!mounted) return;

    setState(() {
      _isLoading = true;
    });

    try {
      final cat = await fetchCatWithBreed();

      if (!mounted) return;

      setState(() {
        _imageUrl = cat.imageUrl;
        _breedName = cat.breedName;
        _breedDescription = cat.breedDescription;
      });
    } catch (e) {
      if (mounted) {
        showDialog(
          context: context,
          builder:
              (context) => AlertDialog(
                title: const Text('Ошибка сети'),
                content: Text('Не удалось загрузить кота.\n$e'),
                actions: [
                  TextButton(
                    onPressed: () => Navigator.pop(context),
                    child: const Text('ОК'),
                  ),
                ],
              ),
        );
      }
    } finally {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  void _likeCat() {
    final likedCat = Cat(
      imageUrl: _imageUrl,
      breedName: _breedName,
      breedDescription: _breedDescription,
    );

    context.read<LikedCatsNotifier>().likeCat(likedCat);

    setState(() {
      _likeCount++;
    });
    _fetchCat();
  }

  void _dislikeCat() {
    _fetchCat();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Image.asset('assets/title.png', height: 40),
        centerTitle: true,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 8),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: SizedBox(
              height: 48,
              child: ElevatedButton.icon(
                icon: const Icon(Icons.favorite, size: 24),
                label: const Text(
                  'Лайкнутые коты',
                  style: TextStyle(fontSize: 16),
                ),
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                ),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => const LikedCatsScreen()),
                  );
                },
              ),
            ),
          ),
          const SizedBox(height: 16),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Spacer(flex: 2),
                _isLoading
                    ? const Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [CircularProgressIndicator()],
                    )
                    : CatCard(
                      imageUrl: _imageUrl,
                      breedName: _breedName,
                      breedDescription: _breedDescription,
                      onLike: _likeCat,
                      onDislike: _dislikeCat,
                    ),
                const Spacer(flex: 3),
              ],
            ),
          ),
        ],
      ),
      bottomNavigationBar: CatActionButtons(
        likeCount: _likeCount,
        onLike: _likeCat,
        onDislike: _dislikeCat,
      ),
    );
  }
}
