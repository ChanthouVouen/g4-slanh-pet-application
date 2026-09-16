import 'package:flutter/material.dart';
import 'package:slanh_pet_application/core/constants/app_colors.dart';

/// White rounded card with a soft shadow, used to group a section of
/// content (e.g. a titled block on a checkout or booking screen).
class SectionCard extends StatelessWidget {
  const SectionCard({super.key, required this.children});

  final List<Widget> children;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: const [
          BoxShadow(color: Colors.black12, blurRadius: 6, offset: Offset(0, 2)),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: children,
      ),
    );
  }
}

/// Icon + title row used as a [SectionCard] header, with an optional
/// trailing action (e.g. a "Change" button).
class SectionHeader extends StatelessWidget {
  const SectionHeader(this.icon, this.title, {super.key, this.trailing});

  final IconData icon;
  final String title;
  final Widget? trailing;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(icon, color: AppColors.orange, size: 20),
        const SizedBox(width: 8),
        Expanded(
          child: Text(
            title,
            style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w700),
          ),
        ),
        ?trailing,
      ],
    );
  }
}
