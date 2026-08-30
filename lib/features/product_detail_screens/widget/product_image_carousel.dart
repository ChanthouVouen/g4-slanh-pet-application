import 'package:flutter/material.dart';

import '../../map_screen/widgets/round_icon_button.dart';

/// Top image banner with a paw-print pattern background, back/favorite
/// buttons and a paged dot indicator.
class ProductImageCarousel extends StatefulWidget {
  const ProductImageCarousel({
    super.key,
    required this.colors,
    required this.images,
    required this.onBack,
    required this.onToggleFavorite,
    required this.isFavorite,
  });

  final List<Color> colors;
  final List<String> images;
  final VoidCallback onBack;
  final VoidCallback onToggleFavorite;
  final bool isFavorite;

  @override
  State<ProductImageCarousel> createState() => _ProductImageCarouselState();
}

class _ProductImageCarouselState extends State<ProductImageCarousel> {
  final PageController _controller = PageController();
  int _page = 0;

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final pageCount = widget.images.isEmpty ? 1 : widget.images.length;

    return SizedBox(
      height: 300,
      child: Stack(
        fit: StackFit.expand,
        children: [
          PageView.builder(
            controller: _controller,
            itemCount: pageCount,
            onPageChanged: (index) => setState(() => _page = index),
            itemBuilder: (context, index) => _BannerPage(
              colors: widget.colors,
              imageUrl: index < widget.images.length ? widget.images[index] : '',
            ),
          ),
          Positioned(
            top: 12,
            left: 16,
            child: RoundIconButton(icon: Icons.arrow_back, onTap: widget.onBack),
          ),
          Positioned(
            top: 12,
            right: 16,
            child: RoundIconButton(
              icon: widget.isFavorite ? Icons.favorite : Icons.favorite_border,
              onTap: widget.onToggleFavorite,
            ),
          ),
          Positioned(
            bottom: 16,
            left: 0,
            right: 0,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                for (var i = 0; i < pageCount; i++)
                  AnimatedContainer(
                    duration: const Duration(milliseconds: 200),
                    margin: const EdgeInsets.symmetric(horizontal: 3),
                    width: i == _page ? 18 : 6,
                    height: 6,
                    decoration: BoxDecoration(
                      color: i == _page
                          ? Colors.white
                          : Colors.white.withValues(alpha: 0.5),
                      borderRadius: BorderRadius.circular(4),
                    ),
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _BannerPage extends StatelessWidget {
  const _BannerPage({required this.colors, required this.imageUrl});

  final List<Color> colors;
  final String imageUrl;

  @override
  Widget build(BuildContext context) {
    if (imageUrl.isEmpty) return _Placeholder(colors: colors);

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
            _Placeholder(colors: colors),
            const Center(
              child: CircularProgressIndicator(color: Colors.white),
            ),
          ],
        );
      },
      errorBuilder: (context, error, stackTrace) =>
          _Placeholder(colors: colors),
    );
  }
}

class _Placeholder extends StatelessWidget {
  const _Placeholder({required this.colors});

  final List<Color> colors;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: colors,
        ),
      ),
      child: ClipRect(
        child: Stack(
          children: [
            for (final spot in _iconSpots)
              Positioned(
                left: spot.dx,
                top: spot.dy,
                child: Transform.rotate(
                  angle: spot.dx % 2 == 0 ? -0.3 : 0.3,
                  child: Icon(
                    Icons.cookie_outlined,
                    size: 46,
                    color: Colors.white.withValues(alpha: 0.45),
                  ),
                ),
              ),
            Center(
              child: Icon(
                Icons.pets,
                size: 96,
                color: Colors.white.withValues(alpha: 0.85),
              ),
            ),
          ],
        ),
      ),
    );
  }

  static const _iconSpots = [
    Offset(20, 30),
    Offset(280, 40),
    Offset(60, 220),
    Offset(320, 200),
    Offset(160, 20),
    Offset(10, 130),
  ];
}
