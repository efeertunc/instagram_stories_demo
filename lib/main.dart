import 'package:flutter/material.dart';
import 'package:instagram_stories_demo/provider/cube_page_controller_provider.dart';
import 'package:instagram_stories_demo/view/home_page.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (_) => CubePageControllerProvider(),
      child: MyApp(), // Uygulamanızın ana widget'ı
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const HomePage(),
    );
  }
}
