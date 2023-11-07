import 'package:flutter/material.dart';

class StoryImage extends StatelessWidget {
  final String? imageUrl;
  final VoidCallback? onLoaded;

  const StoryImage({required this.imageUrl, this.onLoaded, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (imageUrl == null || imageUrl!.isEmpty) {
      return const Center(child: Text('There is no image URL'));
    }

    return FutureBuilder<void>(
      future: _loadImage(context),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          return Image.network(
            imageUrl!,
            fit: BoxFit.cover,
            errorBuilder: (context, error, stackTrace) {
              return const Center(child: Text('Resim yüklenemedi'));
            },
          );
        } else {
          return const Center(child: CircularProgressIndicator());
        }
      },
    );
  }

  Future<void> _loadImage(BuildContext context) async {
    try {
      await precacheImage(NetworkImage(imageUrl!), context);
      onLoaded?.call();
    } catch (e) {
      // Handle error if needed
    }
  }
}
