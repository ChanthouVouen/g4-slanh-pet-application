import 'package:flutter/material.dart';

import 'round_icon_button.dart';

class MapSideControls extends StatelessWidget {
  const MapSideControls({
    super.key,
    required this.isFollowingUser,
    required this.onRecenter,
  });

  final bool isFollowingUser;
  final VoidCallback onRecenter;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      bottom: false,
      child: Align(
        alignment: Alignment.topRight,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(0, 72, 20, 0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              RoundIconButton(
                icon: isFollowingUser
                    ? Icons.my_location
                    : Icons.location_searching,
                onTap: onRecenter,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
