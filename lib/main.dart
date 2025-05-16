import 'package:flutter/material.dart';
import 'presentation/cat_home_screen.dart';
import 'package:provider/provider.dart';
import 'domain/liked_cats_provider.dart';
import 'di.dart';

void main() {
  setupDependencies();
  runApp(
    ChangeNotifierProvider<LikedCatsNotifier>.value(
      value: getIt<LikedCatsNotifier>(),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Cat App',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: CatHomeScreen(),
    );
  }
}
