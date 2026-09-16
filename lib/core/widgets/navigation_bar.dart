import 'package:flutter/material.dart';

class CustomBottomNavBar extends StatelessWidget {
  const CustomBottomNavBar({
    super.key,
    required this.currentIndex,
    required this.onTap,
    this.items = _defaultItems,
  });

  final int currentIndex;
  final ValueChanged<int> onTap;
  final List<NavBarItemData> items;

  static const _defaultItems = <NavBarItemData>[
    NavBarItemData(icon: Icons.home_rounded, label: 'Home'),
    NavBarItemData(icon: Icons.storefront_rounded, label: 'Market'),
    NavBarItemData(icon: Icons.content_cut_rounded, label: 'Services'),
    NavBarItemData(icon: Icons.receipt_long_rounded, label: 'Orders'),
    NavBarItemData(icon: Icons.person_rounded, label: 'Profile'),
  ];

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.08),
            blurRadius: 16,
            offset: const Offset(0, -4),
          ),
        ],
      ),
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 8),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              for (var index = 0; index < items.length; index++)
                _NavBarItem(
                  data: items[index],
                  selected: index == currentIndex,
                  onTap: () => onTap(index),
                ),
            ],
          ),
        ),
      ),
    );
  }
}

class NavBarItemData {
  const NavBarItemData({required this.icon, required this.label});

  final IconData icon;
  final String label;
}

class _NavBarItem extends StatelessWidget {
  const _NavBarItem({
    required this.data,
    required this.selected,
    required this.onTap,
  });

  final NavBarItemData data;
  final bool selected;
  final VoidCallback onTap;

  static const _selectedColor = Colors.deepOrange;
  static const _unselectedColor = Colors.grey;

  @override
  Widget build(BuildContext context) {
    final color = selected ? _selectedColor : _unselectedColor;
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(16),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: selected
                    ? _selectedColor.withValues(alpha: 0.12)
                    : Colors.transparent,
                borderRadius: BorderRadius.circular(14),
              ),
              child: Icon(data.icon, color: color, size: 24),
            ),
            const SizedBox(height: 2),
            Text(
              data.label,
              style: TextStyle(
                color: color,
                fontSize: 11,
                fontWeight: selected ? FontWeight.w600 : FontWeight.w400,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
