import 'dart:async';

import 'package:flutter/material.dart';

import '../../map_screen/widgets/round_icon_button.dart';
import 'banner_page.dart';

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
  Timer? _autoScrollTimer;

  @override
  void initState() {
    super.initState();
    _startAutoScroll();
  }

  void _startAutoScroll() {
    final pageCount = widget.images.isEmpty ? 1 : widget.images.length;
    if (pageCount <= 1) return;

    _autoScrollTimer = Timer.periodic(const Duration(seconds: 3), (_) {
      if (!_controller.hasClients) return;

      final currentPage = _controller.page!.round();

      if (currentPage == pageCount - 1) {
        _controller.jumpToPage(0);
        return;
      }

      _controller.nextPage(
        duration: const Duration(milliseconds: 500),
        curve: Curves.easeInOut,
      );
    });
  }

  @override
  void dispose() {
    _autoScrollTimer?.cancel();
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final pageCount = widget.images.isEmpty ? 1 : widget.images.length;
    // The banner image intentionally bleeds behind the status bar, but the
    // floating buttons on top of it still need to clear it.
    final topInset = MediaQuery.paddingOf(context).top + 12;

    return SizedBox(
      height: 300,
      child: Stack(
        fit: StackFit.expand,
        children: [
          PageView.builder(
            controller: _controller,
            itemCount: pageCount,
            onPageChanged: (index) => setState(() => _page = index),
            itemBuilder: (context, index) => BannerPage(
              colors: widget.colors,
              imageUrl: index < widget.images.length
                  ? widget.images[index]
                  : '',
            ),
          ),
          Positioned(
            top: topInset,
            left: 16,
            child: RoundIconButton(
              icon: Icons.arrow_back,
              onTap: widget.onBack,
            ),
          ),
          Positioned(
            top: topInset,
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
