import 'package:flutter/widgets.dart';
import 'package:slanh_pet_application/features/clinic_detail/models/booking_model.dart';
import 'package:slanh_pet_application/features/clinic_detail/widgets/comfirm_booking/date_tile.dart';

class DateSelection extends StatelessWidget {
  const DateSelection({
    super.key,
    required this.dates,
    required this.selectedIndex,
    required this.onSelected,
  });

  final List<DateOptionModel> dates;
  final int selectedIndex;
  final ValueChanged<int> onSelected;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        for (var index = 0; index < dates.length; index++)
          DateTile(
            dayName: dates[index].dayName,
            dayNumber: dates[index].dayNumber,
            isSelected: selectedIndex == index,
            onTap: () => onSelected(index),
          ),
      ],
    );
  }
}
