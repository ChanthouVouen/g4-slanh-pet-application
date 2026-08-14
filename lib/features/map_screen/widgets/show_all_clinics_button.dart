import 'package:flutter/material.dart';

/// Toggle pill that filters the map/list down to clinics only.
class ShowAllClinicsButton extends StatelessWidget {
  const ShowAllClinicsButton({
    super.key,
    required this.active,
    required this.onTap,
  });

  static const Color orange = Color(0xFFFF663C);

  final bool active;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: active ? orange : Colors.white,
      borderRadius: BorderRadius.circular(100),
      elevation: 3,
      shadowColor: Colors.black.withValues(alpha: 0.15),
      child: InkWell(
        borderRadius: BorderRadius.circular(100),
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                Icons.local_hospital_rounded,
                size: 16,
                color: active ? Colors.white : orange,
              ),
              const SizedBox(width: 8),
              Text(
                active ? 'Showing all clinics' : 'Show all clinics',
                style: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w700,
                  color: active ? Colors.white : const Color(0xFF2B333B),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
