import 'package:flutter/widgets.dart';
import 'package:slanh_pet_application/features/clinic_detail/widgets/comfirm_booking/time_chip.dart';

class TimeSelection extends StatelessWidget {
  const TimeSelection({
    super.key,
    required this._times,
    required this.selectedIndex,
    required this.onSelected,
  });

  final List<String> _times;
  final int selectedIndex;
  final ValueChanged<int> onSelected;

  @override
  Widget build(BuildContext context) {
    final times = _times;

    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: times.length,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        childAspectRatio: 2.5,
        crossAxisSpacing: 12,
        mainAxisSpacing: 12,
      ),
      itemBuilder: (context, index) {
        return TimeChip(
          time: times[index],
          isSelected: selectedIndex == index,
          onTap: () => onSelected(index),
        );
      },
    );
  }
}
