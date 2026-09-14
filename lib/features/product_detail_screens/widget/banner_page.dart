import 'package:flutter/material.dart';

import 'carousel_placeholder.dart';

class BannerPage extends StatelessWidget {
  const BannerPage({super.key, required this.colors, required this.imageUrl});

  final List<Color> colors;
  final String imageUrl;

  @override
  Widget build(BuildContext context) {
    if (imageUrl.isEmpty) return CarouselPlaceholder(colors: colors);

    return Image.network(
      imageUrl,
      fit: BoxFit.cover,
      width: double.infinity,
      height: double.infinity,
      loadingBuilder: (context, child, progress) {
        if (progress == null) return child;
        return Stack(
          fit: StackFit.expand,
          children: [
            CarouselPlaceholder(colors: colors),
            const Center(child: CircularProgressIndicator(color: Colors.white)),
          ],
        );
      },
      errorBuilder: (context, error, stackTrace) =>
          CarouselPlaceholder(colors: colors),
    );
  }
}
