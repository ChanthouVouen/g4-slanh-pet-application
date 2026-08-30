import 'package:flutter/widgets.dart';
import 'package:slanh_pet_application/features/clinic_detail/models/booking_model.dart';
import 'package:slanh_pet_application/features/clinic_detail/widgets/comfirm_booking/date_tile.dart';

class DateSelection extends StatefulWidget {
  const DateSelection({super.key, required this.dates});
  final List<DateOptionModel> dates;

  @override
  State<DateSelection> createState() => _DateSelectionState();
}

class _DateSelectionState extends State<DateSelection> {
  int _selectedDateIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        for (var index = 0; index < widget.dates.length; index++)
          DateTile(
            dayName: widget.dates[index].dayName,
            dayNumber: widget.dates[index].dayNumber,
            isSelected: _selectedDateIndex == index,
            onTap: () => setState(() => _selectedDateIndex = index),
          ),
      ],
    );
  }
}
