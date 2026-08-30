import 'package:flutter/widgets.dart';
import 'package:slanh_pet_application/features/clinic_detail/widgets/comfirm_booking/time_chip.dart';

class TimeSelection extends StatefulWidget {
  const TimeSelection({super.key, required this._times});
  final List<String> _times;

  @override
  State<TimeSelection> createState() => _TimeSelectionState();
}

class _TimeSelectionState extends State<TimeSelection> {
  int _selectedTimeIndex = -1;

  @override
  Widget build(BuildContext context) {
    final times = widget._times;

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
          isSelected: _selectedTimeIndex == index,
          onTap: () => setState(() => _selectedTimeIndex = index),
        );
      },
    );
  }
}
