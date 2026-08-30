import 'package:flutter/material.dart';

import 'map_search_field.dart';
import 'round_icon_button.dart';

class MapTopBar extends StatelessWidget {
  const MapTopBar({
    super.key,
    required this.onBack,
    required this.onSearchChanged,
  });

  final VoidCallback onBack;
  final ValueChanged<String> onSearchChanged;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      bottom: false,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(20, 12, 20, 0),
        child: Row(
          children: [
            RoundIconButton(icon: Icons.arrow_back_rounded, onTap: onBack),
            const SizedBox(width: 12),
            Expanded(child: MapSearchField(onChanged: onSearchChanged)),
          ],
        ),
      ),
    );
  }
}
