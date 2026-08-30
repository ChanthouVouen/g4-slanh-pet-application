import 'package:flutter/material.dart';

/// Promo banner advertising online vet consultations.
class VetPromoBanner extends StatelessWidget {
  const VetPromoBanner({super.key, required this.onBookNow});

  final VoidCallback onBookNow;

  static const String _imageUrl =
      'https://images.ctfassets.net/rt5zmd3ipxai/26K0fek1EVVljWvoxMvqHD/'
      '64c39170810e3e7b063b49a24db028dd/NVA-Clinic-cat-vet-holding-left.jpg'
      '?fit=fill&fm=webp&h=1134&w=2970&q=75';
  static const Color _fallbackColor = Color(0xFF3E7BFA);

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(20),
      child: Container(
        height: 150,
        color: _fallbackColor,
        child: Stack(
          fit: StackFit.expand,
          children: [
            Image.network(
              _imageUrl,
              fit: BoxFit.cover,
              loadingBuilder: (context, child, progress) =>
                  progress == null ? child : const SizedBox.shrink(),
              errorBuilder: (context, error, stackTrace) =>
                  const SizedBox.shrink(),
            ),

            const DecoratedBox(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.centerLeft,
                  end: Alignment.centerRight,
                  colors: [Colors.black54, Colors.transparent],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    'Online consultation available',
                    style: TextStyle(
                      color: Colors.white70,
                      fontSize: 12.5,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 6),
                  const Text(
                    'Book a Vet Now',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                  const SizedBox(height: 14),
                  _buildBookButton(context),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBookButton(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return Material(
      color: colorScheme.surface,
      borderRadius: BorderRadius.circular(100),
      child: InkWell(
        borderRadius: BorderRadius.circular(100),
        onTap: onBookNow,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: Text(
            'Book from RM25',
            style: TextStyle(
              fontSize: 12.5,
              fontWeight: FontWeight.w700,
              color: colorScheme.onSurface,
            ),
          ),
        ),
      ),
    );
  }
}
